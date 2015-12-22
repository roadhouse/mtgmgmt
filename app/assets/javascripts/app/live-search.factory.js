'use strict';

angular
  .module('demos_cfg')
  .factory('LiveSearchFactory', LiveSearchFactory);

LiveSearchFactory.$inject = ['$http'];

function LiveSearchFactory($http) {
  return {
    get: function(params) {
      return $http.get('/cards.json?query=' + params);
    }
  };
};
