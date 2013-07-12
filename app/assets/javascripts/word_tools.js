$(document).ready(function() {

// define options popover
  $('td.line').popover({
    placement: "left",
    trigger: "manual",
    html: true,
    title: function() { return currentWord(); },
    content: function() { return optionsMenu(); }
  });

// selected word's spelling
  function currentWord(){
    return $("span.selected-word").text();
  }

// buttons for editing words --hidden until popover called on word
  $('#tool-buttons').hide();
  function optionsMenu(){
    return $('#tool-buttons').html();
  }

// apply selected-word class to words in focus
  // $('span.word').hover(function(){
  //   $(this).toggleClass("selected-word");
  // });

// kill .selected-word class if no popover visible

// call options popover on a word, anchored to that word's row
  $('span.word').click(function(evt){
    var wordSpelling = $(this).text();
    var wordPosition = this.id;
    var wordElement = $(this);
    var line = $(this).parent()

    evt.stopPropagation();
    $("span.selected-word").removeClass("selected-word");
    $(this).addClass('selected-word');
    $( "td.line" ).not(line).popover('hide');
    line.data('popover').options.content = function() { return optionsMenu(); }
    line.popover('show');


    // open replacement form, on button click
    $("div.popover #replace-with").on("click",function() {
      replacementForm(wordSpelling,wordPosition,wordElement);
    });
  });

  // close popovers with outside click
  $("body").not("#replace-with").not("span").click(function(){
    // $('td.line').popover('hide')
  });

// form for manually replacing words
  $("#replacement-form").hide();
  replacementForm = function(wordSpelling, wordPosition, wordElement){
    var popover = wordElement.parent('td').data('popover');
    popover.options.content = function() { return  $('#replacement-form').html(); }
    popover.show();

    // submits new word (or words?) to poems controller, and updates poem_text
    $("div.popover #replace-button").on("click", function(){
      var replacement = $("#replacement-text").val();
      $.ajax({
        type: "PUT",
        url: "/api/poems/" + 9 + ".json",
        data: { oldWord: wordPosition, newWord: replacement },
        dataType: "json"
      });
      wordElement.text(replacement)
      $("#replacement-form").hide();
    });
  }
});

// WTF ::
  // stopPropagation + preventDefault
  // function whatever() {} -|vs|- whatever = function() {} -|vs|- var whatever = function() {}
