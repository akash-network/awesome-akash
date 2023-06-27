from transformers import BertModel

print("Loading BERT model...")
model = BertModel.from_pretrained('bert-base-uncased')
print("BERT model loaded successfully!")

