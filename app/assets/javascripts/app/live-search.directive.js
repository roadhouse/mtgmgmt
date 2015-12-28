angular
  .module('demos_cfg')
  .directive('liveSearch', LiveSearchDirective);

LiveSearchDirective.$inject = [
  'LiveSearchFactory',
  '$timeout'
];

function LiveSearchDirective(LiveSearchFactory, $timeout) {
  return {
    restrict: 'AE',
    replace: 'true',
    templateUrl: '/templates/live-search.html',
    link: function(scope, element, attrs) {
      scope.sourceData = attrs.source;
      scope.change = change;
    }
  };

  function change() {
    var vm = this;
    var repo = {
      cards: LiveSearchFactory.get(vm.search),
      inventories: LiveSearchFactory.inventories(vm.search)
    }

    if (vm.search.length > 5) {
      repo[vm.sourceData]
        .then(function(result) { vm.entries = result.data; })
        .then(function() {
          $timeout(function(){ $('.collapsible').collapsible({}); }, 500);
        });
    }
  };
};
