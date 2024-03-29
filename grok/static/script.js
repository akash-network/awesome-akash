const inference = async (text) => {
  const inferResponse = await fetch(`infer?input=${text}`);
  const inferJson = await inferResponse.json();
  console.log(inferJson.output);
  return inferJson.output;
};

const form = document.getElementById("form-container");
const loader = document.getElementById("loader");

form.addEventListener("submit", async (event) => {
  event.preventDefault();
  const promptInput = document.getElementById("prompt-input");
  const outputText = document.getElementById("output-text");

  try {
    outputText.style.display = "none";
    loader.style.display = "block";
    outputText.textContent = await inference(promptInput.value);
    outputText.style.display = "block";
    loader.style.display = "none";
  } catch (err) {
    console.error(err);
  }
});
