// Select elements

const selectElements = () => {
  const views = document.querySelectorAll(".views_container")
  const shown = document.querySelector(".views_container.shown")
  const btns = document.querySelectorAll(".nav-icon")
}

// Callback function


  const toggleShown = (e) => {
  console.log(e.target.dataSet)
}

//event Listener



export {selectElements, toggleShown}
