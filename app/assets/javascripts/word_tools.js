$(document).ready(function() {

// selected word's spelling
  function currentWord(){
    return $("span.selected-word").text();
  }

// buttons for editing words --hidden until popover called on word
  $('#tool-buttons').hide();
  function optionsMenu(){
    return $('#tool-buttons').html();
  }

// call options popover on a word, anchored to that word's row
  $('#poem-text').on('click', "span.word", function(evt){
    var wordSpelling = $(this).text();
    var wordPosition = this.id;
    var wordElement = $(this);
    var line = $(this).parent()

  // define options popover
    $('td.line').popover({
      placement: "left",
      trigger: "manual",
      html: true,
      title: function() { return currentWord(); },
      content: function() { return optionsMenu(); }
    });

    evt.stopPropagation();
    $("span.selected-word").removeClass("selected-word");
    $(this).addClass('selected-word');
    $( "td.line" ).not(line).popover('hide');
    line.data('popover').options.content = function() { return optionsMenu(); }
    line.popover('show');

    // close popovers and remove selected-word class on exit title bar
    $("h3.popover-title").on('click', function(){
      $('td.line').popover('hide');
      $("span.selected-word").removeClass("selected-word");
    });

    // open replacement form, on button click
    $("div.popover #replace-with").on("click",function() {
      replacementForm(wordSpelling,wordPosition,wordElement);
    });
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
