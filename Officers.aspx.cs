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

namespace policeinfosys
{
    public partial class Officers : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["myconnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                LoadOfficers();
            }
        }
        private void LoadOfficers()
        {
            using (MySqlConnection conn = new MySqlConnection(connString))
            {
                string query = "SELECT * FROM officers where IsActive =1";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                DataTable dt = new DataTable();

                try
                {
                    conn.Open();
                    da.Fill(dt);
                    rptOfficers.DataSource = dt;
                    rptOfficers.DataBind();
                }
                catch (Exception ex)
                {
                    AlertNotify.ShowMessage(this, ex.Message.ToString(), "Error", AlertNotify.MessageType.Error);
                }
            }
        }
    }
}