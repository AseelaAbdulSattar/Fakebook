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
