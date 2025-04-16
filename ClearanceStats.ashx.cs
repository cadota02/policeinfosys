using System;
using System.Web;
using MySql.Data.MySqlClient;
using System.Text;
using System.Data;
using Newtonsoft.Json;

namespace policeinfosys
{
    /// <summary>
    /// Summary description for ClearanceStats
    /// </summary>
    public class ClearanceStats : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "application/json";

            string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["myconnection"].ConnectionString;

            StatusStats stats = new StatusStats();

            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                string query = "SELECT Status, COUNT(*) AS Total FROM policeclearance GROUP BY Status";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                conn.Open();
                MySqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    string status = reader["Status"].ToString();
                    int count = Convert.ToInt32(reader["Total"]);

                    switch (status)
                    {
                        case "Pending": stats.Pending = count; break;
                        case "Approved": stats.Approved = count; break;
                        case "Rejected": stats.Rejected = count; break;
                        case "Released": stats.Released = count; break;
                    }
                }

                conn.Close();
            }

            context.Response.Write(JsonConvert.SerializeObject(stats));
        }

        public bool IsReusable { get { return false; } }
        public class StatusStats
        {
            public int Pending { get; set; }
            public int Approved { get; set; }
            public int Rejected { get; set; }
            public int Released { get; set; }
        }
    }
}