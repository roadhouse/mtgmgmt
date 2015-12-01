'use strict';

angular
  .module('demos_cfg')
  .factory('DeckBuilderFactory', DeckBuilderFactory);

DeckBuilderFactory.$inject = ['$http'];

function DeckBuilderFactory($http) {
  return {
    addCardToDeck: function(params) {
      return $http.post('/decks.json', params);
    }
  };
};

