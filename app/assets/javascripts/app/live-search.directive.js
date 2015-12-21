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
      scope.change = change;
    }
  };

  function change() {
    var vm = this;

    if (vm.search.length > 6) {
      LiveSearchFactory
        .get(vm.search)
        .then(function(result) { vm.entries = result.data; })
        .then(function() {
          $timeout(function(){ $('.collapsible').collapsible({}); }, 500);
        });
    }
  };
};
