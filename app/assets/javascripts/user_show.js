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

    var msnry = $container.data('masonry');


    $("#public-poems").on("click", function(){
      $(".public-false").hide();
      $(".public-true").show();
      msnry.layout();
    });

    $("#private-poems").on("click", function(){
      $(".public-false").show();
      $(".public-true").hide();
      msnry.layout();
    });

    $("#all-poems").on("click", function(){
      $(".public-false").show();
      $(".public-true").show();
      msnry.layout();
    });
  });
});
