'use strict';

angular
  .module('demos_cfg')
  .factory('DeckBuilderFactory', DeckBuilderFactory);

DeckBuilderFactory.$inject = ['$http'];

function DeckBuilderFactory($http) {
  return {
    getStats: function(params) {
      var deckParams = { "deck": params }

      return $http.post('/decks.json', deckParams);
    }
  };
};

