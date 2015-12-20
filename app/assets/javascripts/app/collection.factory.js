'use strict';

angular
  .module('demos_cfg')
  .factory('CollectionFactory', CollectionFactory);

CollectionFactory.$inject = [
  '$http'
];

function CollectionFactory($http) {
  return {
    addOne: addOne,
    removeOne: removeOne
  };

  function addOne(cardId, list) {
    var params = { copies: 1, card_id: cardId, list: list };

    postInventories(params)
      .then(function(result) {
        Materialize.toast('Adicionada a coleção '+result.data.inventory.list, 1500);
        return result;
      });
  };

  function removeOne(cardId, list) {
    var params = { copies: -1, card_id: cardId, list: list };

    postInventories(params)
      .then(function(result) {
        Materialize.toast('Removida da coleção '+result.data.inventory.list, 1500);
        return result;
      });
  };

  function postInventories(params) {
    var inventoryParams = { "inventory": params };

    return $http.post('/inventories.json', inventoryParams);
  };
};

