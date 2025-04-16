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
              //  LoadComplaintStats();
            }
        }
        //private void LoadComplaintStats()
        //{
        //    using (MySqlConnection conn = new MySqlConnection(connString))
        //    {
        //        conn.Open();

        //        MySqlCommand cmd = new MySqlCommand(@"
        //                SELECT 
        //                    (SELECT COUNT(*) FROM complaints WHERE MONTH(DateFiled) = MONTH(CURDATE()) AND YEAR(DateFiled) = YEAR(CURDATE())) AS ThisMonth,
        //                    (SELECT COUNT(*) FROM complaints WHERE MONTH(DateFiled) = MONTH(CURDATE() - INTERVAL 1 MONTH) AND YEAR(DateFiled) = YEAR(CURDATE())) AS LastMonth,
        //                    (SELECT COUNT(*) FROM complaints WHERE Status = 'Pending') AS Pending,
        //                    (SELECT COUNT(*) FROM complaints WHERE Status = 'Resolved') AS Resolved,
        //                    (SELECT COUNT(*) FROM complaintactions) AS ActionsTaken;
        //                 ", conn);

        //        MySqlDataReader reader = cmd.ExecuteReader();
        //        if (reader.Read())
        //        {
        //            lblThisMonth.Text = reader["ThisMonth"].ToString();
        //            lblLastMonth.Text = reader["LastMonth"].ToString();
        //            lblPending.Text = reader["Pending"].ToString();
        //            lblResolved.Text = reader["Resolved"].ToString();
        //            lblActions.Text = reader["ActionsTaken"].ToString();
        //        }
        //    }
        //}
       
      
    }
}