import gradio as gr
import random

def sentiment_analysis(text):
    """Simple demo function that simulates sentiment analysis"""
    if not text:
        return "Please enter some text!"
    
    # Simulate processing
    sentiments = ["Positive 😊", "Negative 😞", "Neutral 😐"]
    confidence = random.randint(60, 99)
    result = random.choice(sentiments)
    
    return f"Sentiment: {result}\nConfidence: {confidence}%"

def image_caption(image):
    """Simple demo function that simulates image captioning"""
    if image is None:
        return "Please upload an image!"
    
    captions = [
        "A beautiful landscape with mountains",
        "A person standing in front of a building",
        "An abstract colorful composition",
        "A close-up of nature",
        "A cityscape at sunset"
    ]
    
    return random.choice(captions)

# Create tabbed interface
with gr.Blocks(title="Gradio Demo on Akash") as demo:
    gr.Markdown("# Gradio Demo - Deployed on Akash Network")
    gr.Markdown("This is a simple demo showing how to deploy Gradio apps on Akash's decentralized cloud.")
    
    with gr.Tab("Text Analysis"):
        text_input = gr.Textbox(label="Enter text", placeholder="Type something here...")
        text_output = gr.Textbox(label="Analysis Result")
        text_button = gr.Button("Analyze")
        text_button.click(sentiment_analysis, inputs=text_input, outputs=text_output)
    
    with gr.Tab("Image Captioning"):
        image_input = gr.Image(label="Upload an image", type="numpy")
        image_output = gr.Textbox(label="Generated Caption")
        image_button = gr.Button("Generate Caption")
        image_button.click(image_caption, inputs=image_input, outputs=image_output)

if __name__ == "__main__":
    demo.launch(server_name="0.0.0.0", server_port=7860, share=False)