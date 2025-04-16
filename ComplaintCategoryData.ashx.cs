using System;
using System.Web;
using System.Collections.Generic;
using System.Web.Script.Serialization;
using MySql.Data.MySqlClient;
using System.Configuration;

namespace policeinfosys
{
    /// <summary>
    /// Summary description for ComplaintCategoryData
    /// </summary>
    public class ComplaintCategoryData : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "application/json";

            string connString = ConfigurationManager.ConnectionStrings["myconnection"].ConnectionString;
            var data = new List<object>();

            using (MySqlConnection conn = new MySqlConnection(connString))
            {
                conn.Open();
                MySqlCommand cmd = new MySqlCommand("SELECT Category, COUNT(*) AS Total FROM complaints GROUP BY Category", conn);
                var reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    data.Add(new
                    {
                        category = reader["Category"].ToString(),
                        total = Convert.ToInt32(reader["Total"])
                    });
                }
            }

            var json = new JavaScriptSerializer().Serialize(data);
            context.Response.Write(json);
        }

        public bool IsReusable => false;
       
    }
}