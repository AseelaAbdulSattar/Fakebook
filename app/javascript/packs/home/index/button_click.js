$(document).on("click", ".show-comment", function() {
  var btnId = $(this).attr("id");
  $(".comment").each(function(index, value) {
    var jsonInfoDataId = $(this).data("id");
    if (btnId && btnId === jsonInfoDataId) {
      $(this).toggle();
    }
  });
});

$(document).on("click", ".show-comment-btn", function() {
  var btnId = $(this).attr("id");
  $(".comment-area").each(function(index, value) {
    var jsonInfoDataId = $(this).data("id");
    if (btnId && btnId == jsonInfoDataId) {
      $(this).toggle();
    }
  });
  $.ajax({
    url: "home/" + btnId + "/post_comments",
    type: "get",
    data: { id: btnId },
    success: function(data) {
      $("#comments_section" + btnId).html(data);
    }
  });
});
$(document).ready(function() {
  console.log("check 45435451");
  clicked = true;
  likeButton = $(document).find(".like-p");
  console.log(likeButton);
  likeButton.on("click", () => {
    console.log("hello");
  });
  // $(document).on("click", ".like-p", function() {
  //   if (clicked) {
  //     console.log("check 1");
  //     $(this).css({ "font-color": "blue" });
  //     clicked = false;
  //   } else {
  //     $(this).css("background-color", "blue");
  //     clicked = true;
  //   }
  // });
});
// $(function() {
//   $("#my_form").on("submit", function(event) {
//     $.ajax({
//       type: "POST",
//       url: this.action,
//       data: $(this).serialize(),
//       success: function(response) {
//         //update the DOM
//       }
//     });
//     event.preventDefault();
//   });
// });
// .all-comments-show-hide: when refresh the page onclick doesn't work
