//   let copyBtn = document.getElementById('copy');
// console.log("copied")
//   copyBtn.addEventListener('click', ()=> copyText("msg"));
  function shareLink(e) {
    const song_id = e.target.dataset.song_id
    fetch(`share_from_btn?song_id=${song_id}`)
          .then(response => response.json())
          .then(data => {
              const message = data.msg
              console.log(message)
              let textArea  = document.createElement('textarea');
              textArea.width  = "1px";
              textArea.height = "1px";
              textArea.background =  "transparents" ;
              textArea.value = `Spotify: ${message.spotify}\n NetEase: ${message.net_ease}\n QQ Music: ${message.qq}`
              document.body.append(textArea);
              textArea.select();
              document.execCommand('copy');   //No i18n
              document.body.removeChild(textArea);
        });

  }

  const sharebuttons = document.querySelectorAll(".btn-blue")
  sharebuttons.forEach(btn => btn.addEventListener("click", shareLink));
