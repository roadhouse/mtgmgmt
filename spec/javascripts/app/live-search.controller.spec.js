//= require spec.helper
'use strict';

describe('Foo', function() {
  it("does something", function() {
    expect(1 + 1).toBe(2);
  });
});

describe('LiveSearchController', function() {
  beforeEach(module('demos_cfg'));

  var $controller;

  beforeEach(inject(function(_$controller_){
    $controller = _$controller_;
  }));

  it("does something", function() {
    var $scope = {};
    var controller = $controller('LiveSearchController', { $scope: $scope });
  });
});
