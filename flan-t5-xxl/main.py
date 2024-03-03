import torch
from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
from fastapi.responses import FileResponse

from transformers import T5Tokenizer, T5ForConditionalGeneration

tokenizer = T5Tokenizer.from_pretrained("google/flan-t5-xxl")
model = T5ForConditionalGeneration.from_pretrained("google/flan-t5-xxl", device_map="auto", torch_dtype=torch.float16)

app = FastAPI()


@app.get("/infer_t5")
def t5(input):
    try:
        input_ids = tokenizer(input, return_tensors="pt").input_ids.to("cuda")
        outputs = model.generate(input_ids)
        return {"output": tokenizer.decode(outputs[0])}
    except:
        return {"output": "ERROR. Try again"}

app.mount("/", StaticFiles(directory="static", html=True), name="static")

@app.get("/")
def index() -> FileResponse:
    return FileResponse(path="/app/static/index.html", media_type="text/html")
