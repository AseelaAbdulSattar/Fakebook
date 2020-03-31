(function() {
  $(function() {
    if ($(".pagination").length && $("#posts").length) {
      $(window).scroll(function() {
        var url;
        url = $(".pagination .next_page a").attr("href");
        if (
          url &&
          $(window).scrollTop() > $(document).height() - $(window).height() - 50
        ) {
          $(".pagination").text("Loading...");
          // $(".pagination").html('<img src="/assets/images/ajax-loader.gif" alt="Loading..." title="Loading..." />');
          return $.getScript(url);
        }
      });
      return $(window).scroll();
    }
  });
}.call(this));
