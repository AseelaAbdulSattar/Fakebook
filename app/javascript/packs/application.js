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
require("jquery");

document.addEventListener("turbolinks:load", () => {
  $('[data-toggle="tooltip"]').tooltip();
  $('[data-toggle="popover"]').popover();
  $(".toast").toast({ autohide: false });
  $("#toast").toast("show");
});

$(document).ready(function() {
  $(".showCommentbtn").click(function() {
    console.log("CALLED showCommentbtn chk --0");
    var btnId = $(this).attr("id");
    $(".commentArea").each(function(index, value) {
      var jsonInfoDataId = $(this).data("id");
      if (btnId == jsonInfoDataId) {
        console.log("CALLED");
        $(this).toggle();
      }
    });
    $.ajax({
      url: "home/" + btnId + "/get_comments",
      type: "get",
      data: { id: btnId },
      success: function(data) {
        console.log("data");
        $("#get_comments_here" + btnId).html(data);
      },
      error: function(data) {
        console.log("error", data);
        console.log(data);
      }
    });
  });
});

$(document).on("click", ".showComment", function() {
  var btnId = $(this).attr("id");
  $(".comment").each(function(index, value) {
    var jsonInfoDataId = $(this).data("id");
    if (btnId == jsonInfoDataId) {
      console.log("CALLED");
      $(this).toggle();
    }
  });
});
