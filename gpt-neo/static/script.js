
$(document).ready(function() {
    var text_box = $('#text-box');
    var talk_button = document.getElementById("talk-button");

    text_box.val("My name is Merve and my favorite"); // add default text to text-box

    // 'TALK TO ME' button click handle
    talk_button.addEventListener('click', async (event) => {
      try
      {
        $('.lds-spinner').show(); // show loading circle animation
        text = encodeURI($('#text-box').val()); // encode input text for URI
        const response = await fetch(`talk?input=${text}`); // request server with text from text-box
        const responseJson = await response.json(); // parse response as JSON

        if (responseJson.error == undefined) { // if there are no errors
          output_text = responseJson.output; // get result text from responce
          console.log(output_text);

          // call typing effect of the result text to the text-box
          new TypeIt("#text-box", {
            strings: output_text,
            speed: 20,
          }).go();

        } else { // if the server returned an error
          text_box.css('color', '#ff0303');
          text_box.val(responseJson.error);
        }

      } catch(error){
          alert('server request error')
      }
      $('.lds-spinner').hide(); // hide loading circle animation
    });

});


