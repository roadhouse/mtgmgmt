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

$(document).ready(function() {
    $('select').material_select();
});
