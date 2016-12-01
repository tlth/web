//= require jquery
//= require jquery_ujs
//= require jquery.remotipart
//= require turbolinks
//= require bootstrap
//= require moment
//= require moment/sv
//= require bootstrap-datetimepicker
//= require locales/bootstrap-datetimepicker.sv.js
//= require ekko-lightbox
//= require select2-full
//= require select2_locale_sv
//= require jquery_nested_form
//= require jquery.minicolors
//= require fileinput
//= require codemirror
//= require codemirror/modes/http
//= require codemirror/modes/htmlmixed
//= require summernote
//= require jquery.nestable
//= require zeroclipboard
//= require_tree .

jQuery.fn.exists = function() { return this.length > 0; };

$(document).delegate('*[data-toggle="lightbox"]', 'click', function(event) {
  event.preventDefault();
  $(this).ekkoLightbox();
});

$(document).on("page:change", function() {
  $("#twitter-feed").load("/tweets", function () {
    $("#twitter-feed").trigger('tweets_loaded');
  });
  $('.select2').select2();
  $('.dd').nestable({maxDepth: 2});
  $('.dd').nestable('collapseAll');

  $('#banner').on('slide.bs.carousel', function (event) {
    var link = $(event.relatedTarget).find('a').attr('href');
    $('#logo-link').attr('href', link);
  });

  if($(window).width() > 760 && !(navigator.msMaxTouchPoints > 0)){
    $('.navbar .dropdown > a').click( function(){
      location.href = this.href;
    });
  }
});
