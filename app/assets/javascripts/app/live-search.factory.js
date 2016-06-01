'use strict';

angular
  .module('demos_cfg')
  .factory('LiveSearchFactory', LiveSearchFactory);

LiveSearchFactory.$inject = [
  '$http'
];

function LiveSearchFactory($http) {
  return {
    get: get
  };

  function endPoint(name) {
    var endpoints = {
      cards : '/cards.json',
      topCards: '/searches/top_cards.json'
    };

    return (endpoints[name] ? endpoints[name] : name);
  };

  function get(endpoint, params) {
    return $http.get(endPoint(endpoint) + '?query=' + params);
  };
};

