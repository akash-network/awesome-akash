# Based on https://huggingface.co/tiiuae/falcon-7b-instruct

from transformers import AutoTokenizer, AutoModelForCausalLM
import transformers
import torch
import falcon
from falcon import Request, Response

model = "tiiuae/falcon-7b-instruct"

tokenizer = AutoTokenizer.from_pretrained(model)
pipeline = transformers.pipeline(
    "text-generation",
    model=model,
    tokenizer=tokenizer,
    torch_dtype=torch.bfloat16,
    trust_remote_code=True,
    device_map="auto",
)

class GenerateResource:
    def on_post(self, req: Request, res: Response):
        data = req.media
        text = data["text"]

        sequences = pipeline(
            text,
            max_length=200,
            do_sample=True,
            top_k=10,
            num_return_sequences=1,
            eos_token_id=tokenizer.eos_token_id,
        )

        generated_texts = [seq["generated_text"] for seq in sequences]

        res.media = {"generated_texts": generated_texts}

class IndexResource:
    def on_get(self, req: Request, res: Response):
        res.content_type = "text/html"
        with open("index.html", "r") as file:
            res.body = file.read()

app = falcon.API()
app.add_route("/generate", GenerateResource())
app.add_route("/", IndexResource())

if __name__ == "__main__":
    from wsgiref import simple_server

    httpd = simple_server.make_server("0.0.0.0", 8000, app)
    httpd.serve_forever()
