﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="Future_Me.index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" ng-app="myApp">
<head runat="server">
    <!--#include file="header.aspx"-->
    <meta name="google-signin-scope" content="profile email">
<meta name="google-signin-client_id" content="701272448744-o962ib0di7kft9s3p7jqmf8srhp9ed3r.apps.googleusercontent.com">
    <title>Email2Future</title>
</head>
<body>

    <form id="form1" name="form1" runat="server">
        <!--#include file="topbar.aspx"-->
        <div class="container">
            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 text-center">
                <div id="banner">
                    <h1>Send emails to yourself or your friends/family in the future</h1>
                </div>
            </div>
            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                <div class="registrationform">
                    <div class="form-horizontal">
                        <fieldset>
                            <legend>Send <i class="fa fa-pencil pull-right"></i></legend>
                            <div class="form-group">
                                <asp:Label ID="Label1" runat="server" Text="To Email" CssClass="col-lg-2 control-label"></asp:Label>
                                <div class="col-lg-10">
                                    <asp:TextBox ID="tbEmail" runat="server" placeholder="Email" CssClass="form-control"
                                        ng-model="email" ng-minlength="5" ng-maxlength="50" TextMode="Email" required></asp:TextBox>
                                </div>
                                <div ng-messages="form1.tbEmail.$error" ng-if='form1.tbEmail.$dirty'>
                                  <div ng-message="required">This field is required</div>
                                  <div ng-message="email">Your email address is invalid</div>
                                  <div ng-message="minlength">Your field is too short</div>
                                  <div ng-message="maxlength">Your field is too long</div>
                                </div>
                            </div>

                            <div class="form-group">
                                <asp:Label ID="Label2" runat="server" Text="Subject" CssClass="col-lg-2 control-label"></asp:Label>
                                <div class="col-lg-10">
                                    <asp:TextBox ID="tbSubject" runat="server" placeholder="Subject" CssClass="form-control"
                                        required></asp:TextBox>
                                </div>
                            </div>

                            <div class="form-group">
                                <asp:Label ID="Label6" runat="server" Text="Your Letter" CssClass="col-lg-2 control-label"></asp:Label>
                                <div class="col-lg-10">
                                    <asp:TextBox ID="tbLetter" runat="server" Text="Dear me in Future," CssClass="form-control" Rows="3" TextMode="MultiLine"
                                       required></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="Label3" runat="server" Text="On date" CssClass="col-lg-2 control-label"></asp:Label>
                                <div class="col-lg-10">
                                    <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" ng-model="date" required></asp:TextBox>
                                </div>
                                <div ng-messages="form1.txtDate.$error" ng-if='form1.txtDate.$dirty'>
                                  <div ng-message="required">This field is required</div>
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="Label4" runat="server" Text="View" CssClass="col-lg-2 control-label"></asp:Label>
                                <div class="col-lg-10" style="display: inline-block;">
                                    <asp:RadioButtonList ID="rbtList" runat="server"
                                        RepeatDirection="Horizontal" RepeatLayout="Table">
                                        <asp:ListItem Text="Can Edit" Value="1" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="Lock" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="Hide" Value="3"></asp:ListItem>
                                    </asp:RadioButtonList>

                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-lg-10 col-lg-offset-2">
                                    <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" Text="Submit" ng-disabled="form1.tbEmail.$invalid || form1.txtDate.$invalid"/>
                                    <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-warning" Text="Cancel" UseSubmitBehavior="False" />
                                </div>
                            </div>
                        </fieldset>
                    </div>
                </div>
            </div>
        </div>
        <!--#include file="footer.aspx"-->
        <script type="text/javascript">
            var _UserName;
            PageMethods.getUserEmail(onSuccess, onFailure);
            function onSuccess(result) {
                _UserName = result;
            }

            function onFailure(error) {
                alert(error);
            }
            $("#form1").submit(function (e) {
                // get id user if is login

                var _email = $('#tbEmail').val();
                var _Subject = $('#tbSubject').val();
                var _Letter = $('#tbLetter').val();
                var _DeliverOn = $('#txtDate').val();
                var _ViewStatus = $("[id*=rbtList] input:checked").val();
                var url = "addEmail"; // the script where you handle the form input.

                $.ajax({
                    type: "POST",
                    url: url,
                    data: { EmailTo: _email, Subject: _Subject, Letter: _Letter, DeliverOn: _DeliverOn, ViewStatus: _ViewStatus, userEmail: _UserName }, // serializes the form's elements.
                    success: function (data) {
                        alert("A letter is stored!"); // show response from the php script.
                        window.location.href = "index.aspx";
                    },
                    error: function (error) {
                        alert("Error: Can not store you letter!");
                    }
                });

                e.preventDefault(); // avoid to execute the actual submit of the form.
            });
        </script>
        <script type="text/javascript">
            $(function () {
                $("#txtDate").datepicker({
                    changeMonth: true,
                    changeYear: true,
                });
            });
        </script>
    </form>
</body>

</html>

