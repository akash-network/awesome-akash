#!/bin/bash

# Function to determine the JavaScript framework
js_framework() {

  html_regex=$(if ls *.html >/dev/null 2>&1 && [ ! -f "package.json" ] && [ ! -f "yarn.lock" ]; then echo "true"; fi)

  if command -v npm >/dev/null 2>&1; then
    if npm ls --depth=0 | grep "umijs" >/dev/null 2>&1; then
      FRAMEWORK="Umi.js"
    elif npm ls --depth=0 | grep "vitepress" >/dev/null 2>&1; then
      FRAMEWORK="Vitepress"
    elif npm ls --depth=0 | grep "react-scripts" >/dev/null 2>&1 && [ ! -f "ionic.config.json" ]; then
      FRAMEWORK="React (Create React App)"
    elif [ -f "ionic.config.json" ] && [ ! -f "angular.json" ]; then
      FRAMEWORK="Ionic React"
    elif npm ls --depth=0 | grep "gatsby" >/dev/null 2>&1; then
      FRAMEWORK="Gatsby.js"
    elif npm ls --depth=0 | grep "vue" >/dev/null 2>&1 && [ -f "vue.config.js" ]; then
      FRAMEWORK="Vue.js"
    elif ([ -f "vite.config.js" ] || [ -f "vite.config.ts" ]) && (npm ls | grep -qw "vite" && npm ls | grep -qw "react") >/dev/null 2>&1; then
      FRAMEWORK="Vite-react.js"
    elif npm ls --depth=0 | grep "astro" >/dev/null 2>&1; then
      FRAMEWORK="Astro.js"
    elif npm ls --depth=0 | grep "next" && ls next.config.* >/dev/null 2>&1; then
      FRAMEWORK="Next.js"
    elif [ -f "ionic.config.json" ] && [ -f "angular.json" ]; then
      FRAMEWORK="Ionic Angular"
    elif [ ! -f "ionic.config.json" ] && [ -f "angular.json" ] || (grep -q '"@angular/core"' package.json); then
      FRAMEWORK="Angular"
    elif npm ls --depth=0 | grep "express" >/dev/null 2>&1; then
      FRAMEWORK="Express.js"
    elif npm ls --depth=0 | grep "svelte" && [ -f "svelte.config.js" ] >/dev/null 2>&1; then
      FRAMEWORK="Svelte"
    elif npm ls --depth=0 | grep "ember-cli" >/dev/null 2>&1; then
      FRAMEWORK="Ember.js"
    elif npm ls --depth=0 | grep -E "vue|nuxt" >/dev/null 2>&1; then
      FRAMEWORK="Nuxt.js"
    elif npm ls --depth=0 | grep "11ty" >/dev/null 2>&1; then
      FRAMEWORK="11ty"
    elif npm ls --depth=0 | grep "gridsome" >/dev/null 2>&1; then
      FRAMEWORK="Gridsome"
    elif [ -f "remix.config.js" ]; then
      FRAMEWORK="Remix"
    elif ls webpack.config.* >/dev/null 2>&1 && npm ls --depth=0 | grep -q "preact"; then
      FRAMEWORK="Preact"
    elif [ -f "stencil.config.ts" ]; then
      FRAMEWORK="Stencil"
    elif [ "$html_regex" ]; then
      FRAMEWORK="HTML"
    else
      FRAMEWORK="Unknown"
    fi
  else
    echo "[*] npm not found. Cannot determine the JavaScript framework."
    exit 1
  fi
  echo "[*] FRAMEWORK DETECTED: $FRAMEWORK"
  if [ "$FRAMEWORK" = "Unknown" ]; then
    echo "[*] Unknown framework detected. Exiting..."
    exit 1
  fi
}

# Function to install dependencies and build the application
js_install_and_build() {
  source /usr/local/nvm/nvm.sh
  
  if [ -f "package.json" ]; then
    if grep -q '"homepage":' package.json; then
      sed -i 's/"homepage": "[^"]*"/"homepage": ""/' package.json
    fi
  fi

  if [ -n "$NODE_VERSION" ]; then
    nvm install "$NODE_VERSION" && nvm use "$NODE_VERSION" || {
    echo "[*] Error installing or using $NODE_VERSION. Using default node version..."
    }
    
  fi

  if [ -n "$PNPM_VERSION" ]; then
    echo "[*] Installing pnpm version $PNPM_VERSION..."
    npm install -g pnpm@"$PNPM_VERSION"
  else
    echo "[*] PNPM_VERSION not specified. Using default pnpm version..."
  fi

  if [ "$FRAMEWORK" = "Svelte" ]; then
    if npm install -g @sveltejs/adapter-node >/dev/null 2>&1; then
      if [ -f "svelte.config.js" ]; then
        sed -i "s/import adapter from '@sveltejs\/adapter-[^']*';/import adapter from '@sveltejs\/adapter-node';/" svelte.config.js
      else
        echo "[*] svelte.config.js not found..."
        exit 1
      fi
    else
      echo "[*] Error installing @sveltejs/adapter-node..."
      exit 1
    fi
  fi

  
 # Installing dependencies
  if [ "$FRAMEWORK" != "HTML" ] && [ -z "$INSTALL_COMMAND" ]; then
    # Installing dependencies
    echo "[*] Installing dependencies..."
    for i in pnpm*; do
      if [ -f "$i" ]; then
        echo "pnpm detected"
        if ! command -v pnpm; then
	  npm install -g pnpm@"$PNPM_VERSION"
	fi
        pnpm install
      else
        npm install
      fi
    done
  fi

  if [ -n "$INSTALL_COMMAND" ]; then
    echo "[*] Running custom install command..."
    bash -c "$INSTALL_COMMAND"
  fi

  if [ "$FRAMEWORK" = "Astro.js" ]; then
    if ! command -v astro >/dev/null 2>&1; then
      echo "[*] Astro not installed. Installing it..."
      npm install -g astro
    else
      echo "[*] Astro is installed."
    fi
  fi

  if [ "$FRAMEWORK" = "Gridsome" ]; then
    apt install build-essential make -y
  fi
  
  # Install http-server for HTML projects 
  if [ "$FRAMEWORK" = "HTML" ]; then
    if ! command -v http-server >/dev/null 2>&1; then
      echo "[*] HTTP-SERVER not installed. Installing it..."
      npm install -g http-server
      echo "[*] HTTP-SERVER INSTALLED SUCCESSFULLY"
    else
      echo "[*] HTTP-SERVER is already installed."
    fi
  fi
  
  # Install Angular CLI for Angular projects 
  if [ "$FRAMEWORK" = "Angular" ]; then
    if ! command -v ng >/dev/null 2>&1; then
      echo "[*] Angular CLI not installed. Installing it..."
      npm install -g @angular/cli@6.1.1
      echo "[*] Angular CLI INSTALLED SUCCESSFULLY"
    else
      echo "[*] Angular CLI is already installed."
    fi
  fi

   # Install Remix CLI for Remix projects 
  if [ "$FRAMEWORK" = "Remix" ]; then
    if ! command -v remix >/dev/null 2>&1; then
      echo "[*] Remix CLI not installed. Installing it..."
      npm install -g @remix-run/cli
      echo "[*] Remix CLI INSTALLED SUCCESSFULLY"
    else
      echo "[*] Remix CLI is already installed."
    fi
  fi


  if [ "$FRAMEWORK" != "HTML" ] && [ "$?" -eq 0 ]; then
    echo "[*] Dependencies installed successfully."
  fi

  # Pre build commands
  echo "[*] Checking if any pre build commands are provided..."
  if [ "$FRAMEWORK" != "HTML" ] && [ -n "$PRE_BUILD" ]; then
    echo "[*] Running $PRE_BUILD"
    eval "$PRE_BUILD"
  fi

  if [ "$FRAMEWORK" = "Nuxt.js" ]; then
    echo "[*] Generating Nuxt project..."
    npm run generate
  fi

  if [ "$FRAMEWORK" = "Vitepress" ]; then
    npm run docs:build
  fi

  # Executing the build command
  echo "[*] Building the application..."
  if [ "$FRAMEWORK" = "HTML" ] || [ "$FRAMEWORK" = "Nuxt.js" ] || [ "$FRAMEWORK" = "Vitepress" ]; then
    :
  elif [ -n "$BUILD_COMMAND" ]; then
    eval "$BUILD_COMMAND"
  else
    for i in pnpm*; do
      if [ -f "$i" ]; then
        echo "pnpm detected"
        if ! command -v pnpm; then
	  npm install -g pnpm@"$PNPM_VERSION"
	fi
        pnpm run build 2>&1
      else
        npm run build 2>&1
      fi
    done
  fi

  # do NOT add anything unrelated to build commands above this
  if [ "$?" -eq 0 ] || [ "$FRAMEWORK" != "HTML" ]; then
    echo "[*] Application built successfully..."
  else
    echo "[*] Broken changes detected. Rolling back to the previous commit..."
    if previous_commit; then
        js_install_and_build
    else
        echo "[*] Something went wrong."
    fi
  fi

}

# Function to serve the application
js_serve_app() {
  # Installing serve if not already installed
  if ! command -v serve &> /dev/null; then
    echo "[*] Installing serve..."
    npm install -g serve
  fi

  # Check if there's an existing server running and kill it
  if [ -n "$SERVE_PID" ]; then
    kill "$SERVE_PID" &> /dev/null
  fi

  #kill_initial >/dev/null 2>&1

  if [ "$BUILD_DIRECTORY" ]; then
    echo "[*] Serving the latest build from specified directory $BUILD_DIRECTORY..."
    nohup serve "$BUILD_DIRECTORY" & > /dev/null
    SERVE_PID=$!

  elif [ "$FRAMEWORK" = "React (Create React App)" ]; then
    echo "[*] Serving the latest build from 'build' directory..."
    nohup serve build & > /dev/null
    SERVE_PID=$!

  elif [ "$FRAMEWORK" = "11ty" ]; then
    echo "[*] Serving the latest build from '_site' directory..."
    nohup serve _site & > /dev/null
    SERVE_PID=$!

  elif [ "$FRAMEWORK" = "Vue.js" ] || [ "$FRAMEWORK" = "Gridsome" ] || [ "$FRAMEWORK" = "Umi.js" ] || [ "$FRAMEWORK" = "Astro.js" ] || [ "$FRAMEWORK" = "Vite-react.js" ] || [ "$FRAMEWORK" = "Express.js" ] || [ "$FRAMEWORK" = "Ember.js" ]; then
    echo "[*] Serving the latest build from 'dist' directory..."
    nohup serve dist & > /dev/null
    SERVE_PID=$!

  elif [ "$FRAMEWORK" = "Gatsby.js" ]; then
    echo "[*] Serving the latest build from 'public' directory..."
    nohup serve public & > /dev/null
    SERVE_PID=$!

  elif [ "$FRAMEWORK" = "Next.js" ]; then
    echo "[*] Serving the latest build using 'next start'..."
    nohup ./node_modules/.bin/next start & > /dev/null
    SERVE_PID=$!
    
  elif [ "$FRAMEWORK" = "HTML" ]; then
    echo "[*] Serving HTML project using 'http-server'..."
    if [ -f "index.html" ]; then
      nohup http-server -p 3000 > /dev/null 2>&1 &
      SERVE_PID=$!
      echo "[*] HTML project is running at port 3000..."
    else
      echo "[*] Error: index.html not found..."
      exit 1
    fi
    
  elif [ "$FRAMEWORK" = "Angular" ]; then
    echo "[*] Serving Angular project using 'ng serve'..."
    nohup ng serve --host 0.0.0.0 --port 3000 > /dev/null 2>&1 &
    SERVE_PID=$!

  elif [ "$FRAMEWORK" = "Ionic Angular" ] || [ "$FRAMEWORK" = "Stencil" ]; then
    if [ -d "www" ]; then
      echo "[*] Serving Ionic Angular project using 'serve'..."
      nohup serve -s www -p 3000 > /dev/null 2>&1 &
      SERVE_PID=$!
    else
      echo "[*] Error: default www build directory not found for $FRAMEWORK..."
      exit 1
    fi

  elif [ "$FRAMEWORK" = "Svelte" ]; then
    echo "[*] Serving the latest build using 'node'..."
    nohup node build > /dev/null 2>&1 &
    SERVE_PID=$!

  elif [ "$FRAMEWORK" = "Nuxt.js" ]; then
    if [ -d "dist" ]; then
      echo "[*] Serving the latest build from 'dist' directory..."
      nohup serve dist & > /dev/null
    else
      echo "[*] Serving Nuxt project using 'nuxt start'..."
      nohup nuxt start -p 3000 > /dev/null 2>&1 &
      SERVE_PID=$!
    fi

  elif [ "$FRAMEWORK" = "Remix" ]; then
    if [ -d "build" ]; then
      if [ -f "build/index.js" ]; then
        echo "[*] Serving Remix project using 'npx remix-serve build/index.js'..."
        nohup npx remix-serve build/index.js > /dev/null 2>&1 &
        SERVE_PID=$!
      else
        echo "[*] Error: build/index.js not found. Please ensure the build process completed successfully."
        exit 1
      fi
    fi 

  elif [ "$FRAMEWORK" = "Preact" ] || [ "$FRAMEWORK" = "Ionic React" ]; then
    if [ -d "build" ]; then
      echo "[*] Serving the latest build from 'dist' directory..."
      nohup serve build & > /dev/null
      SERVE_PID=$!
    elif [ -d "dist" ]; then
      echo "[*] Serving the latest build using 'node'..."
      nohup serve -s dist > /dev/null 2>&1 &
      SERVE_PID=$!
    fi


  elif [ "$FRAMEWORK" = "Vitepress" ]; then
    echo "[*] Serving the latest build using 'vitepress'..."
    nohup serve -s docs/.vitepress/dist/ > /dev/null 2>&1 &
    SERVE_PID=$!

  else
    echo "[*] Unknown build directory"
    exit 1
  fi
}

#kill_initial() {
#  for i in $(seq 1 2); do
#    kill_ids=$(ps -aux | grep http-server | awk -F" " '{print $2}' | head -n $i)
#    for kill_id in $kill_ids; do
#      kill $kill_id
#    done
#  done
#}
