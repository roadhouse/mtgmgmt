'use strict';

angular
  .module('demos_cfg')
  .controller('ManaChartController', ManaChartController)

ManaChartController.$inject = [
  '$scope'
];

function ManaChartController($scope) {
  $scope.$on('updateChart', function(event, data){
    $scope.labels = data.mana.labels;
    $scope.data = data.mana.data;
  })
};

