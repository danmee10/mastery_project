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
    evt.stopPropagation();

  // define options popover
    $('td.line').popover({
      placement: "left",
      trigger: "manual",
      html: true,
      title: function() { return currentWord(); },
      content: function() { return optionsMenu(); }
    });

    $("span.selected-word").removeClass("selected-word");
    $(this).addClass('selected-word');
    $( "td.line" ).not(line).popover('hide');
    line.data('popover').options.content = function() { return optionsMenu(); }
    line.popover('show');

    // close popovers and remove selected-word class on click title bar
    $("h3.popover-title").on('click', function(){
      $('td.line').popover('hide');
      $("span.selected-word").removeClass("selected-word");
    });

    // open replacement form, on button click
    $("div.popover #replace-with").on("click",function() {
      replacementForm(wordSpelling,wordPosition,wordElement);
    });
  });

// close popovers and remove selected-word class on press escape key
  // $(document).keypress(function(e) {
  //     if (e.keyCode == 27) {
  //         $("td.line").popover('hide');
  //         $("span.selected-word").removeClass("selected-word");
  //     }
  // });

// form for manually replacing words
  $("#replacement-form").hide();
  replacementForm = function(wordSpelling, wordPosition, wordElement){
    var poemId = parseFloat($(".poem-id").attr("id"));
    var popover = wordElement.parent('td').data('popover');
    popover.options.content = function() { return  $('#replacement-form').html(); }
    popover.show();

    // submits new word to poems controller, and updates poem_text
    $("div.popover").on("click", "#replace-button", function(){
      var replacement = $(this).siblings().val(); //why didn't $("#replacement-text").val() work here?

      $.ajax({
        type: "PUT",
        url: "/api/poems/" + poemId + ".json",
        data: { oldWord: wordPosition, newWord: replacement },
        dataType: "json"
      });
      wordElement.text(replacement);
      popover.destroy(); //if you just hide it, it will replace every word that has been changed on the row with the new word
    });
  }
});

// WTF ::
  // stopPropagation + preventDefault
  // function whatever() {} -|vs|- whatever = function() {} -|vs|- var whatever = function() {}
