$(function() {
  $(".card-image").on('click', function(event) { 
    $(".deck-card-preview img").attr("src", $(this).attr("data-card-image")) 
  })
})
