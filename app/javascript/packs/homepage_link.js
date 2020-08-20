//***copy link to clickboard
    document.querySelector('#copy').addEventListener("click", () => {
          copyText("msg")

          var modal = document.querySelector('#exampleModalCenter')
          modal.classList.remove('show')
          modal.style.display = 'none'
          document.querySelector("#link").value=""
          // loadDoc()
    })

    document.querySelector('#close').addEventListener("click", () => {
          var modal = document.querySelector('#exampleModalCenter')
          modal.classList.remove('show')
          modal.style.display = 'none'
          document.querySelector("#link").value=""
          // loadDoc()
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
