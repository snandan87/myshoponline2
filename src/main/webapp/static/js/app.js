'use strict';

var App = angular.module('myApp',[])
.config(function($locationProvider) {	
	$locationProvider.html5Mode({
		  enabled: true,
		  requireBase: false
		});
});




