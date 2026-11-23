from wsgiref.simple_server import make_server

import falcon
import torch
from transformers import AutoTokenizer, pipeline


MODEL_ID = "tiiuae/falcon-7b-instruct"

tokenizer = AutoTokenizer.from_pretrained(MODEL_ID)
generator = pipeline(
    "text-generation",
    model=MODEL_ID,
    tokenizer=tokenizer,
    dtype=torch.float16,
    device_map="auto",
)


class GenerateResource:
    def on_post(self, req: falcon.Request, res: falcon.Response):
        data = req.get_media(default_when_empty=None)
        text = data.get("text") if isinstance(data, dict) else None

        if not isinstance(text, str) or not text.strip():
            raise falcon.HTTPBadRequest(
                title="Invalid input",
                description="The 'text' field must be a non-empty string.",
            )

        sequences = generator(
            text,
            max_length=200,
            do_sample=True,
            top_k=10,
            num_return_sequences=1,
            eos_token_id=tokenizer.eos_token_id,
        )

        res.media = {
            "generated_texts": [sequence["generated_text"] for sequence in sequences]
        }


class IndexResource:
    def on_get(self, req: falcon.Request, res: falcon.Response):
        res.content_type = "text/html; charset=utf-8"

        with open("index.html", encoding="utf-8") as file:
            res.text = file.read()


app = falcon.App()
app.add_route("/", IndexResource())
app.add_route("/generate", GenerateResource())


if __name__ == "__main__":
    with make_server("0.0.0.0", 8000, app) as httpd:
        httpd.serve_forever()
