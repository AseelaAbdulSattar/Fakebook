// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
import "bootstrap";
import "./src/application.scss";

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");

document.addEventListener("turbolinks:load", () => {
  $('[data-toggle="tooltip"]').tooltip();
  $('[data-toggle="popover"]').popover();
  $(".toast").toast({ autohide: false });
  $("#toast").toast("show");
});

// $(document).ready(function() {
//   $(".showCommentbtn").click(function() {
//     console.log("CALLED");
//     $(".commentArea").toggle();
//   });
// });

$(document).ready(function() {
  $(".showCommentbtn").click(function() {
    var btnId = $(this).attr("id");
    $(".commentArea").each(function(index, value) {
      var jsonInfoDataId = $(this).data("id");
      if (btnId == jsonInfoDataId) {
        console.log("CALLED");
        $(this).toggle();
      }
    });
  });
});

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
