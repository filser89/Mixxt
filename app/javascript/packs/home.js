
    // var looper;
    var degrees = 0;
    //***button animation
    // fetch /fetch-msg, pass param link
    // get a response
    // parse the data
    // data.msg
    // pass msg to popup
    const mixxtbtn= document.querySelector("#mixxtbtn")


     function rotateAnimation(el,speed) {
      var elem = document.getElementById(el);
      elem.style.zIndex = 10

      if(navigator.userAgent.match("Chrome")){
        elem.style.WebkitTransform = "rotate("+degrees+"deg)";
      } else if(navigator.userAgent.match("Firefox")){
        elem.style.MozTransform = "rotate("+degrees+"deg)";
      } else if(navigator.userAgent.match("MSIE")){
        elem.style.msTransform = "rotate("+degrees+"deg)";
      } else if(navigator.userAgent.match("Opera")){
        elem.style.OTransform = "rotate("+degrees+"deg)";
      } else {
        elem.style.transform = "rotate("+degrees+"deg)";
      }
      if (degrees < 360) {
        setTimeout(() => {rotateAnimation(el, speed)},1)
        degrees+=1;
        document.querySelector('.glow-on-hover').style.opacity = 0.8
        // console.log(popup)

      } else {
        degrees = 0
        popup(msg)
        elem.style.zIndex = 0
        document.querySelector('.glow-on-hover').style.opacity = 0
        if(navigator.userAgent.match("Chrome")){
          elem.style.WebkitTransform = "rotate(0deg)";
        } else if(navigator.userAgent.match("Firefox")){
          elem.style.MozTransform = "rotate(0deg)";
        } else if(navigator.userAgent.match("MSIE")){
          elem.style.msTransform = "rotate(0deg)";
        } else if(navigator.userAgent.match("Opera")){
          elem.style.OTransform = "rotate(0deg)";
        } else {
          elem.style.transform = "rotate(0deg)";
        }
      }

      return degrees
    }
    //***generate link by popup
    const generateMessage = (message) =>{
      return `Mixxt to your favorite app:\n Spotify: ${message.spotify}\n NetEase: ${message.net_ease}\n QQ Music: ${message.qq}\n Mixxt your own at: http://mixxt.wogenapp.cn`
    }
    function linkvalid (link) {
      if (link.match(/https:\/\/c.y.qq.com/)===null && link.match(/https:\/\/y.music.163.com/)===null && link.match(/https:\/\/open.spotify.com/)===null) {
        return false
      }
      else {
        return true
      }
    }

    function displaymessage() {
      var modal = document.querySelector('#exampleModalCenter')
      modal.classList.add('show')
      modal.style.display ='block'
    }

    function popup (msg) {
      let link = document.querySelector("#link").value
      if (link===""){
        displaymessage()
        document.querySelector('#msg').innerHTML = 'Please drop your link above!'
        document.querySelector('#copy').innerHTML = 'Okay'
        document.querySelector('#exampleModalLongTitle').innerHTML = ''
      }
      else if (linkvalid(link)===false) {
        console.log(linkvalid(link))
        displaymessage()
        document.querySelector('#msg').innerHTML = 'Oops, we do not recognise your link!'
      }
      else {
      fetch(`fetch_msg?link=${link}`)
        .then(response => response.json())
        .then(data => {
          console.log(data)
          var modal = document.querySelector('#exampleModalCenter')
          modal.classList.add('show')
          modal.style.display = 'block'
          document.querySelector('#exampleModalLongTitle').innerHTML = 'Your link has been generated'
          document.querySelector('#copy').innerHTML = 'Got the link, ready to share!'
          const message = data.msg
          document.querySelector('#msg').innerHTML = generateMessage(message)
      });

      }
      // getElementById 'msg'
      // inject innerHTML with var msg

    }

    const clickFunc = () => {
      rotateAnimation('disc',1)
      // setTimeout(popup(msg),5000)

    }

    mixxtbtn.addEventListener("click", clickFunc)

    //***copy link to clickboard
    document.querySelector('#copy').addEventListener("click", () => {
          copyText("msg")

          var modal = document.querySelector('#exampleModalCenter')
          modal.classList.remove('show')
          modal.style.display = 'none'
          document.querySelector("#link").value=""
    })

    document.querySelector('#close').addEventListener("click", () => {
          var modal = document.querySelector('#exampleModalCenter')
          modal.classList.remove('show')
          modal.style.display = 'none'
          document.querySelector("#link").value=""
    })

    function copyText(ev){
      console.log("hi");
      let div = document.getElementById(ev);
      let text = div.innerText;
      let textArea  = document.createElement('textarea');
      textArea.width  = "1px";
      textArea.height = "1px";
      textArea.background =  "transparents" ;
      textArea.value = text;
      document.body.append(textArea);
      textArea.select();
      document.execCommand('copy');   //No i18n
      document.body.removeChild(textArea);
    }

const icons = document.querySelectorAll('.nav-icon');

function deselect (icon) {
  icon.classList.remove('active')
}

function selectThis () {
  icons.forEach(deselect)
  this.classList.add('active')
}

icons.forEach((icon) => {
  icon.addEventListener('click', selectThis)
});



