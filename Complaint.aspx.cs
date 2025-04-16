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
using System.IO;

namespace policeinfosys
{
    public partial class Complaint : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["myconnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ddlCategory.DataSource = Enum.GetValues(typeof(ComplaintCategory));
                ddlCategory.DataBind();
            }
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string fullName = txtFullName.Text.Trim();
                string contact = txtContact.Text.Trim();
                string place = txtPlace.Text.Trim();
                string details = txtDetails.Text.Trim();
                string category = ddlCategory.SelectedValue;
                string fileName = "";
                string savePath = "";
                // Handle File Upload
                if (fuEvidence.HasFile)
                {
                    string ext = Path.GetExtension(fuEvidence.FileName);
                    fileName = "~/Content/images/complaint/" + "evidence_" + DateTime.Now.Ticks + ext;
                     savePath = Server.MapPath(fileName);
                    fuEvidence.SaveAs(savePath);
                }

                using (MySqlConnection conn = new MySqlConnection(connString))
                {
                    conn.Open();
                    string query = @"INSERT INTO Complaints 
                                 (FullName, Contact, PlaceOccurrence, BriefDetails, Category, Status, EvidenceImage) 
                                 VALUES 
                                 (@FullName, @Contact, @PlaceOccurrence, @BriefDetails, @Category, 'Pending', @EvidenceImage)";

                    MySqlCommand cmd = new MySqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@FullName", fullName);
                    cmd.Parameters.AddWithValue("@Contact", contact);
                    cmd.Parameters.AddWithValue("@PlaceOccurrence", place);
                    cmd.Parameters.AddWithValue("@BriefDetails", details);
                    cmd.Parameters.AddWithValue("@Category", category);
                    cmd.Parameters.AddWithValue("@EvidenceImage", fileName);

                    cmd.ExecuteNonQuery();
                    conn.Close();

                    // Clear form
                    txtFullName.Text = txtContact.Text = txtPlace.Text = txtDetails.Text = "";
                    ddlCategory.SelectedIndex = 0;

                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Complaint submitted successfully!');", true);
                }
            }
        }
        public enum ComplaintCategory
        {
          
            Crime = 1,
            GunShoot = 2,
            Riot = 3,
            Theft = 4,
            Vandalism = 5,
            DomesticViolence = 6, //within home/bahay
            DrugActivity = 7,
            CyberCrime = 8,
            MissingPerson = 9,
            Other = 10
        }
    }
}