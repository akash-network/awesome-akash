import streamlit as st
import random
import time

st.set_page_config(
    page_title="Streamlit Demo on Akash",
    page_icon="🚀",
    layout="centered"
)

st.title("Streamlit Demo — Deployed on Akash Network")
st.markdown(
    "This is a simple demo showing how to deploy Streamlit apps on Akash's decentralized cloud."
)

tab1, tab2 = st.tabs(["Text Analysis", "Image Captioning"])

# --- Tab 1: Sentiment Analysis ---
with tab1:
    st.subheader("Sentiment Analysis")
    text_input = st.text_area("Enter text", placeholder="Type something here...")

    if st.button("Analyze", key="text_btn"):
        if not text_input.strip():
            st.warning("Please enter some text!")
        else:
            with st.spinner("Analyzing..."):
                time.sleep(0.5)  # simulate processing
            sentiments = ["Positive 😊", "Negative 😞", "Neutral 😐"]
            confidence = random.randint(60, 99)
            result = random.choice(sentiments)
            st.success(f"**Sentiment:** {result}")
            st.metric(label="Confidence", value=f"{confidence}%")

# --- Tab 2: Image Captioning ---
with tab2:
    st.subheader("Image Captioning")
    uploaded = st.file_uploader("Upload an image", type=["png", "jpg", "jpeg", "webp"])

    if st.button("Generate Caption", key="img_btn"):
        if uploaded is None:
            st.warning("Please upload an image!")
        else:
            st.image(uploaded, caption="Uploaded Image", use_column_width=True)
            with st.spinner("Generating caption..."):
                time.sleep(0.5)
            captions = [
                "A beautiful landscape with mountains",
                "A person standing in front of a building",
                "An abstract colorful composition",
                "A close-up of nature",
                "A cityscape at sunset",
            ]
            st.success(f"**Caption:** {random.choice(captions)}")
