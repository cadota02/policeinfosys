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
    public partial class SignUp : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["myconnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (Page.IsValid) // Ensure all required fields are filled
            {
                string firstname = txtFirstName.Text.Trim();
                string lastname = txtLastName.Text.Trim();
                string middlename = txtMiddleName.Text.Trim();
                string userposition = txtPosition.Text;
                string username = txtUsername.Text.Trim();
                string hashedPassword = BCrypt.Net.BCrypt.HashPassword(txtPassword.Text.Trim());
                string address = txtAddress.Text.Trim();
                string contactNo = txtContactNo.Text.Trim();
                string email = txtEmail.Text.Trim();
                string role = "Client"; // Default role based on position
                string status = "0";
                int isApproved = int.Parse(status); // Approval pending


              

                    using (MySqlConnection con = new MySqlConnection(connString))
                    {
                        try
                        {
                            con.Open();

                            string checkUserQuery = "SELECT COUNT(*) FROM users WHERE Username = @username;";
                            using (MySqlCommand checkCmd = new MySqlCommand(checkUserQuery, con))
                            {
                                checkCmd.Parameters.AddWithValue("@username", username);
                                int userExists = Convert.ToInt32(checkCmd.ExecuteScalar());
                                con.Close();
                                if (userExists > 0)
                                {
                                    txtUsername.Text = "";
                                    txtUsername.Focus();
                                    AlertNotify.ShowMessage(this, "Username already exist!", "Warning", AlertNotify.MessageType.Warning);
                                }
                                else
                                {
                                    con.Open();
                                    string query = "INSERT INTO users (Firstname, Lastname, Middlename, Userposition, Username, PasswordHash, Address, ContactNo, Email, Role, IsApproved) " +
                                           "VALUES (@firstname, @lastname, @middlename, @userposition, @username, @password, @address, @contactNo, @email, @role, @isApproved)";

                                    using (MySqlCommand cmd = new MySqlCommand(query, con))
                                    {
                                        cmd.Parameters.AddWithValue("@firstname", firstname);
                                        cmd.Parameters.AddWithValue("@lastname", lastname);
                                        cmd.Parameters.AddWithValue("@middlename", middlename);
                                        cmd.Parameters.AddWithValue("@userposition", userposition);
                                        cmd.Parameters.AddWithValue("@username", username);
                                        cmd.Parameters.AddWithValue("@password", hashedPassword);
                                        cmd.Parameters.AddWithValue("@address", address);
                                        cmd.Parameters.AddWithValue("@contactNo", contactNo);
                                        cmd.Parameters.AddWithValue("@email", email);
                                        cmd.Parameters.AddWithValue("@role", role);
                                        cmd.Parameters.AddWithValue("@isApproved", isApproved);

                                        cmd.ExecuteNonQuery();

                                        reset();
                                        AlertNotify.ShowMessage(this, "Signup successful! Your account is pending administrator approval.", "Success", AlertNotify.MessageType.Success);
                                        

                                    }
                                }
                            }
                        }
                        catch (Exception ex)
                        {
                            AlertNotify.ShowMessage(this, ex.Message.ToString(), "Error", AlertNotify.MessageType.Error);

                        }
                    
                }

            }
        }
        public void reset()
        {
          
            txtUsername.Text = "";
            txtFirstName.Text = "";
            txtLastName.Text = "";
            txtMiddleName.Text = "";
            txtPosition.Text = "";
            txtAddress.Text = "";
            txtContactNo.Text = "";
            txtEmail.Text = "";
            txtPassword.Text = "";
            txtConfirmPassword.Text = "";
           
            rfvPassword.Enabled = true;
            rfvConfirmPassword.Enabled = true;
           
        }
    }
}