// var looper;
// var degrees = 0;
// function rotateAnimation(el,speed) {
//   var elem = document.getElementById(el);
//   if(navigator.userAgent.match("Chrome")){
//     elem.style.WebkitTransform = "rotate("+degrees+"deg)";
//   } else if(navigator.userAgent.match("Firefox")){
//     elem.style.MozTransform = "rotate("+degrees+"deg)";
//   } else if(navigator.userAgent.match("MSIE")){
//     elem.style.msTransform = "rotate("+degrees+"deg)";
//   } else if(navigator.userAgent.match("Opera")){
//     elem.style.OTransform = "rotate("+degrees+"deg)";
//   } else {
//     elem.style.transform = "rotate("+degrees+"deg)";
// }

//   looper = setTimeout('rotateAnimation(\''+el+'\','+speed+')',speed);
//   degrees+=2;

//   if(degrees > 359){
//     degrees = 1;
//   }
// }

// botton = document.querySelector("form");
// disc = document.querySelector("#disc");
// botton.addEventListener("submit", ()=> {
//   console.log(1);
//   console.log('disc', disc)
//    rotateAnimation('disc',10);
// })