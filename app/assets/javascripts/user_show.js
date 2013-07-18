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

    // poem index search functionality
    // $("#search-poem-index").on("click", function(e){
    //   e.preventDefault;
    //   var self = $(this);
    //     // console.log($("#poem-index-search-form").val());

    //   $.getJSON("/api/poems.json?search=" + $("#poem-index-search-form").val(), function(data){
    //     var html = ''
    //       // console.log(data.poems[0].pic)
    //     $.each(data.poems, function(entryIndex, entry) {
    //       html += "<div class='poem-pic text-center'><img src='" + entry.pic + "'><div class='poem-title-link'>" + entry.title + "</div></div>";
    //       // console.log(entry.title)
    //     });
    //       // console.log(html)
    //     $(".masonry-container").html(html);
    //   });





    // });



  });
});



  // <%= form_tag poems_path, :method => :get, class: "form-search", :remote => true do %>
  //   <p>
  //     <%= text_field_tag :search, params[:search], class: "input-medium search-query" %>
  //     <%= submit_tag "Search", :name => nil, class: "btn btn-primary" %>
  //   </p>
