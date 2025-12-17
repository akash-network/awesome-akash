#!/usr/bin/env bats

setup() {
    load '/usr/lib/bats-support/load.bash'
    load '/usr/lib/bats-assert/load.bash'
    load './funcs.sh'
    load '../common/common.sh'
}


NEXT=(
  "https://github.com/AykutSarac/jsoncrack.com.git (Next.js)"
  "https://github.com/ChatGPTNextWeb/ChatGPT-Next-Web.git (Next.js)"
)

SVELTE=(
  "https://github.com/Nico-Mayer/lofi-flow.git (Svelte)"
  "https://github.com/syntaxfm/website.git (Svelte)"
  "https://github.com/haishanh/cherry.git (Svelte)"
)

REACT=(
  "https://github.com/adrianhajdin/project_corona_tracker.git (Create React App)"
  "https://github.com/adrianhajdin/chat_application.git (Create React App)"
)

GATSBY=(
  "https://github.com/gatsbyjs/gatsby-starter-blog.git (Gatsby.js)"
  "https://github.com/ariqnrnns/zauberhaft-gatsby.git (Gatsby.js)"
  "https://github.com/ariqnrnns/zauberhaft-gatsby.git (Gatsby.js)"
)

VITEREACT=(
  "https://github.com/TusharSharma131/my-portfolio.git (Vite-react.js)"
  "https://github.com/Daniel-san8/Ecommerce.git (Vite-react.js)"
  "https://github.com/CEHDhanaSekar/apple_model.git (Vite-react.js)"
)

NUXT=(
  "https://github.com/AsaoluElijah/portfolio.git (Nuxt.js)"
  "https://github.com/BenShelton/nuxt-example.git (Nuxt.js)"
  "https://github.com/themeselection/materio-vuetify-nuxtjs-admin-template-free.git (Nuxt.js)"
)

ANGULAR=(
  "https://github.com/gittjar/angular-clock.git (Angular)"
  "https://github.com/TheMaxium69/NexiumiaCRM-FrontEnd.git (Angular)"
  "https://github.com/laudebugs/dynamic-components-angular.git (Angular)"
)

PREACT=(
  "https://github.com/developit/preact-todomvc.git (Preact)"
  "https://github.com/developit/hn_minimal.git (Preact)"
  "https://github.com/developit/preact-boilerplate.git (Preact)"
)

VITEPRESS=(
  "https://github.com/sfxcode/vitepress-blog-starter.git (Vitepress)"
  "https://github.com/clark-cui/vitepress-blog-zaun.git (Vitepress)"
  "https://github.com/airene/vitepress-blog-pure (Vitepress)"
  "https://github.com/flaribbit/vitepress-theme-sakura (Vitepress)"
  "https://github.com/brenoepics/vitepress-carbon (Vitepress)"
  "https://github.com/nas5w/interview-guide (Vitepress)"
)

ASTRO=(
  "https://github.com/ElianCodes/brutal.git (Astro.js)"
  "https://github.com/surjithctly/astroship.git (Astro.js)"
  "https://github.com/satnaing/astro-paper.git (Astro.js)"
  "https://github.com/ixartz/Astro-boilerplate.git (Astro.js)"
  "https://github.com/markteekman/accessible-astro-starter.git (Astro.js)"
)

TY=(
  "https://github.com/kohrongying/11ty-blog-starter (11ty)"
  "https://github.com/5t3ph/11ty-netlify-jumpstart (11ty)"
  "https://github.com/11ty/11ty-website (11ty)"
)

IONICREACT=(
  "https://github.com/josephgodwinkimani/react-query-boilerplate.git (Ionic React)"
  "https://github.com/nantes/giftu_ionic_react.git (Ionic React)"
  "https://github.com/n-lusano/IkLeerNederlands.git (Ionic React)"
)

IONICANGULAR=(
  "https://github.com/ionic-team/ionic-conference-app.git (Ionic Angular)"
  "https://github.com/AndrewJBateman/ionic-angular-project.git (Ionic Angular)"
)

STENCIL=(
  "https://github.com/tiagoboeing/anywhere-webcomponents.git (Stencil)"
  "https://github.com/natemoo-re/konami-listener.git (Stencil)"
)

test_install_and_build() {
  local repos=("$@")

  for repo in "${repos[@]}"; do
    FRAMEWORK=$(echo "$repo" | grep -oP '\(([^)]+)\)' | grep -oP '[^()]+')
    REPO_URL=$(echo "$repo" | awk '{print $1}')

    export REPO_DIR=$(basename "$REPO_URL" .git)
    export FRAMEWORK
    export REPO_URL

    run clone_repo
    [ "$status" -eq 0 ]
    cd "$REPO_DIR"

    run js_install_and_build
    [ "$status" -eq 0 ]

    cd ..
    rm -rf "$REPO_DIR"
  done
}

@test "clone_repo clones the repo" {
  export REPO_URL="https://github.com/bats-core/bats-core.git"
  export REPO_DIR=$(basename "$REPO_URL" .git)

  run clone_repo
  [ "$status" -eq 0 ]
  [ -d "$REPO_DIR" ]
  rm -rf "$REPO_DIR"
}

@test "determine_framework detects correct js framework for given repository" {
  for repo in "${SVELTE[@]}" "${NEXT[@]}" "${REACT[@]}" "${GATSBY[@]}" "${ANGULAR[@]}" "${VITEREACT[@]}" "${NUXT[@]}" "${PREACT[@]}" "${VITEPRESS[@]}" "${ASTRO[@]}" "${TY[@]}" "${IONICREACT[@]}" "${IONICANGULAR[@]}" "${STENCIL[@]}"; do
        EXPECTED_FRAMEWORK=$(echo "$repo" | grep -oP '\(([^)]+)\)' | grep -oP '[^()]+')
        REPO_URL=$(echo "$repo" | awk '{print $1}')

    	export REPO_DIR=$(basename "$REPO_URL" .git)	
    	export FRAMEWORK
    	export REPO_URL
    
    	run clone_repo
        [ "$status" -eq 0 ]
	cd "$REPO_DIR"
	
        run js_framework
        assert_output --partial "$EXPECTED_FRAMEWORK"

        cd ..
        rm -rf "$REPO_DIR"
  done
}

@test "js_install_and_build for svelte repos" {
  test_install_and_build "${SVELTE[@]}"
}

@test "js_install_and_build for next repos" {
  test_install_and_build "${NEXT[@]}"
}

@test "js_install_and_build for react repos" {
  test_install_and_build "${REACT[@]}"
}

@test "js_install_and_build for nuxt repos" {
  test_install_and_build "${NUXT[@]}"
}

@test "js_install_and_build for gatsby repos" {
  test_install_and_build "${GATSBY[@]}"
}

@test "js_install_and_build for angular repos" {
  test_install_and_build "${ANGULAR[@]}"
}

@test "js_install_and_build for vite react repos" {
  test_install_and_build "${VITEREACT[@]}"
}

@test "js_install_and_build for preact repos" {
  test_install_and_build "${PREACT[@]}"
}

@test "js_install_and_build for vitepress repos" {
  test_install_and_build "${VITEPRESS[@]}"
}

@test "js_install_and_build for astro repos" {
  test_install_and_build "${ASTRO[@]}"
}

@test "js_install_and_build for 11ty repos" {
  test_install_and_build "${TY[@]}"
}

@test "js_install_and_build for ionic react repos" { 
  test_install_and_build "${IONICREACT[@]}"
}

@test "js_install_and_build for ionic angular repos" {
  test_install_and_build "${IONICANGULAR[@]}"
}

@test "js_install_and_build for stencil repos" {
  test_install_and_build "${STENCIL[@]}"
}


@test "rollback_commit rolls back to the specified commit" {
  git config --global user.email "test@test.local"
  git config --global user.name "test"

  TMP_DIR=$(mktemp -d)
  cd "$TMP_DIR"
  git init

  echo "Initial commit" > file.txt
  git add file.txt
  git commit -m "Initial commit"

  echo "Second commit" >> file.txt
  git commit -am "Second commit"

  export COMMIT_HASH=$(git rev-parse HEAD~1)

  run rollback_commit

  [ "$status" -eq 0 ]
  assert_output "[*] Successfully rolled back to $COMMIT_HASH"

  assert_equal "$(cat file.txt)" "Initial commit"

  cd ..
  rm -rf "$TMP_DIR"
}

@test "rollback_commit fails when COMMIT_HASH is not specified" {
  unset COMMIT_HASH
  run rollback_commit

  [ "$status" -eq 0 ]
}
