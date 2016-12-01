var showImageLibraryDialog;

$(document).on("page:change", function() {
  $("#coverImageModal").on("show.bs.modal", function(e) {
    return $("[type='file'][id*='image']").fileinput({
      showUpload: false,
      showRemove: false,
      allowedFileExtensions: ['jpeg', 'jpg', 'png', 'bmp', 'gif']
    });
  });
  return $("#image-button").click(showImageLibraryDialog);
});

showImageLibraryDialog = function() {
  var $imageDialog;
  $imageDialog = $("#coverImageModal");
  $('#image-attributes').hide();
  return $imageDialog.one("shown.bs.modal", function() {
    $imageDialog.on("image_uploaded", null, function(event) {
      $imageDialog.modal("hide");
      $('[id*="image_id"]').attr('value', event.image_id);
      return $('#preview-image').attr('src', event.image_source);
    });

    return $("#insert-image").click(function(event) {
      event.preventDefault();
      var select = $('#_settings_cover_image_ids option');
      var selected = $('.img-selected').map(function() {
        return $(this).data('image-id');
      }).get();

      $('#_settings_cover_image_ids').val('');
      select.each(function(index) {
        if (parseInt(this.value) == parseInt(selected) || selected.includes(parseInt(this.value))) {
          this.selected = true;
        }
      });

      $(".img-selected").removeClass("img-selected");
      return $imageDialog.modal("hide");
    });
  }).one("hidden.bs.modal", function() {
    $('#image-attributes').show();
    $imageDialog.off("image_uploaded");
    return $("#insert-image").off("click");
  }).modal("show");
};
