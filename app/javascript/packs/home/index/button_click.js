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
  var likeableID = likeButton.match(/\d+/);
  is_liked = $(this).hasClass("color-blue");
  totalLikes = $(this).attr("totalLikes");
  $(this)
    .toggleClass("color-blue")
    .toggleClass("color-toggle")
    .toggleClass("a");
  report = likeButton.includes("report");
  if (likeButton.includes("post")) {
    var count = "#like-post-count";
    var icon = "#like-count";
    var text = "#like-text";
  } else if (likeButton.includes("comment")) {
    var count = "#like-comment-count";
    var icon = "#like-icon";
  }

  if ((!report && totalLikes == 1 && is_liked) || totalLikes == 0) {
    $(text + likeableID)
      .toggleClass("like")
      .toggleClass("disappear");
    $(icon + likeableID)
      .toggleClass("like")
      .toggleClass("disappear");
    if (totalLikes == 1) {
      $(this).attr("totalLikes", parseInt(totalLikes) - parseInt(1));
    } else {
      var updatecount = parseInt(totalLikes) + parseInt(1);
      $(count + likeableID).html(updatecount);
      $(this).attr("totalLikes", updatecount);
    }
  } else if (!report) {
    if (is_liked) {
      updatecount = parseInt(totalLikes) - parseInt(1);
      $(count + likeableID).html(updatecount);
      $(this).attr("totalLikes", updatecount);
    } else {
      updatecount = parseInt(totalLikes) + parseInt(1);
      $(count + likeableID).html(updatecount);
      $(this).attr("totalLikes", updatecount);
    }
  }
});
