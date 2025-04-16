using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MySql.Data.MySqlClient;
using System.Configuration;
using System.Web.Security;
using System.Web.Services;
using System.Web.Script.Serialization;

namespace policeinfosys.Admin
{
    public partial class AdminHome : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["myconnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadComplaintStats();
            }
        }
        private void LoadComplaintStats()
        {
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

                MySqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    lblThisMonth.Text = reader["ThisMonth"].ToString();
                    lblLastMonth.Text = reader["LastMonth"].ToString();
                    lblPending.Text = reader["Pending"].ToString();
                    lblResolved.Text = reader["Resolved"].ToString();
                    lblActions.Text = reader["ActionsTaken"].ToString();
                }
            }
        }
        [System.Web.Services.WebMethod]
        [System.Web.Script.Services.ScriptMethod]
        public static string GetComplaintCategoryData()
        {
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

            return new JavaScriptSerializer().Serialize(data);
        }
        //[WebMethod]
        //public static string GetComplaintCategoryData()
        //{
        //    string connString = ConfigurationManager.ConnectionStrings["myconnection"].ConnectionString;
        //    var result = new List<object>();

        //    using (MySqlConnection conn = new MySqlConnection(connString))
        //    {
        //        conn.Open();
        //        string query = "SELECT Category, COUNT(*) AS Count FROM complaints GROUP BY Category";

        //        using (MySqlCommand cmd = new MySqlCommand(query, conn))
        //        using (MySqlDataReader rdr = cmd.ExecuteReader())
        //        {
        //            while (rdr.Read())
        //            {
        //                result.Add(new
        //                {
        //                    Category = rdr["Category"].ToString(),
        //                    Count = Convert.ToInt32(rdr["Count"])
        //                });
        //            }
        //        }
        //    }

        //    return new JavaScriptSerializer().Serialize(result);
        //}
    }
}