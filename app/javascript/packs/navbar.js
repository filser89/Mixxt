document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  // initSelect2();
  // alert("loaded");
  // Select elements
  console.log('loaded')

  const views = document.querySelectorAll(".views_container")
  const btns = document.querySelectorAll(".nav-icon")

// Callback function


  const toggleShown = (e) => {
    // e.preventDefault()
    console.log("e", e)

    let shown = document.querySelector(".views_container.shown")
    const divToShow = document.querySelector(`.${e.target.dataset.view}`)
    const navbar = document.querySelector(".navbar")
    shown.classList.toggle("shown")
    divToShow.classList.toggle("shown")
    let shownIcon = document.querySelector(".current")
    console.log(111, shownIcon.dataset.view)
    if (shownIcon.dataset.view === "home") {
      navbar.classList.remove("navbar-solid")
    } else {
      navbar.classList.add("navbar-solid")
    }
}

//  Event listener

  btns.forEach(btn => btn.addEventListener("click", toggleShown))
});
// custom code



