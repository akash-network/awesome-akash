from flask import Flask, request, jsonify
from transformers import XLMRobertaTokenizer, XLMRobertaModel

app = Flask(__name__)

MODEL_NAME = 'xlm-roberta-base'
tokenizer = XLMRobertaTokenizer.from_pretrained(MODEL_NAME)
model = XLMRobertaModel.from_pretrained(MODEL_NAME)

@app.route('/encode', methods=['POST'])
def encode():
    data = request.get_json()
    text = data.get('text')
    encoded_input = tokenizer(text, return_tensors='pt')
    return jsonify(encoded_input)

if __name__ == '__main__':
    print("XLMRoberta deployed successfully!")
    app.run(host='0.0.0.0', port=80)

