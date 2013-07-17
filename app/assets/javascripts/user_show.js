$(document).ready(function(){
  var $container = $('.masonry-container');
  // initialize
  $container.imagesLoaded( function() {
    var msnry = $container.masonry({
      columnWidth: 1,
      isAnimated: true,
      itemSelector: '.poem-pic',
      isFitWidth: true
    });

  });
});
