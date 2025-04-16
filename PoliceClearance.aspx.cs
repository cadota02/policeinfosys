using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Configuration;
using System.IO;

namespace policeinfosys
{
    public partial class PoliceClearance : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["myconnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SubmitBtn_Click(object sender, EventArgs e)
        {
            try
            {
                string fullName = FullName.Text.Trim();
                string dob = DOB.Text;
                string sex = DPSEX.SelectedValue;
                string address = Address.Text.Trim();
                string validIDType = ValidIDType.SelectedValue;
                string validID = ValidID.Text.Trim();
                string purpose = Purpose.Text.Trim();
                string clearanceno = GenerateClearanceNo();
                string filePath = "";
                if (ValidIDImage.HasFile)
                {
                    string ext = Path.GetExtension(ValidIDImage.FileName);
                    string fileName = Guid.NewGuid().ToString() + ext;
                    string savePath = Server.MapPath("~/Content/images/clearance/") + fileName;
                    ValidIDImage.SaveAs(savePath);
                    filePath = "Content/images/clearance/" + fileName;
                }

                //   string clearanceNo = "PCLR-" + DateTime.Now.ToString("yyMMddHHmmss");

                using (MySqlConnection conn = new MySqlConnection(connString))
                {
                    string sql = @"INSERT INTO policeclearance 
            (FullName,Sex, DOB, Address, ValidIDType, ValidID, ValidIDFilePath, Purpose, ClearanceNo) 
            VALUES 
            (@FullName,@Sex, @DOB, @Address, @ValidIDType, @ValidID, @ValidIDFilePath, @Purpose, @ClearanceNo)";

                    using (MySqlCommand cmd = new MySqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@FullName", fullName);
                        cmd.Parameters.AddWithValue("@Sex", sex);
                        cmd.Parameters.AddWithValue("@DOB", dob);
                        cmd.Parameters.AddWithValue("@Address", address);
                        cmd.Parameters.AddWithValue("@ValidIDType", validIDType);
                        cmd.Parameters.AddWithValue("@ValidID", validID);
                        cmd.Parameters.AddWithValue("@ValidIDFilePath", filePath);
                        cmd.Parameters.AddWithValue("@Purpose", purpose);
                        cmd.Parameters.AddWithValue("@ClearanceNo", clearanceno);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();
                        ClearFields();
                    }
                }
                AlertNotify.ShowMessage(this, "Application submitted successfully! Your Clearance No is:" + clearanceno, "Success", AlertNotify.MessageType.Success);
                // lblMessage.Text = "Application submitted successfully! Your Clearance No is: " + clearanceno;
                // lblMessage.Visible = true;
                btnPrint.Visible = true;


                hd_clearanceno.Value = clearanceno;
            }
            catch (Exception ex)
            {
                AlertNotify.ShowMessage(this, ex.Message.ToString(), "Error", AlertNotify.MessageType.Error);
            }
        }

        
        private void ClearFields()
        {

            FullName.Text = string.Empty;
            DOB.Text = string.Empty;
            DPSEX.SelectedIndex = 0;
            Address.Text = string.Empty;
            ValidID.Text = string.Empty;
            Purpose.Text = string.Empty;
            ValidIDType.SelectedIndex = 0; // Reset dropdown
            ValidIDImage.FileContent.Dispose(); // Clear uploaded file
        }
        private string GenerateClearanceNo()
        {
            string connString = ConfigurationManager.ConnectionStrings["myconnection"].ConnectionString;
            string clearanceNo = string.Empty;

            using (MySqlConnection conn = new MySqlConnection(connString))
            {
                conn.Open();

                // Get last clearance number to generate new sequence
                string query = "SELECT MAX(ClearanceID) FROM PoliceClearance";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                var lastID = cmd.ExecuteScalar();
                int newID = lastID != DBNull.Value ? Convert.ToInt32(lastID) + 1 : 1;

                clearanceNo = $"PCLR-{DateTime.Now.Year}-{newID:D4}"; // Format like PCLR-2025-0001
            }

            return clearanceNo;
        }
        public void getdata(string clearanceno)
        {
            using (MySqlConnection con = new MySqlConnection(connString))
            {
                MySqlCommand cmd = new MySqlCommand("SELECT * FROM policeclearance WHERE ClearanceNo = @ClearanceNo", con);
                cmd.Parameters.AddWithValue("@ClearanceNo", clearanceno);
                con.Open();
                MySqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                  
                    lblClearanceNo.Text = dr["ClearanceNo"].ToString();
                    lblPrintFullName.Text = dr["FullName"].ToString();
                    lblPrintDOB.Text = Convert.ToDateTime(dr["DOB"].ToString()).ToString("MMMM dd, yyyy");
                    lblPrintAddress.Text = dr["Address"].ToString();
                    lblPrintIDType.Text = dr["ValidIDType"].ToString();
                    lblPrintValidID.Text = dr["ValidID"].ToString();
                    lblPrintPurpose.Text = dr["Purpose"].ToString();
                    lblPrintDateFiled.Text = DateTime.Now.ToString("MMMM dd, yyyy hh:mm tt");
                }
                con.Close();
            }
        }

        protected void btnPrint_Click(object sender, EventArgs e)
        {
           
            // Open the new page to print the receipt
            string clearanceno = hd_clearanceno.Value;

            getdata(clearanceno);  

            // Show modal with JS
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", "$('#printModal').modal('show');", true);
        }
    }
}