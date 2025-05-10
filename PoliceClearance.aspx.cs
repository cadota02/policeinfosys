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
                int userid = 0;
                if(IsExists(txtusername.Text, "Username"))
                {
               
                    var result = DBUserdefualt.GetUserIdAndRoleVerifypass(txtusername.Text);
                    int GetExistinguserId = result.userId;
                    string pass = result.pass;
                    if (BCrypt.Net.BCrypt.Verify(txtpassword.Text, pass))
                    {
                        savePoloceClearanceApplication(true, GetExistinguserId.ToString());
                    }
                    else
                    {
                    AlertNotify.ShowMessage(this, "Incorrect password. If you don’t have an account yet, please register using a different username.", "Warning", AlertNotify.MessageType.Warning);
                      
                        return;
                    }

                }
                else
                {
                    if ((userid = SaveUser()) > 0)
                    {
                        savePoloceClearanceApplication(false, userid.ToString());

                    }
                    else
                    {
                        AlertNotify.ShowMessage(this, "Failed to register account!", "Warning", AlertNotify.MessageType.Warning);
                    }

                }

            }
            catch (Exception ex)
            {
                AlertNotify.ShowMessage(this, ex.Message.ToString(), "Error", AlertNotify.MessageType.Error);
            }
        }
        public void savePoloceClearanceApplication(bool isexistingUSER, string userid)

        {


            string middleInitial = string.IsNullOrWhiteSpace(txtmiddlename.Text) || txtmiddlename.Text.Trim().Length < 1
               ? ""
               : txtmiddlename.Text.Trim().Substring(0, 1) + ". ";

            string fullName = txtfirstname.Text.Trim() + " " + middleInitial + txtlastname.Text.Trim();
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
                            (FullName,Sex, DOB, Address, ValidIDType, ValidID, ValidIDFilePath, Purpose, ClearanceNo, userid) 
                            VALUES 
                            (@FullName,@Sex, @DOB, @Address, @ValidIDType, @ValidID, @ValidIDFilePath, @Purpose, @ClearanceNo,@userid) ";

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
                    cmd.Parameters.AddWithValue("@userid", userid);
                    conn.Open();
                    int stat = cmd.ExecuteNonQuery();
                    if (stat > 0)
                    {
                        AlertNotify.ShowMessage(this, "Application submitted successfully! Your Clearance No is: " + clearanceno, "Success", AlertNotify.MessageType.Success);
                        if (!isexistingUSER)
                        {
                            lblMessage.Text = "Your account has been registered and is pending approval by the administrator.";
                            lblMessage.Visible = true;
                        }
                        btnPrint.Visible = true;


                        hd_clearanceno.Value = clearanceno;
                    }
                    conn.Close();
                    ClearFields();
                }
            }
        }
        
        private void ClearFields()
        {
            txtfirstname.Text = string.Empty;
            txtlastname.Text = string.Empty;
            txtmiddlename.Text = string.Empty;
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
        private int SaveUser()
        {
            int userid = 0;

            using (MySqlConnection conn = new MySqlConnection(connString))
            {
                try
                {
                    conn.Open();
                    string query = @"INSERT INTO users 
                                (Firstname, Lastname, Middlename, UserPosition, Username, PasswordHash, Address, ContactNo, Email, Role, IsApproved)
                                VALUES
                                (@Firstname, @Lastname, @Middlename, @UserPosition, @Username, @PasswordHash, @Address, @ContactNo, @Email, @Role, @IsApproved);  SELECT LAST_INSERT_ID();";

                    MySqlCommand cmd = new MySqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Firstname", txtfirstname.Text.Trim());
                    cmd.Parameters.AddWithValue("@Lastname", txtlastname.Text.Trim());
                    cmd.Parameters.AddWithValue("@Middlename", txtmiddlename.Text.Trim());
                    cmd.Parameters.AddWithValue("@UserPosition", "Citizen");
                    cmd.Parameters.AddWithValue("@Username", txtusername.Text.Trim());

                    // Hash password before saving
                   
                    string hashedPassword = BCrypt.Net.BCrypt.HashPassword(txtpassword.Text.Trim());
                    cmd.Parameters.AddWithValue("@PasswordHash", hashedPassword);

                    cmd.Parameters.AddWithValue("@Address", Address.Text.Trim());
                    cmd.Parameters.AddWithValue("@ContactNo", "");
                    cmd.Parameters.AddWithValue("@Email","");
                    cmd.Parameters.AddWithValue("@Role", "Client"); // e.g., Admin or Client
                    cmd.Parameters.AddWithValue("@IsApproved", 0);
                
                    object result = cmd.ExecuteScalar();
                    int insertedUserId = Convert.ToInt32(result);

                    
                    if (insertedUserId > 0)
                    {
                        userid = insertedUserId;


                    }
                    else
                    {
                        userid = 0;


                    }
                }
                catch (Exception ex)
                {
         
                    AlertNotify.ShowMessage(this, "Error: " + ex.Message, "Error", AlertNotify.MessageType.Error);
                }
            }
            return userid;
        }
        private bool IsExists(string name, string column)
        {
        
            using (MySqlConnection conn = new MySqlConnection(connString))
            {
                conn.Open();
                string query = "SELECT COUNT(*) FROM users WHERE "+ column + " = @column";
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@column", name);
                    int count = Convert.ToInt32(cmd.ExecuteScalar());
                    return count > 0;
                }
            }
        }

    }
}