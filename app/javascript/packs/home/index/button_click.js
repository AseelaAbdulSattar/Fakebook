$(document).on("click", ".show-comment", function () {
  var btnId = $(this).attr("id");
  $(".comment").each(function (index, value) {
    var jsonInfoDataId = $(this).data("id");
    if (btnId && btnId === jsonInfoDataId) {
      $(this).toggle();
    }
  });
});

$(document).on("click", ".show-comment-btn", function () {
  var btnId = $(this).attr("id");
  $(".comment-area").each(function (index, value) {
    var jsonInfoDataId = $(this).data("id");
    if (btnId && btnId == jsonInfoDataId) {
      $(this).toggle();
    }
  });
  $.ajax({
    url: "posts/" + btnId + "/post_comments",
    type: "get",
    data: { id: btnId },
    success: function (data) {
      $("#comments_section" + btnId).html(data);
    },
  });
});
$(document).on("click", ".like", function () {
  likeButton = $(this).attr("id");
  liked = $(this).attr("data");
  is_liked = $(this).hasClass("color-blue");
  totalLikes = $(this).attr("totalLikes");
  console.log(liked);
  $(this)
    .toggleClass("color-blue")
    .toggleClass("color-toggle")
    .toggleClass("a");
  var postID = likeButton.match(/\d+/);
  if (
    (is_liked && liked == 1 && totalLikes == 1) ||
    (liked == 0 && totalLikes == 0)
  ) {
    $("#like-text" + postID)
      .toggleClass("like")
      .toggleClass("disappear");
    $("#like-count" + postID)
      .toggleClass("like")
      .toggleClass("disappear");
    if (liked == 0 && totalLikes == 0 && !is_liked) {
      console.log("uuuuppppp");
      $("#like-post-count" + postID).html(parseInt(totalLikes) + parseInt(1));
      $(this).attr("totalLikes", parseInt(totalLikes) + parseInt(1));
    }
  } else {
    if (is_liked) {
      var updatecount = parseInt(totalLikes) - parseInt(1);
      $("#like-post-count" + postID).html(updatecount);
      $(this).attr("totalLikes", updatecount);
    } else {
      updatecount = parseInt(totalLikes) + parseInt(1);
      $("#like-post-count" + postID).html(updatecount);
      $(this).attr("totalLikes", updatecount);
    }
  }
});
