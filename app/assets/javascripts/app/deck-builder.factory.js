'use strict';

angular
  .module('demos_cfg')
  .factory('DeckBuilderFactory', DeckBuilderFactory);

DeckBuilderFactory.$inject = [
  '$http',
  'NotificationService'
];

function DeckBuilderFactory($http, NotificationService) {
  return {
    getStats: getStats
  };

  function getStats(params) {
    return postDecks(params)
      .then(function(result) {
        NotificationService.success('deck atualizado', 'done');

        return result;
      });
  }

  function postDecks(params) {
    return $http
      .post('/decks.json', { "deck": params })
      .then(function(result) { return result; })
      .catch(function(error){ NotificationService.error('ocorreu um erro'); });
  };
};

