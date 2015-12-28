'use strict';

angular
  .module('demos_cfg')
  .run(runBlock);

runBlock.$inject = [];

function runBlock() {
  $(document).ready(function(){
    $(".button-collapse").sideNav();
    $('select').material_select();
    $('.collapsible').collapsible({ accordion: false });
  });
}

