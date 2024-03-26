const inference = async (text) => {
  const inferResponse = await fetch(`infer?input=${text}`);
  const inferJson = await inferResponse.json();
  return inferJson.output;
};

const form = document.getElementById("form-container");

form.addEventListener("submit", async (event) => {
  event.preventDefault();
  const promptInput = document.getElementById("prompt-input");
  const outputText = document.getElementById("output-text");

  try {
    outputText.textContent = await inference(promptInput.value);
  } catch (err) {
    console.error(err);
  }
});
