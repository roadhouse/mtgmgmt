//= require spec.helper
'use strict';

describe('DeckBuilderController', function() {
  it('define actions', function() {
    var $scope = {};
    var controller = $controller('DeckBuilderController', { $scope: $scope });

    expect($scope.addToDeck).toBeDefined();
    expect($scope.deckEntry).toBeDefined();
  });

  it('it add 4 cards to deck', function() {
    var $scope = {};
    var controller = $controller('DeckBuilderController', { $scope: $scope });

    $scope.addToDeck(1, 4);
    expect($scope.deckEntry[1]).toBe(4);
  });

  describe('call DeckBuilderFactory', function() {
    var q;
    beforeEach(inject(function($controller, $rootScope, $q) {
      q = $q;
    }));

    it('call factory', function() {
      var $scope = {};
      var myService = jasmine.createSpyObj('DeckBuilderFactory', ['getStats']);
      myService.getStats.and.returnValue(q.when({result: 'adsdsaaa'}));

      $controller('DeckBuilderController', { $scope: $scope, DeckBuilderFactory: myService});

      $scope.addToDeck(1);
      expect(myService.getStats).toHaveBeenCalled();
    });
  })
});
