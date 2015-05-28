(function() {
  angular
    .module('demos_cfg', [])
    .controller('LiveSearchController', LiveSearchController)
    .factory('LiveSearchFactory', LiveSearchFactory);

  LiveSearchController.$inject = ['$scope', 'LiveSearchFactory'];
  LiveSearchFactory.$inject = ['$http'];

  function LiveSearchController($scope, LiveSearchFactory) {
    $scope.change = function(text) {
      var vm = this;

      LiveSearchFactory
        .get(vm.search) 
        .then(function(result){ vm.entries = result.data; });
    };
  }

  function LiveSearchFactory($http) {
    return {
      get: function(params) {
        return $http.get('/cards.json?query[name]=' + params)
      }
    }
  }
})();

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
