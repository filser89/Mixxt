const icons = document.querySelectorAll('.nav-icon');

function deselect (icon) {
  icon.classList.remove('current')
}

function selectThis () {
  icons.forEach(deselect)
  this.classList.add('current')
}

icons.forEach((icon) => {
  icon.addEventListener('click', selectThis)
});
