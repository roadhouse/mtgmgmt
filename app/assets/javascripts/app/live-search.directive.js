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
      scope.template = attrs.template;
      scope.search = "";
      scope.priceStatus = priceStatus;
      scope.change = function() {
        if (scope.search.length > 5) { updateResults(attrs.source, scope, attrs.endpoint); }
      };

      if (attrs.default) { updateResults(attrs.source, scope, attrs.endpoint); }
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

  function updateResults(source, scope, endpoint) {
    if (endpoint) {
      return LiveSearchFactory.inventories(endpoint, scope.search)
        .then(function(result) { return result.data; })
        .then(function(results) { scope.entries = results; });
    }
    else {
      query(source, scope.search)
        .then(function(results) { scope.entries = results; });
    }
  };

  function query(source, search) {
    return LiveSearchFactory[source](search)
      .then(function(result) { return result.data; })
  };
};
