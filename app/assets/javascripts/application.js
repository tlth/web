//= require jquery
//= require jquery_ujs
//= require jquery.remotipart
//= require turbolinks
//= require bootstrap
//= require moment
//= require moment/sv
//= require bootstrap-datetimepicker
//= require ekko-lightbox
//= require select2-full
//= require select2_locale_sv
//= require jquery_nested_form
//= require fileinput
//= require codemirror
//= require codemirror/modes/http
//= require codemirror/modes/htmlmixed
//= require summernote
//= require summernote/lang/summernote-sv-SE
//= require jquery.nestable
//= require zeroclipboard
//= require_tree .

jQuery.fn.exists = function() { return this.length > 0; };

$(document).delegate('*[data-toggle="lightbox"]', 'click', function(event) {
  event.preventDefault();
  $(this).ekkoLightbox();
});

$(document).on("turbolinks:load", function() {
  $("#twitter-feed").load("/tweets", function () {
    $("#twitter-feed").trigger('tweets_loaded');
  });
  $('.dd').nestable({maxDepth: 2});
  $('.dd').nestable('collapseAll');

  if($(window).width() > 760 && !(navigator.msMaxTouchPoints > 0)){
    $('.navbar .dropdown > a').click( function(){
      location.href = this.href;
    });
  }
});
