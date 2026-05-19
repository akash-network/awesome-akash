# Streamlit Demo on Akash

[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-streamlit-demo)
<img width="2921" height="811" alt="streamlit-logo-primary-colormark-darktext" src="https://github.com/user-attachments/assets/f10e1237-8993-4f66-97f6-3ad3f7862578" />

Deploy interactive machine learning apps and data dashboards using Streamlit on Akash Network's decentralized cloud.

## What is Streamlit?

[Streamlit](https://streamlit.io) is an open-source Python library that lets you turn data scripts into shareable web apps in minutes — with no frontend experience required. It's the go-to tool for ML engineers and data scientists who want to:

- Demo machine learning models interactively
- Build data visualization dashboards
- Prototype and share AI-powered tools
- Create internal apps without writing HTML/CSS/JS

## What's Included

This template deploys a simple Streamlit application with two demo interfaces:

1. **Text Analysis** — Mock sentiment analysis with confidence scoring
2. **Image Captioning** — Mock image description generator with file upload

You can easily swap in your own models or logic by editing `app.py`.

## Deployment

### Deploy on Akash Console (Recommended)

1. Go to [console.akash.network](https://console.akash.network)
2. Click **Deploy** → **Build Your Template**
3. Upload the `deploy.yaml` file or use the one-click button above
4. Review resources and set your pricing bid
5. Sign and deploy
6. Access your Streamlit app at the provided URL on port 80

### Deploy via Akash CLI

1. **Clone the repository:**

```bash
git clone https://github.com/akash-network/awesome-akash.git
cd awesome-akash/streamlit-demo
```

2. **Create the deployment:**

```bash
akash tx deployment create deploy.yaml \
  --from <your-wallet> \
  --node https://rpc.akashnet.net:443 \
  --chain-id akashnet-2
```

3. **Accept a bid and create a lease**, then fetch your deployment URL from the lease status.

## Customization

### Use Your Own Model

Replace the demo functions in `app.py` with real ML logic. Example using HuggingFace Transformers:

```python
import streamlit as st
from transformers import pipeline

@st.cache_resource
def load_model():
    return pipeline("sentiment-analysis")

classifier = load_model()

st.title("Sentiment Analysis")
text = st.text_area("Enter text")

if st.button("Analyze"):
    result = classifier(text)[0]
    st.success(f"**{result['label']}** — {result['score']:.2%} confidence")
```

Then build a custom Docker image with your dependencies and update the `image:` field in `deploy.yaml`.

### Adjust Resources

Edit `deploy.yaml` to allocate more CPU or memory for heavier workloads:

```yaml
resources:
  cpu:
    units: 2.0      # Increase for CPU-intensive models
  memory:
    size: 4Gi       # Increase for larger models or datasets
  storage:
    size: 5Gi       # Increase if loading model weights from disk
```

### Add GPU Support

To run GPU-accelerated models, add a GPU resource block and use a CUDA-enabled base image:

```yaml
resources:
  cpu:
    units: 4.0
  memory:
    size: 16Gi
  storage:
    size: 20Gi
  gpu:
    units: 1
    attributes:
      vendor:
        nvidia:
          - model: rtx3090
```

## Port Reference

| Service   | Container Port | Exposed As |
|-----------|---------------|------------|
| Streamlit | 8501          | 80 (HTTP)  |

## Cost Estimate

Typical cost on Akash: **~$5–15/month** depending on provider and resource allocation — significantly cheaper than equivalent workloads on AWS, GCP, or Heroku.

## Example Use Cases

- Deploy HuggingFace models for text generation, classification, or translation
- Build interactive dashboards for data exploration
- Share ML research demos without provisioning servers
- Host internal tools accessible from anywhere

## Resources

- [Streamlit Documentation](https://docs.streamlit.io)
- [Akash Network Documentation](https://docs.akash.network)
- [Akash Console](https://console.akash.network)
- [HuggingFace Models](https://huggingface.co/models)

## Support

- Akash Discord: [discord.akash.network](https://discord.akash.network)
- Streamlit Community: [discuss.streamlit.io](https://discuss.streamlit.io)
