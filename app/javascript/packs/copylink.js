  let copyBtn = document.getElementById('copy');
console.log("copied")
  copyBtn.addEventListener('click', ()=> copyText("msg"));

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
