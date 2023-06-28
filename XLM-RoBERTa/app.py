from flask import Flask, request, jsonify
from transformers import XLMRobertaModel, XLMRobertaTokenizer
import torch

app = Flask(__name__)

MODEL_NAME = 'xlm-roberta-base'
tokenizer = XLMRobertaTokenizer.from_pretrained(MODEL_NAME)
model = XLMRobertaModel.from_pretrained(MODEL_NAME)

@app.route('/encode', methods=['POST'])
def encode():
    text = request.json['text']
    inputs = tokenizer(text, return_tensors='pt')
    outputs = model(**inputs)

    # Convert tensor to list and return as JSON
    return jsonify(outputs.last_hidden_state.tolist())

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
