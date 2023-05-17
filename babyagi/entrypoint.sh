git clone https://github.com/yoheinakajima/babyagi babyagi
cd babyagi
pip install --upgrade pip
pip install -r requirements.txt
gotty -p 3000 -w --random-url-length 16 python babyagi.py
