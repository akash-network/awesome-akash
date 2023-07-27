from flask import Flask, request, jsonify, render_template
from transformers import BertTokenizer, BertForMaskedLM

app = Flask(__name__)

MODEL_NAME = 'bert-base-uncased'
tokenizer = BertTokenizer.from_pretrained(MODEL_NAME)
model = BertForMaskedLM.from_pretrained(MODEL_NAME)

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        text = request.form['text']
        encoded_input = tokenizer(text, return_tensors='pt')
        output = model(**encoded_input)
        predicted_token = tokenizer.decode(output.logits.argmax(-1).tolist()[0])
        return render_template('index.html', output=predicted_token)
    return render_template('index.html')

@app.route('/predict', methods=['POST'])
def predict():
    data = request.get_json()
    text = data.get('text')
    encoded_input = tokenizer(text, return_tensors='pt')
    output = model(**encoded_input)
    predicted_token = tokenizer.decode(output.logits.argmax(-1).tolist()[0])
    return jsonify({'predicted_token': predicted_token})

if __name__ == '__main__':
    print("BERT deployed successfully!")
    app.run(host='0.0.0.0', port=80)
