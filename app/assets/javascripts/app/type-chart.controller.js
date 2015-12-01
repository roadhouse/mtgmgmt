'use strict';

angular
  .module('demos_cfg')
  .controller('TypeChartController', TypeChartController)

TypeChartController.$inject = [
  '$scope'
];

function TypeChartController($scope) {
  $scope.$on('updateChart', function(event, data){
    $scope.labels = data.type.labels;
    $scope.data = data.type.data;
  })
};

