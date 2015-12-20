'use strict';

angular
  .module('demos_cfg')
  .controller('InventoryController', InventoryController)

InventoryController.$inject = [
  '$scope',
  'CollectionFactory',
];

function InventoryController($scope, CollectionFactory) {
  $scope.addToCollection = addToCollection;
  $scope.removeToCollection = removeToCollection;

  function addToCollection() {
    CollectionFactory.addOne($scope.card_id, $scope.list)
  };

  function removeToCollection() {
    CollectionFactory.removeOne($scope.card_id, $scope.list)
  }
};
