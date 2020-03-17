// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
import "bootstrap";
import "./src/application.scss";
import $ from "jquery";
global.$ = jQuery;

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");
require("jquery");
require("packs/posts");

document.addEventListener("turbolinks:load", () => {
  $('[data-toggle="tooltip"]').tooltip();
  $('[data-toggle="popover"]').popover();
  $(".toast").toast({ autohide: false });
  $("#toast").toast("show");
});

$(document).on("click", ".show-comment-btn", function() {
  var btnId = $(this).attr("id");
  $(".commentArea").each(function(index, value) {
    var jsonInfoDataId = $(this).data("id");
    if (btnId && btnId == jsonInfoDataId) {
      $(this).toggle();
    }
  });
  $.ajax({
    url: "home/" + btnId + "/get_comments",
    type: "get",
    data: { id: btnId },
    success: function(data) {
      $("#get_comments_here" + btnId).html(data);
    }
  });
});

$(document).on("click", ".show-comment", function() {
  var btnId = $(this).attr("id");
  $(".comment").each(function(index, value) {
    var jsonInfoDataId = $(this).data("id");
    if (btnId && btnId === jsonInfoDataId) {
      $(this).toggle();
    }
  });
});
