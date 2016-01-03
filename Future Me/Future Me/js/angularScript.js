﻿'use strict';
angular
    .module('myApp', ['myApp.directives'])
    .controller("stageController", stageController);
/* Controllers */
function stageController($scope) {
    $scope.pw1 = 'pass';
}
/* Directives */
angular.module('myApp.directives', [])
    .directive('pwCheck', [function () {
        return {
            require: 'ngModel',
            link: function (scope, elem, attrs, ctrl) {
                var firstPassword = '#' + attrs.pwCheck;
                elem.add(firstPassword).on('keyup', function () {
                    scope.$apply(function () {
                        // console.info(elem.val() === $(firstPassword).val());
                        //console.info(elem.val());
                        console.info(elem.val() === scope[attrs.pwCheck]);

                        ctrl.$setValidity('pwmatch', elem.val() === scope[attrs.pwCheck]);
                        //scope.$apply();
                    });
                });
            }
        }
    }]);