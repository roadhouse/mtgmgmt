'use strict';

angular
  .module('demos_cfg')
  .factory('LiveSearchFactory', LiveSearchFactory);

LiveSearchFactory.$inject = ['$http', '$location'];

function LiveSearchFactory($http, $location) {
  return {
    cards: get,
    inventories: inventories,
    have: have,
    topCards: topCards
  };

  function get(params) {
    return $http.get('/cards.json?query=' + params);
  };

  function inventories(params) {
    return $http.get($location.path()+'.json?query=' + params);
  };

  function have(params) {
    return $http.get('/inventories/have.json?query=' + params);
  };

  function topCards(params) {
    return $http.get('/searches/top_cards.json?query=' + params);
  };
};

