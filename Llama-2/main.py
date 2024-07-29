import os
from fastapi import FastAPI, Request
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates
from transformers import AutoModelForCausalLM, BitsAndBytesConfig, LlamaTokenizer
from transformers import BitsAndBytesConfig
import torch


MAX_INPUT_TOKEN_LENGTH = int(os.environ.get('MAX_INPUT_TOKEN_LENGTH', 256))
MAX_NEW_TOKENS = int(os.environ.get('MAX_NEW_TOKENS', 50))

# load model in 4bit using NF4 quantization with double quantization
nf4_config = BitsAndBytesConfig(
   load_in_4bit=True,
   bnb_4bit_quant_type="nf4",
   bnb_4bit_use_double_quant=True,
   bnb_4bit_compute_dtype=torch.bfloat16
)

model = AutoModelForCausalLM.from_pretrained("cryptoman/converted-llama-2-70b", quantization_config=nf4_config, device_map="auto")
tokenizer = LlamaTokenizer.from_pretrained("cryptoman/converted-llama-2-70b")

app = FastAPI()

# set FastAPI directories
app.mount("/static", StaticFiles(directory="static"), name="static")
templates = Jinja2Templates(directory="templates")


@app.get("/talk")
def talk(input):
    try:
        # convert input text into tokens
        input_ids = tokenizer(
            input,
            return_tensors="pt",
            truncation=True, # automatically cut the beginning of input text to the length specified by MAX_INPUT_TOKEN_LENGTH
            max_length=MAX_INPUT_TOKEN_LENGTH
        ).input_ids.to('cuda')

        # call model to generate an output text
        gen_tokens = model.generate(
            input_ids,
            do_sample=True,
            temperature=0.9,
            max_new_tokens=MAX_NEW_TOKENS, # the number of new tokens that the model generates without taking into account the number of incoming ones
        )
        generated_text = tokenizer.batch_decode(gen_tokens)[0] # decode generated tokens to output text
        truncated_text = tokenizer.batch_decode(input_ids)[0] # decode truncated input tokens to the truncated input text
        output_text = generated_text[len(truncated_text):] # remove input text from generated output

        return {"output": output_text}
    except Exception as e:
        return {"error": f"Server ERROR: {e}"}

# main page
@app.get("/")
def index(request: Request):
    # display the main template with the desired model header and model link parameters
    return templates.TemplateResponse("index.html", {
        "request": request,
    })
