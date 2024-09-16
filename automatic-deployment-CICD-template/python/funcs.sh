#!/bin/bash

py_framework() {
  if ! command -v pip >/dev/null 2>&1 || ! command -v pip3 >/dev/null 2>&1; then
    echo "[*] Installing pip..."
    if ! apt install python3-pip -y; then
      echo "[!] Failed to install pip"
      return 1
    fi
  fi

  check_requirements

  if grep -q -i "django" "requirements.txt"; then
    FRAMEWORK="Django"
  elif grep -q -i "flask" "requirements.txt"; then
    FRAMEWORK="Flask"
  else
    echo "[*] Unable to determine Python framework (neither Django nor Flask found)"
    return 1
  fi

  echo "[*] Python framework detected: ${FRAMEWORK}"
}


py_install_and_build() {
  if ! python3 -m venv venv; then
    echo "[*] Failed to create virtual environment..."
    return 1
  fi

  if ! source venv/bin/activate; then
    echo "[*] Failed to source the virtual environment..."
    return 1
  fi

  check_requirements

  if ! pip install -r requirements.txt; then
    echo "[*] Installation of dependencies failed..."
    return 1
  fi

  if [ "$FRAMEWORK" == "Django" ]; then
    echo "[*] Running migrations for Django..."
    if ! python manage.py makemigrations; then
      if [ "$FRAMEWORK" == "Django" ]; then
        pip install -e ".[dev]"
      fi
      
      if ! python manage.py makemigrations; then
        echo "[!] Migration creation failed..."
        return 1
      fi
    fi

    echo "[*] Applying migrations for Django..."
    if ! python manage.py migrate; then
      echo "[!] Migration application failed..."
      return 1
    fi
    
    if [ -f "settings.py" ]; then
      sed -i '$a ALLOWED_HOSTS = ['\''*'\'']' settings.py
    fi
  fi
}

py_serve_app() {
  if [ -n "$SERVE_PID" ]; then
    kill "$SERVE_PID" &> /dev/null
  fi

  if [ "$FRAMEWORK" == "Flask" ]; then
    export FLASK_APP="$APP_NAME"
    if ! flask run --host 0.0.0.0 -p 3000; then
      echo "[*] Failed to serve the flask app..."
      return 1
    fi
  elif [ "$FRAMEWORK" == "Django" ]; then
    export SECRET_KEY="$SECRET"
    if ! python manage.py runserver 0.0.0.0:3000; then
      echo "[*] Failed to serve django app..."
      return 1
    fi
  else
    echo "[*] Unsupported framework"
  fi
}

check_requirements() {
  if [ ! -f "requirements.txt" ]; then
    if ! pip install pipreqs; then
      echo "[*] Failed to install pipreqs."
      exit 1
    fi
   
    if ! pipreqs .; then
      echo "[*] Failed to generate requirements.txt."
      exit 1
    fi
  fi
}
