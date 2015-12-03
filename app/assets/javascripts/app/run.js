'use strict';

angular
  .module('demos_cfg')
  .run(runBlock);

runBlock.$inject = [
  '$document'
]

function runBlock($document) {
  $document.ready(function(){
    $(".button-collapse").sideNav();
    $('select').material_select();
    $('.collapsible').collapsible({ accordion: false });

    $(".collapsible").on("click.collapsible", function(e) {
      var down = "mdi-hardware-keyboard-arrow-down";
      var up = "mdi-hardware-keyboard-arrow-up";
      var element = $(e.target);

      element.parents().eq(2).find("i").attr("class", up);

      if (element.hasClass("active")) {
        element.find("i").attr("class", down)
      }
      else {
        element.find("i").attr("class", up)
      }
    });
  });
}

