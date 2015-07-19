(function() {
  'use strict';
  angular
    .module('demos_cfg', ['chart.js'])
    .controller('LiveSearchController', LiveSearchController)
    .controller('ManaChartController', ManaChartController)
    .controller('ColorChartController', ColorChartController)
    .controller('TypeChartController', TypeChartController)
    .factory('LiveSearchFactory', LiveSearchFactory)
    .factory('DeckBuilderFactory', DeckBuilderFactory)
    .factory('CollectionFactory', CollectionFactory);

  LiveSearchController.$inject = ['$scope', 'LiveSearchFactory', 'DeckBuilderFactory', 'CollectionFactory'];
  ManaChartController.$inject = ['$scope'];
  ColorChartController.$inject = ['$scope'];
  TypeChartController.$inject = ['$scope'];
  LiveSearchFactory.$inject = ['$http'];
  DeckBuilderFactory.$inject = ['$http'];
  CollectionFactory.$inject = ['$http'];

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

  function LiveSearchController($scope, LiveSearchFactory, DeckBuilderFactory, CollectionFactory) {
    var deckEntry = {};

    $scope.addCardToDeck = addCardToDeck;
    $scope.addCardToCollection = addCardToCollection;
    $scope.change = change; 

    function addCardToCollection() {
      var cardDeck = this;

      var collectionEntry = {
        card_id: cardDeck.entry.id
        , copies: cardDeck.copies
        , list: cardDeck.list
      };

      CollectionFactory
        .addCardToCollection({"collection": collectionEntry})
        .then(function(result) { console.log(result.data); });
    };
    
    function addCardToDeck() {
      var cardDeck = this;

      deckEntry[cardDeck.entry.id] = parseInt(cardDeck.copies);
      DeckBuilderFactory
        .addCardToDeck({"deck": deckEntry})
        .then(function(result) { 
          $scope.$broadcast('updateChart', result.data);
        });
    };
    
    function change() {
      var vm = this;

      if (vm.search.length > 6) {
        LiveSearchFactory
          .get(vm.search) 
          .then(function(result) { vm.entries = result.data; });
      }
    };
  };

  function LiveSearchFactory($http) {
    return {
      get: function(params) {
        return $http.get('/cards.json?query=' + params);
      }
    };
  };

  function DeckBuilderFactory($http) {
    return {
      addCardToDeck: function(params) {
        return $http.post('/decks.json', params);
      }
    };
  };
  
  function CollectionFactory($http) {
    return {
      addCardToCollection: function(params) {
        return $http.post('/collections.json', params);
      }
    };
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
