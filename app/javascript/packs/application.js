// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("custom/disc")
require("local-time")
require("packs/header")
require("packs/copylink")
require("packs/home")
require("packs/homepage_link")
require("packs/disc_animation")



// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import 'popper.js'
import "bootstrap"
import 'jquery'
// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';

document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  // initSelect2();
});
// custom code


// Select elements

  const views = document.querySelectorAll(".views_container")
  const btns = document.querySelectorAll(".nav-icon")

// Callback function


  const toggleShown = (e) => {
    // e.preventDefault()

    const shown = document.querySelector(".views_container.shown")
    const divToShow = document.querySelector(`.${e.target.dataset.view}`)
    shown.classList.toggle("shown")
    divToShow.classList.toggle("shown")

}

//  Event listener

btns.forEach(btn => btn.addEventListener("click", toggleShown))



















