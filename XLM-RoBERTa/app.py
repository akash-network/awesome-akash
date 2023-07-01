from flask import Flask, request, jsonify, render_template
from transformers import pipeline

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/predict', methods=['POST'])
def predict():
    text = request.form.get('text')
    nlp = pipeline("sentiment-analysis", model="cardiffnlp/twitter-xlm-roberta-base-sentiment")
    result = nlp(text)[0]
    return jsonify(result)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
