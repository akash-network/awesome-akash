import os
from fastapi import FastAPI, Request
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates
from transformers import AutoTokenizer, AutoModelForCausalLM

# Get tokens length settings variables
MAX_INPUT_TOKEN_LENGTH = int(os.environ.get('MAX_INPUT_TOKEN_LENGTH', 13))
MAX_NEW_TOKENS = int(os.environ.get('MAX_NEW_TOKENS', 11))
MODEL_NAME = os.environ.get('MODEL_NAME', 'gpt-neo-125M') # Get model name from enviroment variables

models_dict = {
    'gpt-neo-125M': ["GPT-Neo 125M", "https://huggingface.co/EleutherAI/gpt-neo-125m"],
    'gpt-neo-1.3B': ["GPT-Neo 1.3B", "https://huggingface.co/EleutherAI/gpt-neo-1.3B"],
    'gpt-neo-2.7B': ["GPT-Neo 2.7B", "https://huggingface.co/EleutherAI/gpt-neo-2.7B"],
    'gpt-neox-20b': ["GPT-NeoX-20B", "https://huggingface.co/EleutherAI/gpt-neox-20b"]
}

if MODEL_NAME not in models_dict:
    raise Exception(f"Wrong MODEL_NAME '{MODEL_NAME}' specified")

# Load model
tokenizer = AutoTokenizer.from_pretrained("EleutherAI/" + MODEL_NAME)
model = AutoModelForCausalLM.from_pretrained("EleutherAI/" + MODEL_NAME, device_map="auto")

# Set truncaction of input text from left (default 'right')
tokenizer.truncation_side = "left"

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
        "model_name": MODEL_NAME,
        "model_name_header": models_dict[MODEL_NAME][0],
        "model_link": models_dict[MODEL_NAME][1]
    })
