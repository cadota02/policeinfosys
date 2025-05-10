using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Routing;
using Microsoft.AspNet.FriendlyUrls;

namespace policeinfosys
{
    public static class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            var settings = new FriendlyUrlSettings();
            settings.AutoRedirectMode = RedirectMode.Permanent;
            routes.EnableFriendlyUrls(settings);

            routes.MapPageRoute("admin1", "AdminHome", "~/Admin/AdminHome.aspx");
            routes.MapPageRoute("admin2", "Account", "~/Admin/Account.aspx");
            routes.MapPageRoute("admin3", "ManageOfficers", "~/Admin/ManageOfficers.aspx");
            routes.MapPageRoute("admin4", "ManageComplaint", "~/Admin/ManageComplaint.aspx");
            routes.MapPageRoute("admin5", "ManageClearance", "~/Admin/ManageClearance.aspx");
            routes.MapPageRoute("admin6", "ManageBill", "~/Admin/ManageBill.aspx");
            routes.MapPageRoute("admin7", "ManageCharges", "~/Admin/ManageCharges.aspx");
            routes.MapPageRoute("admin8", "BillingRecords", "~/Admin/BillingRecords.aspx");
            routes.MapPageRoute("admin9", "BillingReport", "~/Admin/BillingReport.aspx");
            //shared
            routes.MapPageRoute("shared1", "InvoicePrint", "~/Shared/InvoicePrint.aspx");
            //client
            routes.MapPageRoute("client1", "ClientHome", "~/Client/ClientHome.aspx");
            routes.MapPageRoute("client2", "ClientClearance", "~/Client/ClientClearance.aspx");
            routes.MapPageRoute("client3", "ClientComplaint", "~/Client/ClientComplaint.aspx");
            routes.MapPageRoute("changepass", "ChangePassword", "~/Shared/ChangePassword.aspx");
        }
    }
}
