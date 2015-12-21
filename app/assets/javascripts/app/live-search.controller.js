'use strict';

angular
  .module('demos_cfg')
  .controller('LiveSearchController', LiveSearchController)

LiveSearchController.$inject = [
  '$scope',
  'DeckBuilderFactory',
  '$sce',
  '$timeout'
];

function LiveSearchController($scope, DeckBuilderFactory, $sce, $timeout) {
  $scope.addCardToDeck = addCardToDeck;
  $scope.deckEntry = {};

  function addCardToDeck() {
    var cardDeck = this;

    $scope.deckEntry[cardDeck.entry.id] = parseInt(cardDeck.copies);

    DeckBuilderFactory
      .addCardToDeck({"deck": $scope.deckEntry})
      .then(function(result) {
        $scope.$broadcast('updateChart', result.data);
        $scope.deck_list = result.data.deck_list;
        $scope.deck_size = result.data.deck_size;
        $scope.first_hand = result.data.first_hand;
      })
  };
};
