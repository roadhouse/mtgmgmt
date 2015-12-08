//= require spec.helper
'use strict';

describe('LiveSearchController', function() {
  it('define actions', function() {
    var $scope = {};
    var controller = $controller('LiveSearchController', { $scope: $scope });

    expect($scope.addCardToDeck).toBeDefined();
    expect($scope.addCardToCollection).toBeDefined();
    expect($scope.change).toBeDefined();
  });
});
