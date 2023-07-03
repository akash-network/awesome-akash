// function of asynchronous request to the server and receiving a response
const generateText = async (text) => {
    const inferResponse = await fetch(`infer_redpajama?prompt=${text}`);
    const inferJson = await inferResponse.json();
    return inferJson.output;
};

// get the form object
const textGenForm = document.querySelector('.text-gen-form');

// add form submission event (button click) tracking 
textGenForm.addEventListener('submit', async (event) => {
  event.preventDefault();

  const textGenInput = document.getElementById('text-gen-input');
  const textGenOutput = document.querySelector('.text-gen-output');

  try {
    textGenOutput.innerHTML = await generateText(textGenInput.value);
  } catch (err) {
    console.error(err);
  }
});
