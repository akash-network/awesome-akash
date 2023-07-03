// функция асинхронного запроса на сервер и получение ответа
const generateText = async (text) => {
    const inferResponse = await fetch(`infer_redpajama?prompt=${text}`);
    const inferJson = await inferResponse.json();
    return inferJson.output;
};

// получаем объект формы
const textGenForm = document.querySelector('.text-gen-form');

// добавить отслеживания события отправки формы (нажатия кнопки)
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
