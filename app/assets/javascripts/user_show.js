$(document).ready(function(){
  var $container = $('.masonry-container');
  // initialize
  $container.imagesLoaded( function() {
    $container.masonry({
      columnWidth: 1,
      isAnimated: true,
      itemSelector: '.poem-pic',
      isFitWidth: true
    });
  });

  $(".poem-title-link").on("click", function(){

  });
});
