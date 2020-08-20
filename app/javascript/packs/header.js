const headers = document.querySelectorAll('.header');
let prevScrollPos = window.pageYOffset;

window.addEventListener('scroll', () => {
  let currentScrollPos = window.pageYOffset;

  if (prevScrollPos < currentScrollPos) {
    headers.forEach((header) => {
      header.classList.add('hide');
    })
  }
  else {
    headers.forEach((header) => {
      header.classList.remove('hide');
    })
  }
  prevScrollPos = currentScrollPos;
});
