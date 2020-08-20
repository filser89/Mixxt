// We'll save all chunks of audio in this array.
const chunks = [];

// We will set this to our MediaRecorder instance later.
let recorder = null;

// We'll save some html elements here once the page has loaded.
let startButton = null;
// let stopButton = null;

/**
 * Save a new chunk of audio.
 * @param  {MediaRecorderEvent} event
 */
const saveChunkToRecording = (event) => {
    chunks.push(event.data);
};

/**
 * Save the recording as a data-url.
 * @return {[type]}       [description]
 */
const saveRecording = () => {
    const blob = new Blob(chunks, {
        type: 'audio/mp4; codecs=opus'
    });
    // console.log(blob)
    return blob
};


const getUserToken = () => {
  console.log('running')
  return new Promise((resolve, reject) => {
    fetch('get-user-token')
    .then(response => response.json())
    .then(data => {
      console.log(data.token)
      resolve(data.token)
    });
  })

}
/**
 * Start recording.
 */
const startRecording = () => {
    startButton.innerText = "Listening..."
    recorder.start();
};

/**
 * Stop recording.
 */
const stopRecording = () => {
    recorder.stop();
    startButton.innerText = "Recognize!"
};

const recordAudio = () => {
  startRecording()
  setTimeout(stopRecording, 5000)
}

const callAuddApi = async (blob, callback) => {
  console.log("Calling api")
  let myHeaders = new Headers();
  let formdata = new FormData();
  formdata.append("return", "spotify");
  formdata.append("file", blob);

  let requestOptions = {
    method: "POST",
    headers: myHeaders,
    body: formdata,
    redirect: "follow",
    mode: "cors",
  };
  const token = getUserToken()
  token.then(res => {
    console.log(res)
  fetch(`https://api.audd.io/?api_token=${res}`, requestOptions)
    .then((response) => {
      console.log(response)
      return response.json();
    })
    .then((result) => {
      console.log(result);
      // assignValueToTextbox(result)
    })
  })

}

const assignValueToTextbox = (result) =>{
  const textbox = document.querySelector('#link')
  const spotifyLink = result.result.spotify.external_urls.spotify
  textbox.value = spotifyLink
}

const onStopFunc = async () => {
  callAuddApi(saveRecording(), assignValueToTextbox)
}

// Wait until everything has loaded
(function() {
    startButton = document.querySelector('.js-start');

    // We'll get the user's audio input here.
    navigator.mediaDevices.getUserMedia({
        audio: true // We are only interested in the audio
    }).then(stream => {
        // Create a new MediaRecorder instance, and provide the audio-stream.
        recorder = new MediaRecorder(stream);

        // Set the recorder's eventhandlers
        recorder.ondataavailable = saveChunkToRecording;
        recorder.onstop = onStopFunc;

    });

    // Add event listeners to the start button
    startButton.addEventListener('mouseup', recordAudio);
})();

