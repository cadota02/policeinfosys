using System;
using System.Web;
using System.Web.Script.Serialization;
using MySql.Data.MySqlClient;
using System.Configuration;
namespace policeinfosys
{
    /// <summary>
    /// Summary description for ComplaintStats
    /// </summary>
    public class ComplaintStats : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "application/json";

            string connString = ConfigurationManager.ConnectionStrings["myconnection"].ConnectionString;

            var stats = new
            {
                ThisMonth = 0,
                LastMonth = 0,
                Pending = 0,
                Resolved = 0,
                ActionsTaken = 0
            };

            using (MySqlConnection conn = new MySqlConnection(connString))
            {
                conn.Open();
                MySqlCommand cmd = new MySqlCommand(@"
                SELECT 
                    (SELECT COUNT(*) FROM complaints WHERE MONTH(DateFiled) = MONTH(CURDATE()) AND YEAR(DateFiled) = YEAR(CURDATE())) AS ThisMonth,
                    (SELECT COUNT(*) FROM complaints WHERE MONTH(DateFiled) = MONTH(CURDATE() - INTERVAL 1 MONTH) AND YEAR(DateFiled) = YEAR(CURDATE())) AS LastMonth,
                    (SELECT COUNT(*) FROM complaints WHERE Status = 'Pending') AS Pending,
                    (SELECT COUNT(*) FROM complaints WHERE Status = 'Resolved') AS Resolved,
                    (SELECT COUNT(*) FROM complaintactions) AS ActionsTaken;
            ", conn);

                var reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    stats = new
                    {
                        ThisMonth = Convert.ToInt32(reader["ThisMonth"]),
                        LastMonth = Convert.ToInt32(reader["LastMonth"]),
                        Pending = Convert.ToInt32(reader["Pending"]),
                        Resolved = Convert.ToInt32(reader["Resolved"]),
                        ActionsTaken = Convert.ToInt32(reader["ActionsTaken"])
                    };
                }
            }

            var json = new JavaScriptSerializer().Serialize(stats);
            context.Response.Write(json);
        }

        public bool IsReusable => false;
    }
}