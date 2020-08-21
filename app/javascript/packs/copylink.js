//   let copyBtn = document.getElementById('copy');
// console.log("copied")
//   copyBtn.addEventListener('click', ()=> copyText("msg"));
  function shareLink(e) {
    // console.log(e)
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
              textArea.value = `Mixxt to your favorite app:\n Spotify: ${message.spotify}\n NetEase: ${message.net_ease}\n QQ Music: ${message.qq}\n Mixxt your own at: http://mixxt.wogenapp.cn`;
              document.body.append(textArea);
              textArea.select();
              document.execCommand('copy');   //No i18n
              document.body.removeChild(textArea);
              pop();
        });

      console.log(e)
  }

  const sharebuttons = document.querySelectorAll(".btn-blue")
  sharebuttons.forEach(btn => btn.addEventListener("click", function(e) {
    e.preventDefault();
    shareLink(e);
    setTimeout(function () {
            $('.popover').fadeOut('slow');
        }, 3000);
  }));


function pop () {
  console.log('pop')
  $('[data-toggle="popover"]').popover({
        delay: {
            "show": 100,
            "hide": 100
        }
    })
}
// document.querySelector('[data-toggle="popover"]').addEventListener("click", pop)
 const clickpics = document.querySelectorAll(".clickpic")
  clickpics.forEach(btn => btn.addEventListener("click", function(e) {
    e.preventDefault();
    shareLink(e);
  }));


