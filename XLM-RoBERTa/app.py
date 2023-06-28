from flask import Flask, request, jsonify
from transformers import XLMRobertaModel, XLMRobertaTokenizer

app = Flask(__name__)

# Load pre-trained model and tokenizer
model = XLMRobertaModel.from_pretrained('xlm-roberta-base')
tokenizer = XLMRobertaTokenizer.from_pretrained('xlm-roberta-base')

@app.route('/encode', methods=['POST'])
def encode():
    # Get the text from the request
    text = request.json.get('text')

    # Check if text is not empty
    if not text:
        return jsonify({'error': 'No text provided'}), 400

    # Encode the text
    encoded_input = tokenizer(text, return_tensors='pt')
    output = model(**encoded_input)

    # Convert the output to a list so it can be JSON serialized
    output_list = output[0].tolist()

    return jsonify({'encoded_representation': output_list})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
