#!/bin/bash

REPO_DIR=$(basename "$REPO_URL" .git)

# Function to update the repository
update_repo() {
    # Get the latest commit hash from the remote repository
    remote_hash=$(git ls-remote --heads origin $BRANCH_NAME | awk '{print $1}')

    # Compare bad commit hash with remote hash
    for hash in "${bad_commit_hashes[@]}"; do
      echo "bad hash: $hash"
      echo "remote hash: $remote_hash"
      if [ "$remote_hash" = "$hash" ]; then
        echo "[*] Bad commit detected on remote repository. Pull aborted..."
        return 1
      fi
    done

    # Get the latest commit hash from the local repository
    local_hash=$(git rev-parse $BRANCH_NAME)
    
    if [ "$remote_hash" != "$local_hash" ]; then
      echo "[*] Changes detected, pulling latest changes..."
      git pull
      return 0
    else
      return 1
    fi
}

previous_commit() {
  bad_commit_hashes=()
  current_commit=$(git rev-parse HEAD)
  bad_commit_hashes+=("$current_commit")
  
  if ! git checkout $BRANCH_NAME; then
    echo "[*] Error: Failed to checkout the branch $BRANCH_NAME"
    return 1
  fi

  previous_hash=$(git rev-parse HEAD^1)
  if [ -z "$previous_hash" ]; then
    echo "[*] Error: Failed to get the previous commit hash"
    return 1
  fi

  if ! git reset --hard $previous_hash; then
    echo "[*] Error: Failed to reset to the previous commit $previous_hash"
    return 1
  fi

  current_hash=$(git rev-parse HEAD)
 
  if [ "$current_hash" != "$previous_hash" ]; then
    echo "[*] Error: The reset to the previous commit $previous_hash failed"
    return 1
  fi
  
  echo "[*] Successfully rolled back to the previous commit $previous_hash"
  return 0
}

# Function to clone the repository
clone_repo() {
  if [ ! -d "$REPO_DIR" ]; then
    echo "[*] Cloning the repository..."
    if ! git clone "$REPO_URL" "$REPO_DIR"; then
      echo "[*] Error: Failed to clone the repository"
      exit 1
    fi
    cd "$REPO_DIR"
  else
    echo "[*] Repository directory already exists, pulling latest changes..."
    cd "$REPO_DIR"
    if ! git pull; then
      echo "[*] Error: Failed to pull the latest changes"
      exit 1
    fi
  fi
}

# Function to determine the JavaScript framework
determine_framework() {
  if command -v npm > /dev/null; then
    # Check for React
    if npm ls --depth=0 | grep "react-scripts" > /dev/null; then
      FRAMEWORK="React (Create React App)"
    # Check for Vue.js
    elif npm ls --depth=0 | grep "vue" > /dev/null; then
      FRAMEWORK="Vue.js (CLI)"
    # Check for Vite with React
    elif npm ls --depth=0 | grep "vite-react" > /dev/null; then
      FRAMEWORK="Vite-react.js"
    # Check for Astro
    elif npm ls --depth=0 | grep "astro" > /dev/null; then
      FRAMEWORK="Astro.js"
    # Check for absence of common framework identifiers and presence of HTML files
    elif [ "$(find . -maxdepth 1 -name '*.html' | wc -l)" -gt 0 ]; then
      FRAMEWORK="Static"
    else
      FRAMEWORK="Unknown"
    fi
  else
    echo "[*] npm not found. Cannot determine the JavaScript framework."
    exit 1
  fi
  echo "[*] FRAMEWORK DETECTED: $FRAMEWORK"
}



# Function to install dependencies and build the application
install_and_build() {
  source /usr/local/nvm/nvm.sh

  if [ -n "$NODE_VERSION" ]; then
    nvm install "$NODE_VERSION" && nvm use "$NODE_VERSION" || {
    echo "[*] Error installing or using $NODE_VERSION. Using default node version..."
    }
  else
    echo "[*] NODE_VERSION not specified. Using default node version..."
  fi

  # Installing dependencies
  echo "[*] Installing dependencies..."
  npm install

  if [ "$FRAMEWORK" = "Astro.js" ]; then
    if ! command -v astro > /dev/null; then
      echo "[*] Astro not installed. Installing it..."
      npm install -g astro
    else
      echo "[*] Astro is installed."
    fi
  fi

  if [ "$?" -eq 0 ]; then
    echo "npm install successfull"
  fi

  # Pre build commands
  echo "[*] Checking if any pre build commands are provided..."
  if [ -n "$PRE_BUILD" ]; then
    echo "[*] Running $PRE_BUILD"
    eval "$PRE_BUILD"
  else
    echo "[*] No pre build commands provided..."
  fi

  # Executing the build command
  echo "[*] Building the application..."
  if [ -n "$BUILD_COMMAND" ]; then
    eval "$BUILD_COMMAND"
  else
    npm run build
  fi
  
  if [ "$?" -eq 0 ]; then
    echo "[*] Application built successfully. No broken changes detected..."
  else
    echo "[*] Broken changes detected. Rolling back to the previous commit..."
    if previous_commit; then
    	install_and_build
    else
	echo "[*] Something went wrong."
    fi
  fi
}

# Function to serve the application
serve_app() {
  # Installing serve if not already installed
  if ! command -v serve &> /dev/null; then
    echo "[*] Installing serve..."
    npm install -g serve
  fi

  # Check if there's an existing server running and kill it
  if [ -f "$SERVE_PID" ]; then
    kill "$SERVE_PID" &> /dev/null
  fi

  if [ "$FRAMEWORK" = "React (Create React App)" ]; then
    echo "[*] Serving the latest build from 'build' directory..."
    nohup serve -s build & > /dev/null
    SERVE_PID=$!

  elif [ "$FRAMEWORK" = "Vue.js (CLI)" ] || [ "$FRAMEWORK" = "Astro.js" ] || [ "$FRAMEWORK" = "Vite-react.js" ]; then
    echo "[*] Serving the latest build from 'dist' directory..."
    nohup serve -s dist & > /dev/null
    SERVE_PID=$!

  elif [ "$FRAMEWORK" = "Static" ]; then
    echo "[*] Serving directly"
    nohup serve & > /dev/null
    SERVE_PID=$!

  else
    echo "[*] Unknown build directory"
    exit 1
  fi
}

clone_repo
determine_framework
# Condition to skip install_and_build for static sites
if [ "$FRAMEWORK" != "Static" ]; then
  install_and_build
fi

serve_app


while true; do
  sleep 4
  if update_repo; then
    install_and_build
    kill "$SERVE_PID" &> /dev/null
    serve_app
  fi

done
