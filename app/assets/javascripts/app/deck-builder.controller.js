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
  $scope.removeToDeck = removeToDeck;

  function addToDeck(entryId) {
    var copies = $scope.deckEntry[entryId] || 0 ;

    $scope.deckEntry[entryId] = copies + 4;

    getStats($scope.deckEntry);
  };

  function removeToDeck(entryId) {
    var copies = $scope.deckEntry[entryId] || 0 ;

    $scope.deckEntry[entryId] = copies - 4;

    getStats($scope.deckEntry);
  };

  function getStats(deckList) {
    DeckBuilderFactory
      .getStats(deckList)
      .then(function(result) {
        $scope.deck = result.data;
        $scope.isValid = result.data.isValid ?  
          {icon: 'done', color:'green-text'} : 
          {icon: 'error_outline', color:'red-text'}
      });
  };
};
