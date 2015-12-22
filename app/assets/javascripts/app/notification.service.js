'use strict';

angular
  .module('demos_cfg')
  .service('NotificationService', NotificationService);

NotificationService.$inject = [];

function NotificationService() {
  return {
    success: success,
    error: error
  };

  function success(msg, icon) {
    var icoName = icon || 'done';
    var icon = '<i class="material-icons left">'+ icoName  +'</i>';
    var background = 'green lighten-3';

    Materialize.toast(icon+ msg, 1000, background);
  };

  function error(msg) {
    var icon = '<i class="material-icons left">delete</i>';
    var background = 'red lighten-3';

    Materialize.toast(icon+ msg, 1000, background);
  };
};


