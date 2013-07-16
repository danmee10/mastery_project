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
// scafolding for synonyms list
  $("#synonym-box").hide();

// returns appropriate popover content
  function popoverContent(content) {
    if (content == "options") {
      return $('#tool-buttons').html();
    } else if (content == "replace") {
      return $('#replacement-form').html();
    } else {
      return $('#synonym-box').html();
    }
  }

// define options popover and with appropriate content
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
    // open synonym list for current-word, on button click
    $("div.popover #synonyms").on("click",function() {
      line.popover('destroy');
      synonymList(wordSpelling,wordPosition,wordElement);
    });
  });

  replacementForm = function(wordSpelling, wordPosition, wordElement){
    definePopover("replace");
    wordElement.parent().popover('show');

    // assigns 'close popovers' and 'remove selected-word class' to click 'X'
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

  synonymList = function(wordSpelling, wordPosition, wordElement){
    definePopover("synonyms");
    wordElement.parent().popover('show');
    $(".progress-striped").show();

    // assigns 'close popovers' and 'remove selected-word class' to click 'X', also clears synonyms
    $("span#close-popover").on('click', function(){
      $('ul.synonyms').html("");
      $('td.line').popover('destroy');
      $("span.selected-word").removeClass("selected-word");
    });

    //get synonyms
    $.getJSON("/api/words/" + wordSpelling + ".json", function(data){
      var html = ''
      $.each(data.synonyms, function(entryIndex, entry) {
        html += '<li class="replacement-word">' + entry.spelling + '</li>';
      });

      $(".progress-striped").hide();

      $('ul.synonyms').html(html);
      if ($('ul.synonyms').is(':empty')) {
        $('ul.synonyms').text("Sorry, no synonyms found");
      }
      //clickable synonyms
      // $('ul.synonyms > li').each(function() {
      //   $(this).click(function() {

      //     var replacement = $(this).text();
      //     $.ajax({
      //             type: "PUT",
      //             url: "/api/poems/" + poemId + ".json",
      //             data: { old_word: wordPosition, new_word: replacement },
      //             dataType: "json"
      //           });

      //     wordElement.text(replacement);
      //     $(this).css("font-weight", "bold");

      //     $("span.selected-word").removeClass("selected-word");
      //     $('ul.synonyms').html("");
      //     wordElement.parent().popover('destroy');
      //   });
      // });
    });
    return false;
  }
});
// WTF ::
  // function whatever() {} -|vs|- whatever = function() {} -|vs|- var whatever = function() {}
