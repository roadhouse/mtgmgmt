'use strict';

angular
  .module('demos_cfg')
  .factory('CollectionFactory', CollectionFactory);

CollectionFactory.$inject = ['$http'];

function CollectionFactory($http) {
  return {
    addCardToCollection: function(params) {
      return $http.post('/inventories.json', params);
    }
  };
};

