function select2() {
  $('.select2').select2({
    theme: 'bootstrap',
    width: '100%',
    debug: true
  });
}

function select2Tags() {
  $('.select2_tags').select2({
    tags: true,
    theme: 'bootstrap',
    width: '100%',
    debug: true
  });
}

$(select2);
$(select2Tags);

