from flask import Flask, request, jsonify
from transformers import pipeline

app = Flask(__name__)

@app.route('/predict', methods=['POST'])
def predict():
    data = request.get_json(force=True)
    model_name = "xlm-roberta-base"
    unmasker = pipeline('fill-mask', model=model_name)
    prediction = unmasker(data['input'])
    return jsonify(prediction)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)

