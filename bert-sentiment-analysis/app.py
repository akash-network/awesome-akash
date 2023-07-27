from scipy.special import softmax
from flask import Flask, request, jsonify, render_template
from transformers import AutoTokenizer, AutoModelForSequenceClassification
import numpy as np


app = Flask(__name__)

MODEL_NAME = 'nlptown/bert-base-multilingual-uncased-sentiment'
tokenizer = AutoTokenizer.from_pretrained(MODEL_NAME)
model = AutoModelForSequenceClassification.from_pretrained(MODEL_NAME)

global sentiment_labels
sentiment_labels = ['very negative', 'negative', 'neutral', 'positive', 'very positive']

@app.route('/', methods=['GET', 'POST'])
def index():
    ranking = None
    if request.method == 'POST':
        text = request.form['text']
        encoded_input = tokenizer(text, return_tensors='pt')
        output = model(**encoded_input)
        scores = output[0][0].detach().numpy()
        scores = softmax(scores)
        ranking = np.argmax(scores)
        ranking = sentiment_labels[ranking]
    return render_template('index.html', ranking=ranking)
def predict():
    data = request.get_json()
    text = data.get('text')
    encoded_input = tokenizer(text, return_tensors='pt')
    output = model(**encoded_input)
    scores = output[0][0].detach().numpy()
    scores = softmax(scores)
    ranking = np.argmax(scores)
    sentiment = sentiment_labels[ranking]
    return jsonify({'sentiment': sentiment})

if __name__ == '__main__':
    print("BERT sentiment analysis model deployed successfully!")
    app.run(host='0.0.0.0', port=80)
