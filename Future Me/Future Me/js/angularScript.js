﻿'use strict';
angular.module('myApp', ['ngMessages']);
var myApp = angular.module('myApp');


myApp.directive('containDigitAndLetter',
  ['$http', function ($http) {

      return {
          require: 'ngModel',
          link: function (scope, element, attrs, ngModel) {
              var regular = /^([0-9]+[a-zA-Z]+|[a-zA-Z]+[0-9]+)[0-9a-zA-Z]*$/;

              ngModel.$parsers.push(function (value) {
                  if (new RegExp(regular).test(value))
                  {
                      ngModel.$setValidity('containDigitAndLetter', true);
                  }
                  else {
                      ngModel.$setValidity('containDigitAndLetter', false);
                  }
              })
          }
      }
  }]);
function signOut() {
    var auth2 = gapi.auth2.getAuthInstance();
    auth2.signOut().then(function () {
        console.log('User signed out.');
    });
}
