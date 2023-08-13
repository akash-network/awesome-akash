
const asyncRequiest_T5 = async (text) => {
    const inferResponse = await fetch(`infer_t5?input=${text}`);
    const inferJson = await inferResponse.json();
    return inferJson.output;
};


const t5_Form = document.getElementById('t5-form');

t5_Form.addEventListener('submit', async (event) => {
  event.preventDefault();
  const t5_Input = document.getElementById('t5-input');
  const t5_Output = document.getElementById('t5-output');

  try {
    t5_Output.textContent = await asyncRequiest_T5(t5_Input.value);
  } catch (err) {
    console.error(err);
  }
});
