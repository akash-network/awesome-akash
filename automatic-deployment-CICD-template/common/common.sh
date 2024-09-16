#!/bin/bash

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
      echo "[*] Changes detected, pulling latest changes.."
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

    if [ -n "$GITHUB_ACCESS_TOKEN" ]; then
      echo "[*] Github access token specified. Cloning the private repository..."
      REPO_URL=$(echo "$REPO_URL" | sed "s|https://github.com/|https://${GITHUB_ACCESS_TOKEN}@github.com/|g")
    fi

    if [ -n "$GITLAB_ACCESS_TOKEN" ]; then
      echo "[*] Gitlab access token specified. Cloning the private repository..."
      REPO_URL=$(echo "$REPO_URL" | sed "s|https://gitlab.com|https://auth:${GITLAB_ACCESS_TOKEN}@gitlab.com|g")
    fi

    if [ -n "$BITBUCKET_ACCESS_TOKEN" ]; then
      echo "[*] Bitbucket access token specified. Cloning the private repository..."
      REPO_URL=$(echo "$REPO_URL" | sed "s|https://bitbucket.org|https://${BITBUCKET_USER}:${BITBUCKET_ACCESS_TOKEN}@bitbucket.org|g")
    fi
    
    if ! git clone "$REPO_URL" "$REPO_DIR"; then
      echo "[*] Error: Failed to clone the repository"
      exit 1
    fi
    cd "$REPO_DIR"

    # Change directory to the frontend folder if specified
    if [ -n "$FRONTEND_FOLDER" ]; then
      if [ ! -d "$FRONTEND_FOLDER" ]; then
        echo "[*] Error: Frontend folder '$FRONTEND_FOLDER' not found"
        exit 1
      fi
      cd "$FRONTEND_FOLDER"
      echo "[*] Changed directory to $FRONTEND_FOLDER"
    fi

  else
    echo "[*] Repository already exists on server, pulling latest changes..."
    cd "$REPO_DIR"
    if ! git pull; then
      echo "[*] Error: Failed to pull the latest changes"
      exit 1
    fi
  fi
}

rollback_commit() {
  if [ -n "$COMMIT_HASH" ]; then
    if git checkout "$COMMIT_HASH" >/dev/null 2>&1; then
      echo "[*] Successfully rolled back to $COMMIT_HASH"
    else
      echo "[*] Error: Failed to checkout commit $COMMIT_HASH"
      return 1
    fi
  fi
}

initial_serve() {
  if ! command -v http-server &> /dev/null; then
    nohup python3 -m http.server 3000 --bind 0.0.0.0 > /dev/null 2>&1 &
  else
    nohup http-server -p 3000 -f index.html > /dev/null 2>&1 &
  fi
  SERVE_PID=$!
}
