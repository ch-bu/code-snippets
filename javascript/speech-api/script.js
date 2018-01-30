if ('webkitSpeechRecognition' in window) {

  // Start synthesizer
  var synth = window.speechSynthesis;


  // Add event listener to stop button
  document.getElementById('stop').addEventListener('click', function() {
    recognition.stop();
  });

  // Speak content
  document.getElementById('speak').addEventListener('click', function() {
    let speech = document.getElementById('final_transcript').innerHTML;
    var utterThis = new SpeechSynthesisUtterance(speech);

    console.log(speech);
    utterThis.text = speech;
    utterThis.voice = window.speechSynthesis.getVoices()[0];
    utterThis.pitch = 2;
    utterThis.lang = 'de';
    utterThis.volumne = 1;
    utterThis.rate = 3;

    synth.speak(utterThis);
  });

  // Add event listener to stop button
  document.getElementById('start').addEventListener('click', function() {
    recognition.start();
  });

  // Init SpeechRecognition Object
  var recognition = new webkitSpeechRecognition();

  // Set recognition settings
  recognition.continuous = true;
  recognition.interimResults = true;
  recognition.lang = 'de';

  // Log when error occurs
  recognition.onerror = function(event) {
    console.log("Speech recognition started");
  };

  // Update text continuously
  recognition.onresult = function(event) {
    var interim_transcript = '';

    // Loop over every spoken word
    for (var i = 0; i < event.results.length; i++) {

      // Store interim results
      interim_transcript += event.results[i][0].transcript;

      // Update paragraph
      document.getElementById('final_transcript').innerHTML = interim_transcript;
    }
  }
}
