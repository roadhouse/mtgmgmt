(function() {
  angular
    .module('demos_cfg', ['chart.js'])
    .controller('LiveSearchController', LiveSearchController)
    .controller('ManaChartController', ManaChartController)
    .controller('ColorChartController', ColorChartController)
    .controller('TypeChartController', TypeChartController)
    .factory('LiveSearchFactory', LiveSearchFactory);

  LiveSearchController.$inject = ['$scope', 'LiveSearchFactory'];
  ManaChartController.$inject = ['$scope'];
  ColorChartController.$inject = ['$scope'];
  TypeChartController.$inject = ['$scope'];
  LiveSearchFactory.$inject = ['$http'];

  function ManaChartController($scope) {
    $scope.$on('updateChart', function(event, data){
      $scope.labels = data.mana.labels;
      $scope.data = data.mana.data;
    })
  };

  function ColorChartController($scope) {
    $scope.$on('updateChart', function(event, data){
      $scope.labels = data.color.labels;
      $scope.data = data.color.data;
      $scope.colors = data.color.colors;
    })
  };

  function TypeChartController($scope) {
    $scope.$on('updateChart', function(event, data){
      $scope.labels = data.type.labels;
      $scope.data = data.type.data;
    })
  };

  function LiveSearchController($scope, LiveSearchFactory) {
    var deckEntry = {};

    $scope.change = function(text) {
      var vm = this;

      if (vm.search.length > 3) {
        LiveSearchFactory
          .get(vm.search) 
          .then(function(result) { vm.entries = result.data; });
      }
    };

    $scope.addCardToDeck = function($event) {
      var cardDeck = this;

      deckEntry[cardDeck.entry.id] = parseInt(cardDeck.copies);
      LiveSearchFactory
        .addCardToDeck({"deck": deckEntry})
        .then(function(result) { 
          $scope.$broadcast('updateChart', result.data);
        });

      $event.preventDefault();
    };
  };

  function LiveSearchFactory($http) {
    return {
      get: function(params) {
        return $http.get('/cards.json?query[name]=' + params);
      },
      addCardToDeck: function(params) {
        return $http.post('/decks.json', params);
      }
    }
  };
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
