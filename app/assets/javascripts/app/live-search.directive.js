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
      scope.search = "";
      scope.source = attrs.source;

      scope.change = change;
      scope.priceStatus = priceStatus;

      if (attrs.default) { query(scope); };
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

  function change() {
    if (scope.search.length > 5) { query(scope); }
  };

  function query(scope) {
    LiveSearchFactory[scope.source](scope.search)
      .then(function(result) { scope.entries = result.data; })
  };
};
