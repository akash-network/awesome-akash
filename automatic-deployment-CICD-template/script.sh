#!/bin/bash

REPO_DIR=$(basename "$REPO_URL" .git)

# Function to update the repository
update_repo() {
    # Get the latest commit hash from the remote repository
    remote_hash=$(git ls-remote --heads origin $BRANCH_NAME | awk '{print $1}')

    # Get the latest commit hash from the local repository
    local_hash=$(git rev-parse $BRANCH_NAME)

    if [ "$remote_hash" != "$local_hash" ]; then
      echo "[*] Changes detected, pulling latest changes..."
      git pull
      return 0
    else
      echo "[*] No changes detected."
      return 1
    fi
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
    if npm ls --depth=0 | grep "react-scripts" > /dev/null; then
      FRAMEWORK="React (Create React App)"
    elif npm ls --depth=0 | grep "vue" > /dev/null; then
      FRAMEWORK="Vue.js (CLI)"
    elif npm ls --depth=0 | grep "vite-react" > /dev/null; then
      FRAMEWORK="Vite-react.js"
    elif npm ls --depth=0 | grep "astro" > /dev/null; then
      FRAMEWORK="Astro.js"
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
  # if [ -n "$NODE_VERSION" ]; then
  #   if ! command -v nvm &> /dev/null; then
  #     echo "nvm not installed. Installing it..."
  #     curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

  #     # Setting environment variables and sourcing the config file
  #     export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  #     [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  #   fi

  #   # Switching to specified Node.js version
  #   echo "Switching to Node.js version $NODE_VERSION..."
  #   nvm use "$NODE_VERSION"
  # fi

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
    nohup serve build & > /dev/null
    SERVE_PID=$!

  elif [ "$FRAMEWORK" = "Vue.js (CLI)" ] || [ "$FRAMEWORK" = "Astro.js" ] || [ "$FRAMEWORK" = "Vite-react.js" ]; then
    echo "[*] Serving the latest build from 'dist' directory..."
    nohup serve dist & > /dev/null
    SERVE_PID=$!

  else
    echo "[*] Unknown build directory"
    exit 1
  fi
}

# Call the functions
#echo "Enter the update interval in seconds: "
#read UPDATE_INTERVAL

clone_repo
determine_framework
install_and_build
serve_app

# Call the update_repo function periodically based on the user input
while true; do
  sleep 4
  if update_repo; then
    install_and_build
    kill "$SERVE_PID" &> /dev/null
    serve_app
  fi

done
