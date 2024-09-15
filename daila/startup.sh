echo "Get latest Dalai"
npm install dalai
echo "Starting download of models"
if [[ $MODEL_SIZE == "7B" ]]; then
MODEL_SIZE=7B
elif [[ $MODEL_SIZE == "13B" ]]; then
MODEL_SIZE=13B
elif [[ $MODEL_SIZE == "30B" ]]; then
MODEL_SIZE=30B
elif [[ $MODEL_SIZE == "65B" ]]; then
MODEL_SIZE=65B
else
echo "No default model size set, defaulting to 7B"
MODEL_SIZE=7B
fi


if [[ $LLAMA == true ]]; then
npx dalai llama install $MODEL_SIZE
echo "Cleaning up"
rm /root/dalai/llama/models/7B/ggml-model-f16.bin
rm /root/dalai/llama/models/7B/*.pth
else
echo "LLAMA model set false"
fi

if [[ $MODEL_SIZE == "7B" ]]; then
MODEL_SIZE=7B
elif [[ $MODEL_SIZE == "13B" ]]; then
MODEL_SIZE=13B
else
echo "No default model size set, defaulting to 7B"
MODEL_SIZE=7B
fi

if [[ $ALPACA == true ]]; then
npx dalai alpaca install $MODEL_SIZE
else
echo "ALPACA model set false"
fi

npx dalai serve
