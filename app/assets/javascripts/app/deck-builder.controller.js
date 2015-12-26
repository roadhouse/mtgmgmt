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
          {icon: 'done', color:'green-text'} :
          {icon: 'error_outline', color:'red-text'}
        $scope.priceStatus = function(str) {
          var status = {
            'up': {color: 'green-text', icon:'arrow_upward'},
            'down': {color: 'red-text', icon:'arrow_downward'},
            'equal': {color: 'blue-text', icon:'done'},
          };

          console.log(status[str]);
          return status[str];
        }
      });
  };
};
