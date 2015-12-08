'use strict';
 
angular
  .module('demos_cfg')
  .controller('LiveSearchController', LiveSearchController)

LiveSearchController.$inject = [
  '$scope', 
  'LiveSearchFactory', 
  'DeckBuilderFactory', 
  'CollectionFactory', 
  '$sce', 
  '$timeout'
];

function LiveSearchController($scope, LiveSearchFactory, DeckBuilderFactory, CollectionFactory, $sce, $timeout) {
  $scope.deckEntry = {};

  $scope.addCardToDeck = addCardToDeck;
  $scope.addCardToCollection = addCardToCollection;
  $scope.change = change; 

  function addCardToCollection() {
    var cardDeck = this;

    var collectionEntry = {
      card_id: cardDeck.entry.id
        , copies: parseInt(cardDeck.copies)
        , list: cardDeck.list
    };

    CollectionFactory
      .addCardToCollection({"inventory": collectionEntry})
      .then(function(result) { 
        Materialize.toast('Adicionada a coleção '+result.data.inventory.list, 1500)
      });
  };

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

  function change() {
    var vm = this;

    if (vm.search.length > 6) {
      LiveSearchFactory
        .get(vm.search) 
        .then(function(result) { vm.entries = result.data; })

        $timeout(function(){ $('.collapsible').collapsible({}); }, 500);
    }
  };
};
