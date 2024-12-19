#!/bin/bash

# update the repository
update_repo() {
    # get the latest commit hash from the remote repository
    remote_hash=$(git ls-remote --heads origin refs/heads/$BRANCH_NAME | awk '{print $1}')

    # compare each bad commit hash with the remote hash
    for hash in "${bad_commit_hashes[@]}"; do
      echo "bad hash: $hash"
      echo "remote hash: $remote_hash"
      # if the remote hash matches any bad commit hash, abort the pull
      if [ "$remote_hash" = "$hash" ]; then
        echo "[*] Bad commit detected on remote repository. Pull aborted..."
        return 1
      fi
    done

    # get the latest commit hash from the local repository
    local_hash=$(git rev-parse $BRANCH_NAME)

    # if the remote hash is different from the local hash, pull the latest changes
    if [ "$remote_hash" != "$local_hash" ]; then
      echo "[*] Changes detected, pulling latest changes.."
      git pull
      return 0
    else
      return 1
    fi
}

# roll back to the previous commit
previous_commit() {
  bad_commit_hashes=()
  current_commit=$(git rev-parse HEAD)
  bad_commit_hashes+=("$current_commit")

  # checkout the specified branch
  if ! git checkout $BRANCH_NAME; then
    echo "[*] Error: Failed to checkout the branch $BRANCH_NAME"
    echo "[*] Error: Failed to get the previous commit hash"
    return 1
  fi

  # reset to the previous commit
  if ! git reset --hard $previous_hash; then
    echo "[*] Error: Failed to reset to the previous commit $previous_hash"
    return 1
  fi

  current_hash=$(git rev-parse HEAD)

  # verify the reset was successful
  if [ "$current_hash" != "$previous_hash" ]; then
    echo "[*] Error: The reset to the previous commit $previous_hash failed"
    return 1
  fi

  echo "[*] Successfully rolled back to the previous commit $previous_hash"
  return 0
}

# clone the repository
clone_repo() {
  # check if the repository directory exists
  if [ ! -d "$REPO_DIR" ]; then
    echo "[*] Cloning the repository..."

    # access github private repo
    if [ -n "$GITHUB_ACCESS_TOKEN" ]; then
      echo "[*] Github access token specified. Cloning the private repository..."
      REPO_URL=$(echo "$REPO_URL" | sed "s|https://github.com/|https://${GITHUB_ACCESS_TOKEN}@github.com/|g")
    fi

    # access gitlab private repo
    if [ -n "$GITLAB_ACCESS_TOKEN" ]; then
      echo "[*] Gitlab access token specified. Cloning the private repository..."
      REPO_URL=$(echo "$REPO_URL" | sed "s|https://gitlab.com|https://auth:${GITLAB_ACCESS_TOKEN}@gitlab.com|g")
    fi

    # access bitbucket private repo
    if [ -n "$BITBUCKET_ACCESS_TOKEN" ]; then
      echo "[*] Bitbucket access token specified. Cloning the private repository..."
      REPO_URL=$(echo "$REPO_URL" | sed "s|https://bitbucket.org|https://${BITBUCKET_USER}:${BITBUCKET_ACCESS_TOKEN}@bitbucket.org|g")
    fi

    # clone the repository
    if ! git clone "$REPO_URL" "$REPO_DIR"; then
      echo "[*] Error: Failed to clone the repository"
      exit 1
    fi
    cd "$REPO_DIR"

    # change directory to the frontend folder if specified
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
    # pull the latest changes
    if ! git pull; then
      echo "[*] Error: Failed to pull the latest changes"
      exit 1
    fi
  fi
}

# to roll back to a specific commit
rollback_commit() {
  # if a commit hash is specified, checkout that commit
  if [ -n "$COMMIT_HASH" ]; then
    if git checkout "$COMMIT_HASH" >/dev/null 2>&1; then
      echo "[*] Successfully rolled back to $COMMIT_HASH"
    else
      echo "[*] Error: Failed to checkout commit $COMMIT_HASH"
      return 1
    fi
  fi
}

# to start serving the application
initial_serve() {
  # check if http-server command is available
  if ! command -v http-server &> /dev/null; then
    # if not, use python's http.server module to serve the application
    nohup python3 -m http.server 3000 --bind 0.0.0.0 > /dev/null 2>&1 &
  else
    # if http-server command is available, use it to serve the application
    nohup http-server -p 3000 -f index.html > /dev/null 2>&1 &
  fi
  SERVE_PID=$!
}

