import $ from 'jquery';
    // var looper;
    var degrees = 0;
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
        console.log()
        // console.log(popup)

      } else {
        degrees = 0
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

    const generateMessage = (message) =>{
      return `Spotify: ${message.spotify}\n NetEase: ${message.net_ease}\n QQ Music = ${message.qq}`
    }

    function popup (msg) {
      let link = document.querySelector("#link").value
      fetch(`fetch_msg?link=${link}`)
        .then(response => response.json())
        .then(data => {
          var modal = document.querySelector('#exampleModalCenter')
          modal.classList.add('show')
          modal.style.display = 'block'
          const message = data.msg
          console.log(message)
          document.querySelector('#msg').innerHTML = generateMessage(message)
      });
      // getElementById 'msg'
      // inject innerHTML with var msg

    }

    const clickFunc = () => {
      rotateAnimation('disc',1)
      setTimeout(popup (msg),2000)
      popup (msg)
    }

    mixxtbtn.addEventListener("click", clickFunc
  )


