//= require application
//= require angular-mocks
//= require sinon
'use strict';

beforeEach(module('demos_cfg'));

var $controller;

beforeEach(inject(function(_$controller_) {
  $controller = _$controller_;

  return this.sandbox = sinon.sandbox.create();
}));
