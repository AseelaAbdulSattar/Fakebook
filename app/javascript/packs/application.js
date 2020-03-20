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
require("packs/posts/index");
require("packs/home/index/button_click");

document.addEventListener("turbolinks:load", () => {
  $('[data-toggle="tooltip"]').tooltip();
  $('[data-toggle="popover"]').popover();
  $(".toast").toast({ autohide: false });
  $("#toast").toast("show");
});
