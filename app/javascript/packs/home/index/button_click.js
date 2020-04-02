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
$(document).on("click", ".like", function() {
  likeButton = $(this).attr("id");
  console.log(likeButton);
  $(this)
    .toggleClass("color-blue")
    .toggleClass("color-toggle")
    .toggleClass("a");
});
