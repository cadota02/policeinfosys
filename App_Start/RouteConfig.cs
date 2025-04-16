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
        }
    }
}
