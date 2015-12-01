'use strict';

angular
  .module('demos_cfg')
  .controller('ColorChartController', ColorChartController)

ColorChartController.$inject = [
  '$scope'
];

function ColorChartController($scope) {
  $scope.$on('updateChart', function(event, data){
    $scope.labels = data.color.labels;
    $scope.data = data.color.data;
    $scope.colors = data.color.colors;
  })
};

