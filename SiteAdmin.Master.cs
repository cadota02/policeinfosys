using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace policeinfosys
{
    public partial class SiteAdmin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.Page.User.Identity.IsAuthenticated)
            {
                FormsAuthentication.RedirectToLoginPage();
                Page.Response.Redirect("Login");

            }
           else
            {
                string username = Page.User.Identity.Name.ToString();
                var result = DBUserdefualt.GetUserIdAndRole(username);
                int userId = result.userId;
                Session["usersid"] = userId.ToString();
                string role = result.role;
                if(role =="Client")
                {
                  
                    Page.Response.Redirect("ClientClearance");
                }
                else if (role == "Cashier")
                {
                    // Show only billing
                    liHome.Visible = true;
                    liComplaints.Visible = false;
                    liClearance.Visible = false;
                    liOfficers.Visible = false;
                    liAccount.Visible = true;
                    aAccount.Visible = false;
                    liBilling.Visible = true;
                }
            }

        }
    }
}