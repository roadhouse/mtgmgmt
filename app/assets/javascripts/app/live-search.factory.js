'use strict';

angular
  .module('demos_cfg')
  .factory('LiveSearchFactory', LiveSearchFactory);

LiveSearchFactory.$inject = ['$http'];

function LiveSearchFactory($http) {
  return {
    cards: get,
    inventories: inventories,
    have: have
  };

  function get(params) {
    return $http.get('/cards.json?query=' + params);
  };

  function inventories(params) {
    return $http.get('/inventories/want.json?query=' + params);
  };

  function have(params) {
    return $http.get('/inventories/have.json?query=' + params);
  };
};

