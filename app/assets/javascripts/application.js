$(document).ready(function() {
  function PieMenuInit(){   
    $('#outer_container').PieMenu({
      'starting_angel':$('#s_angle').val(),
      'angel_difference' : $('#diff_angle').val(),
      'radius':$('#radius').val(),
    });     
  }
  $(function() {          
    $("#submit_button").click(function() {reset(); }); 
    $( "#outer_container" ).draggable();
    PieMenuInit();

  });
  function reset(){
    if($(".menu_button").hasClass('btn-rotate'))
    $(".menu_button").trigger('click');

    $("#info").fadeIn("slow").fadeOut("slow");
    PieMenuInit();
  }
});
