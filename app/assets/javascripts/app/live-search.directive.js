angular
  .module('demos_cfg')
  .directive('liveSearch', LiveSearchDirective);

LiveSearchDirective.$inject = [
  'LiveSearchFactory',
];

function LiveSearchDirective(LiveSearchFactory) {
  return {
    restrict: 'AE',
    replace: 'true',
    templateUrl: '/templates/live-search.html',
    link: function(scope, element, attrs) {
      scope.sourceData = attrs.source;
      scope.change = change;
      scope.priceStatus = priceStatus;

      scope.entries = attrs.default ? query(scope, "") : {};
    }
  };

  function priceStatus(str) {
    var status = {
      'up': {color: 'green-text', icon:'arrow_upward'},
      'down': {color: 'red-text', icon:'arrow_downward'},
      'equal': {color: 'blue-text', icon:'done'},
    };

    return status[str];
  };

  function query(x, str) {
    var repo = {
      cards: LiveSearchFactory.get(str),
      inventories: LiveSearchFactory.inventories(str)
    }

    repo[x.sourceData]
      .then(function(result) { x.entries = result.data; })
  }

  function change() {
    var vm = this;

    if (vm.search.length > 5) { query(vm, vm.search); }
  };
};
