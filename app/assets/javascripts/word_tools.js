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

// call options popover on a word, anchored to that word's row
  $('span.word').click(function(evt){
    var word = $(this).text();
    var wordPosition = this.id;
    var wordElement = $(this);

    evt.stopPropagation();
    $("span.selected-word").removeClass("selected-word");
    $(this).addClass('selected-word');
    $( "td.line" ).not($(this).parent()).popover('hide');
    $(this).parent().popover('show');
    $('td.line').data('popover').options.content = function() { return optionsMenu(); }

    // open replacement form, on button click
    $("div.popover #replace-with").on("click",function() {
      replacementForm(word,wordPosition,wordElement);
    });
  });

// form for manually replacing words
  replacementForm = function(word, wordPosition, wordElement) {
    var popover = wordElement.parent('td').data('popover');
    popover.options.content = function() { return  $('#replacement-form').html() };
    popover.show();
  }

// close popovers with outside click
  $(document).click(function(evt){
    evt.stopPropagation();
    // $('td.line').data('popover').options.content = function() { return optionsMenu(); }
    $('td.line').popover('hide')
  });
});

// WTF ::
  // stopPropagation + preventDefault
  // function whatever() {} |vs| whatever = function() {} |vs| var whatever = function() {}
