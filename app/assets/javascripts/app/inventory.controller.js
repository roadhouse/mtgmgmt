'use strict';

angular
  .module('demos_cfg')
  .controller('InventoryController', InventoryController)

InventoryController.$inject = [
  '$scope',
  'CollectionFactory',
];

function InventoryController($scope, CollectionFactory) {
  $scope.add = add;
  $scope.remove = remove;

  function add(cardId) {
    CollectionFactory.add(cardId, 'want');
  };

  function remove(cardId) {
    CollectionFactory.remove(cardId, 'want');
  };
};
