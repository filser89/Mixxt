  const header = document.querySelector('.header');
  let prevScrollPos = window.pageYOffset;

  window.addEventListener('scroll', () => {
    let currentScrollPos = window.pageYOffset;

    if (prevScrollPos < currentScrollPos) {
      header.classList.add('hide');
    } else {
      header.classList.remove('hide');
    }
    prevScrollPos = currentScrollPos;
  })
