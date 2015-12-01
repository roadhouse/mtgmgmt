'use strict';

angular
  .module('demos_cfg')
  .config(configure);

function configure() {
  $(document).ready(function(){
    $(".button-collapse").sideNav();
    $('select').material_select();
    $('.collapsible').collapsible({ accordion: false });
  });
}
