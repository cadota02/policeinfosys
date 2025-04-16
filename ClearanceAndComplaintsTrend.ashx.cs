using System;
using System.Web;
using MySql.Data.MySqlClient;
using System.Collections.Generic;
using Newtonsoft.Json;
using System.Web.Script.Serialization;

namespace policeinfosys
{
    
    /// <summary>
    /// Summary description for ClearanceAndComplaintsTrend
    /// </summary>
    public class ClearanceAndComplaintsTrend : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["myconnection"].ConnectionString;
            var year = DateTime.Now.Year;

            Dictionary<string, int> complaints = InitMonthDict();
            Dictionary<string, int> clearances = InitMonthDict();

            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();

                string query1 = "SELECT MONTH(DateFiled) as Month FROM complaints WHERE YEAR(DateFiled) = @year";
                MySqlCommand cmd1 = new MySqlCommand(query1, conn);
                cmd1.Parameters.AddWithValue("@year", year);
                MySqlDataReader reader1 = cmd1.ExecuteReader();
                while (reader1.Read())
                {
                    string month = MonthName(reader1.GetInt32("Month"));
                    complaints[month]++;
                }
                reader1.Close();

                string query2 = "SELECT MONTH(DateFiled) as Month FROM policeclearance WHERE YEAR(DateFiled) = @year";
                MySqlCommand cmd2 = new MySqlCommand(query2, conn);
                cmd2.Parameters.AddWithValue("@year", year);
                MySqlDataReader reader2 = cmd2.ExecuteReader();
                while (reader2.Read())
                {
                    string month = MonthName(reader2.GetInt32("Month"));
                    clearances[month]++;
                }
                reader2.Close();
            }

            var response = new
            {
                labels = MonthLabels(),
                complaints = complaints.Values,
                clearances = clearances.Values
            };

            context.Response.ContentType = "application/json";
            context.Response.Write(new JavaScriptSerializer().Serialize(response));
        }

        public bool IsReusable => false;

        private Dictionary<string, int> InitMonthDict()
        {
            var months = MonthLabels();
            var dict = new Dictionary<string, int>();
            foreach (var m in months) dict[m] = 0;
            return dict;
        }

        private string[] MonthLabels()
        {
            return new[] { "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" };
        }

        private string MonthName(int month)
        {
            return MonthLabels()[month - 1];
        }
    }
}