'use strict';

angular
  .module('demos_cfg')
  .controller('DeckBuilderController', DeckBuilderController)

DeckBuilderController.$inject = [
  '$scope',
  'DeckBuilderFactory'
];

function DeckBuilderController($scope, DeckBuilderFactory) {
  $scope.deckEntry = {};

  $scope.addToDeck = addToDeck;

  function addToDeck(cardId, quantity) {
    var copies = $scope.deckEntry[cardId] || 0 ;

    $scope.deckEntry[cardId] = copies + quantity;

    getStats($scope.deckEntry);
  };

  function getStats(deckList) {
    DeckBuilderFactory
      .getStats(deckList)
      .then(function(result) {
        $scope.deck = result.data;
        $scope.isValid = result.data.isValid ?
          {icon: 'done', color:'green'} :
          {icon: 'error', color:'red'}
      });
  };
};
