#!/usr/bin/env bats                                                                                                                                                                           
                                                                                                                                                                                              
setup() {                                                                                                                                                                                     
    load '/usr/lib/bats-support/load.bash'                                                                                                                                                    
    load '/usr/lib/bats-assert/load.bash'                                                                                                                                                     
    load './funcs.sh'                                                                                                                                                                         
    load '../common/common.sh'                                                                                                                                                                
}

FLASK=(
  "https://github.com/thebigbone/weather (Flask)"
  "https://github.com/thebigbone/currency (Flask)"
  "https://github.com/sumairz/photo-gallery-python-flask (Flask)"
  "https://github.com/Rahulpatil512/Music-Recommendation-System (Flask)"
)

DJANGO=(
  "https://github.com/inboxpraveen/movie-recommendation-system (Django)"
  "https://github.com/samarth-p/College-ERP (Django)"
#  "https://github.com/timmyomahony/django-pagedown (Django)"
  "https://github.com/smahesh29/Django-WebApp (Django)"
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

    run py_install_and_build
    assert_output --partial "Successfully installed"

    cd ..
    rm -rf "$REPO_DIR"
  done
}

@test "determine_framework detects correct py framework for given repository" {                                             
  for repo in "${FLASK[@]}" "${DJANGO[@]}"; do                                                                                                                                          
        EXPECTED_FRAMEWORK=$(echo "$repo" | grep -oP '\(([^)]+)\)' | grep -oP '[^()]+')                                                                                                       
        REPO_URL=$(echo "$repo" | awk '{print $1}')                                                                                                                                           
                                                                                                                                                                                              
        export REPO_DIR=$(basename "$REPO_URL" .git)                                                                                                                                          
        export FRAMEWORK                                                                                                                                                                      
        export REPO_URL
                                                                                                      
        run clone_repo                                                                                                                                                                        
        [ "$status" -eq 0 ]                                                                                                                                                                   
        cd "$REPO_DIR"                                                                                                                                                                        
                                                                                                                                                                                              
        run py_framework                                                                                                                                                                      
        assert_output --partial "$EXPECTED_FRAMEWORK"                                                                                                                                         
                                                                                                                                                                                              
        cd ..                                                                                                                                                                                 
        rm -rf "$REPO_DIR"                                                                                                                                                                    
  done                                                                                                                                         
}

@test "py_install_and_build for flask repos" {
  test_install_and_build "${FLASK[@]}"
}

@test "py_install_and_build for django repos" {
  test_install_and_build "${DJANGO[@]}"
}
