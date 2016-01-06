﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Security;

namespace Future_Me
{
    public partial class manager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.Page.User.Identity.IsAuthenticated)
            {
                FormsAuthentication.RedirectToLoginPage();
            }
        }

        [WebMethod]
        public static string getUserEmail()
        {
            try
            {
                return HttpContext.Current.User.Identity.Name;
            }
            catch (Exception e)
            {
            }
            return null;
        }

        protected void btnControl_Click(object sender, EventArgs e)
        {
            //Server.Transfer("edit.aspx");
        }
    }
}