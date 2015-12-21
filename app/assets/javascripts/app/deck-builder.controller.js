'use strict';

angular
  .module('demos_cfg')
  .controller('DeckBuilderController', DeckBuilderController)

DeckBuilderController.$inject = [
  '$scope',
  'DeckBuilderFactory'
];

function DeckBuilderController($scope, DeckBuilderFactory) {
  $scope.addToDeck = addToDeck;
  $scope.removeToDeck = removeToDeck;

  $scope.deckEntry = {};

  function addToDeck(entryId) {
    var copies = $scope.deckEntry[entryId] | 0 ;

    $scope.deckEntry[entryId] = copies + 4;

    getStats($scope.deckEntry);
  };

  function removeToDeck(entryId) {
    var copies = $scope.deckEntry[entryId] | 0 ;

    $scope.deckEntry[entryId] = copies - 4;

    getStats($scope.deckEntry);
  };

  function getStats(deckList) {
    DeckBuilderFactory
      .getStats(deckList)
      .then(function(result) {
        $scope.$broadcast('updateChart', result.data);

        $scope.deck_list = result.data.deck_list;
        $scope.deck_size = result.data.deck_size;
        $scope.first_hand = result.data.first_hand;
      });
  };
};
