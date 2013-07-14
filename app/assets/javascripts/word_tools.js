$(document).ready(function() {

// current poem's id
  var poemId = parseFloat($(".poem-id").attr("id"));


// selected word's spelling, and X for closing the popover
  $("#popover-title").hide();
// sets the popover title to the selected words spelling with an X for closing it
  function popoverTitle() {
    var spelling = $("span.selected-word").text();
    $("span.word-spelling").text(spelling);
    return $("#popover-title").html();
  }

// buttons for editing words --hidden until popover called on word
  $('#tool-buttons').hide();
// form for manually replacing words
  $("#replacement-form").hide();

// returns appropriate popover content
  function popoverContent(content) {
    if (content == "options") {
      return $('#tool-buttons').html();
    } else {
      return $('#replacement-form').html();
    }
  }

// define options popover and sets content
  function definePopover(content) {
    $('td.line').popover({
      placement: "left",
      trigger: "manual",
      html: true,
      title: function() { return popoverTitle(); },
      content: function() { return popoverContent(content); }
    });
  }

// call options popover on a word, anchored to that word's row
  $('#poem-text').on('click', "span.word", function(evt){
    var wordSpelling = $(this).text();
    var wordPosition = this.id;
    var wordElement = $(this);
    var line = $(this).parent();
    evt.stopPropagation();

    definePopover("options");

    $("span.selected-word").removeClass("selected-word");
    wordElement.addClass('selected-word');
    $( "td.line" ).not(line).popover('hide');
    line.popover('show');

    // close popovers and remove selected-word class on click 'X'
    $("span#close-popover").on('click', function(){
      $('td.line').popover('destroy');
      $("span.selected-word").removeClass("selected-word");
    });

    // open replacement form, on button click
    $("div.popover #replace-with").on("click",function() {
      line.popover('destroy');
      replacementForm(wordSpelling,wordPosition,wordElement);
    });
  });

  replacementForm = function(wordSpelling, wordPosition, wordElement){
    definePopover("fuckknickle");
    wordElement.parent().popover('show');

    // close popovers and remove selected-word class on click 'X'
    $("span#close-popover").on('click', function(){
      $('td.line').popover('destroy');
      $("span.selected-word").removeClass("selected-word");
    });

    // submits new word to poems controller, and updates poem_text
    $("div.popover").on("click", "#replace-button", function(){
      var replacement = $(this).siblings().val(); //why didn't $("#replacement-text").val() work here?

      $.ajax({
        type: "PUT",
        url: "/api/poems/" + poemId + ".json",
        data: { oldWord: wordPosition, newWord: replacement },
        dataType: "json"
      });
      $("span.selected-word").removeClass("selected-word");
      wordElement.text(replacement);
      wordElement.parent().popover('destroy');
    });
  }
});

// WTF ::
  // function whatever() {} -|vs|- whatever = function() {} -|vs|- var whatever = function() {}
