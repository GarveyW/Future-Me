﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="manager.aspx.cs" Inherits="Future_Me.manager" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" ng-app="managerApp">
<head runat="server">
    <!--#include file="header.aspx"-->
    <link rel="stylesheet" href="css/style_table.css">
    <title>Email2Future</title>
</head>
<body ng-controller="mailsCtrl">
    <form id="myForm" name="myForm" runat="server">
        <!--#include file="topbar.aspx"-->
        <div class="container">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <div class="registrationform">
                    <div class="form-horizontal">
                        <table>
                            <thead>
                                <tr>
                                    <th>To Email</th>
                                    <th>Subject</th>
                                    <th>Letter</th>
                                    <th>On date</th>
                                    <th>View Status</th>
                                    <th>Status</th>
                                    <th>Edit/Delete</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr ng-repeat="mail in mails" ng-if="mail.ViewStatus != 3">
                                    <div>
                                        <td>{{mail.EmailTo}}</td>
                                        <td>{{mail.Subject}}</td>
                                        <td>{{mail.Letter}}</td>
                                        <td>{{mail.DeliverOn | date:'dd-MM-yyyy'}}</td>
                                        <td>
                                            <div ng-switch on="mail.ViewStatus">
                                                <span ng-switch-when="1">Can Edit</span>
                                                <span ng-switch-when="2">Lock</span>
                                                <span ng-switch-when="3">Hide</span>
                                            </div>
                                        </td>
                                        <td>
                                            <div ng-switch on="mail.Status">
                                                <span ng-switch-when="0">Waiting</span>
                                                <span ng-switch-when="1">Sent</span>
                                                <span ng-switch-when="2">Send Error</span>
                                            </div>
                                        </td>
                                        <td>
                                            <div style="overflow: auto; width: 100%;">
                                                <input id="btEdit" type="button" value="Edit" class="btn btn-primary" ng-click="edit(mail)" style="padding: 2px 3px;"
                                                    ng-disabled="!(mail.Status==0 && mail.ViewStatus==1)" />
                                                <input id="btDelete" type="button" value="X" class="btn btn-danger" ng-click="delete(mail)" style="padding: 2px 8px;" />
                                            </div>
                                        </td>
                                    </div>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!--#include file="footer.aspx"-->

        <script type="text/javascript">
            'use strict';
            var _UserName = "<%= HttpContext.Current.User.Identity.Name %>";

            managerApp.controller('mailsCtrl', function ($scope, myService, $http, $window) {
                var user = { email: _UserName };
                $http.post('getMailOf', user).success(function (data) {
                    $scope.mails = data;
                });

                $scope.delete = function (mail) {
                    var dataToPost = { ID: mail.ID, IDUser: mail.IDUser };
                    if (confirm("Do you really want to delete this?")) {
                        $http.post("deleteMail", dataToPost)
                        .success(function (data) {
                            alert("Done.");
                            location.reload();
                        })
                        .error(function (data) {
                            alert("failure");
                        });
                    }
                };
                $scope.edit = function (mail) {
                    myService.set(mail);
                    $window.location.href = "edit.aspx";
                };
            });
        </script>
    </form>
</body>
</html>

