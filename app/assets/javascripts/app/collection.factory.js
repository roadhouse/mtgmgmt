'use strict';

angular
  .module('demos_cfg')
  .factory('CollectionFactory', CollectionFactory);

CollectionFactory.$inject = [
  '$http',
  'NotificationService'
];

function CollectionFactory($http, NotificationService) {
  return {
    add: addOne,
    remove: removeOne
  };

  function addOne(cardId, list) {
    var params = { copies: 1, card_id: cardId, list: list };

    postInventories(params)
      .then(function(result) {
        NotificationService.success('carta adicionada da coleção', 'add');

        return result;
      });
  };

  function removeOne(cardId, list) {
    var params = { copies: -1, card_id: cardId, list: list };

    postInventories(params)
      .then(function(result) {
        NotificationService.success('carta removida da coleção', 'delete');

        return result;
      })
  };

  function postInventories(params) {
    return $http
      .post('/inventories.json', { "inventory": params })
      .catch(function(error){
        NotificationService.error('ocorreu um erro');
      });
  };
};

