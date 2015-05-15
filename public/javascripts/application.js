$(function() {
  $(".card-image").on('click', function(event) { 
    $(".deck-card-preview img").attr("src", $(this).attr("data-card-image"));
    event.preventDefault();
  })

})

var app = angular.module('demos_cfg', []);

app.controller('main_control', function($scope, $http, $timeout) {
    $scope.search = null;
    $scope.change = function(text) {
      valtosend = $scope.search;
      $http.get('/cards.json?query[name]=' + valtosend).then(function(result){
    $scope.entries = result.data;
    });
    };
  });

$(document).ready(function(){
  $(".button-collapse").sideNav();

  $('select').material_select();

  $('.collapsible').collapsible({
    accordion : false // A setting that changes the collapsible behavior to expandable instead of the default accordion style
  });

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
  })
});
