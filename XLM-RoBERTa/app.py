from flask import Flask, request, jsonify, render_template
from transformers import XLMRobertaTokenizer, XLMRobertaModel

app = Flask(__name__)

MODEL_NAME = 'xlm-roberta-base'
tokenizer = XLMRobertaTokenizer.from_pretrained(MODEL_NAME)
model = XLMRobertaModel.from_pretrained(MODEL_NAME)

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        text = request.form['text']
        encoded_input = tokenizer(text, return_tensors='pt')
        output = model(**encoded_input)
        return render_template('index.html', output=output)
    return render_template('index.html')

if __name__ == '__main__':
    print("XLMRoberta deployed successfully!")
    app.run(host='0.0.0.0', port=80)
