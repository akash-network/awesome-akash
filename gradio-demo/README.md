# Gradio Demo on Akash
![Gradio](gradio-logo.png)
[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-gradio-demo)
Deploy interactive machine learning demos and data apps using Gradio on Akash Network's decentralized cloud.

## What is Gradio?

Gradio is a Python library that allows you to quickly create customizable web interfaces for machine learning models, APIs, or any Python function. Perfect for:
- Demoing ML models
- Creating interactive data visualizations
- Building simple web tools without learning web development
- Prototyping AI applications

## What's Included

This template deploys a simple Gradio application with two demo interfaces:
1. **Text Analysis** - Mock sentiment analysis demo
2. **Image Captioning** - Mock image description generator

You can easily customize `app.py` to add your own models or functions.

## Deployment

### Prerequisites
- Akash CLI installed
- Akash wallet with ACT tokens
- Basic familiarity with Akash deployments

### Deploy on Akash

1. **Clone this repository:**
```bash
   git clone https://github.com/akash-network/awesome-akash.git
   cd awesome-akash/gradio-demo
```

2. **Deploy using Akash CLI:**
```bash
   akash tx deployment create deploy.yaml --from <your-wallet> --node https://rpc.akashnet.net:443 --chain-id akashnet-2
```

3. **Get your deployment URL:**
   After deployment, check your lease status to find the public URL where your Gradio app is accessible.

### Deploy on Akash Console

1. Go to [console.akash.network](https://console.akash.network)
2. Click "Deploy" → "Build Your Template"
3. Upload the `deploy.yaml` file
4. Configure resources and pricing
5. Sign and deploy
6. Access your app via the provided URL

## Customization

### Add Your Own Model

Edit `app.py` to replace the demo functions with your actual ML models:
```python
import gradio as gr
from transformers import pipeline

# Load your model
classifier = pipeline("sentiment-analysis")

def analyze_sentiment(text):
    result = classifier(text)[0]
    return f"Sentiment: {result['label']}\nConfidence: {result['score']:.2%}"

demo = gr.Interface(
    fn=analyze_sentiment,
    inputs=gr.Textbox(label="Enter text"),
    outputs=gr.Textbox(label="Result"),
    title="Sentiment Analysis on Akash"
)

demo.launch(server_name="0.0.0.0", server_port=7860)
```

### Adjust Resources

Modify the `deploy.yaml` file to allocate more CPU/RAM if you're running larger models:
```yaml
resources:
  cpu:
    units: 2.0  # Increase for heavier workloads
  memory:
    size: 4Gi   # Increase for larger models
```

## Cost

Estimated cost on Akash: **~$5-15/month** depending on provider and resource allocation.

Significantly cheaper than AWS, Google Cloud, or Heroku for similar workloads.

## Resources

- [Gradio Documentation](https://gradio.app/docs/)
- [Akash Network Documentation](https://docs.akash.network)
- [Akash Console](https://console.akash.network)

## Example Use Cases

- Deploy Hugging Face models for text generation, translation, or classification
- Create data visualization dashboards
- Build interactive demos for research papers or projects
- Host ML model APIs accessible from anywhere

## Support

For issues or questions:
- Akash Discord: [discord.akash.network](https://discord.akash.network)
- Gradio Community: [huggingface.co/spaces](https://huggingface.co/spaces)