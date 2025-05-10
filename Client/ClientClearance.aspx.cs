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

namespace policeinfosys.Client
{
    public partial class ClientClearance : System.Web.UI.Page
    {
        public static int userids = 0;
        string connString = ConfigurationManager.ConnectionStrings["myconnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!this.Page.User.Identity.IsAuthenticated)
                {
                    FormsAuthentication.RedirectToLoginPage();
                }
                else
                {
                    string username = Page.User.Identity.Name.ToString();
                    var result = DBUserdefualt.GetUserIdAndRole(username);
                    userids = result.userId;
                    LoadClearanceGrid();
                    GetUserInfo(username);
                }
            }
        }

        private void LoadClearanceGrid()
        {
            using (MySqlConnection conn = new MySqlConnection(connString))
            {
                conn.Open();
                using (MySqlCommand cmd = new MySqlCommand())
                {
                    string sql = "select * from policeclearance where userid=@userid ";

                    if (txtSearchClearance.Text.Trim() != "")
                    {
                        sql += @"and
                       (FullName LIKE @search 
                       OR ValidIDType LIKE @search 
                       OR ValidID LIKE @search 
                       OR Purpose LIKE @search
                       OR ClearanceNo LIKE @search
                       OR Status LIKE @search) ";
                    }
                    sql += "  order by ClearanceID desc ";
                    cmd.CommandText = sql;
                    cmd.Parameters.AddWithValue("@search", "%" + txtSearchClearance.Text + "%");
                    cmd.Parameters.AddWithValue("@userid", userids);
                    cmd.Connection = conn;
                    using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                    {

                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        gvClearances.DataSource = dt;
                        gvClearances.DataBind();

                    }
                }
                conn.Close();
                // lbl_item.Text = gb.footerinfo_gridview(gv_masterlist).ToString();

            }
        }


        protected void OnPagingClearance(object sender, GridViewPageEventArgs e)
        {
            gvClearances.PageIndex = e.NewPageIndex;
            LoadClearanceGrid(); // Refresh grid with updated page index
        }
        protected void btnDeleteClearance_Click(object sender, EventArgs e)
        {
            try
            {
                LinkButton btn_select = (LinkButton)sender;
                GridViewRow item = (GridViewRow)btn_select.NamingContainer;

                HiddenField hd_idselect = (HiddenField)item.FindControl("hdClearanceID");


                using (MySqlConnection conn = new MySqlConnection(connString))
                {
                    conn.Open();
                    using (MySqlCommand cmd = new MySqlCommand())
                    {
                        String cb = "Delete from policeclearance where ClearanceID = " + hd_idselect.Value + "";
                        cmd.CommandText = cb;
                        cmd.Connection = conn;

                        int result = cmd.ExecuteNonQuery();
                        conn.Close();

                        if (result >= 1)
                        {

                            AlertNotify.ShowMessage(this, "Successfully Deleted!", "Success", AlertNotify.MessageType.Success);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "$('#modalPopUp_Delete').modal('hide')", true);
                            LoadClearanceGrid();
                            ClearFields();
                        }
                    }
                    conn.Close();

                }
            }
            catch (Exception ex)
            {
                AlertNotify.ShowMessage(this, ex.Message.ToString(), "Error", AlertNotify.MessageType.Error);


            }
        }
        protected void btnEditClearance_Click(object sender, EventArgs e)
        {
         
            LinkButton btn = (LinkButton)sender;
            GridViewRow item = (GridViewRow)btn.NamingContainer;
            HiddenField hdClearanceID = (HiddenField)item.FindControl("hdClearanceID");
            GetPoliceClearanceInfo(hdClearanceID.Value);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop2", "$('#pnlEditClearance').modal('show')", true);
            // ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "$('#pnlEditClearance').modal('show');", true);
        }
        protected void btnFilterClearance_Click(object sender, EventArgs e)
        {
            LoadClearanceGrid();
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try

            {
                string clearanceid = hfClearanceID.Value;
                string filepath = "";
                if (ValidIDImage.HasFile)
                {
                    string ext = Path.GetExtension(ValidIDImage.FileName);
                    string fileName = Guid.NewGuid().ToString() + ext;
                    string savePath = Server.MapPath("~/Content/images/clearance/") + fileName;
                    ValidIDImage.SaveAs(savePath);
                    filepath = "Content/images/clearance/" + fileName;
                }
                hdfilepath.Value = filepath;

              //  AlertNotify.ShowMessage(this, filepath, "Success", AlertNotify.MessageType.Success);

                if (clearanceid == "") //save
                {
                    string username = Page.User.Identity.Name.ToString();
                    var result = DBUserdefualt.GetUserIdAndRole(username);
                    int userId = result.userId;
                    savePoloceClearanceApplication(userId.ToString(), filepath);
                }
                else //edit

                {

                    UpdatePoliceClearanceApplication(clearanceid, filepath);
                }


                LoadClearanceGrid();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "HideModal", "$('#pnlEditClearance').modal('hide');", true);
            }
            catch (Exception ex)
            {
                AlertNotify.ShowMessage(this, ex.Message.ToString(), "Error", AlertNotify.MessageType.Error);
            }
        }
        protected void btnResetClearance_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect("ClientClearance");
        }
    
        protected void btn_showprint_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            string clearanceId = ((HiddenField)row.FindControl("hdClearanceID")).Value;

            LoadClearanceDetails(clearanceId);

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "$('#policeClearanceModal').modal('show');", true);
        }
        private void LoadClearanceDetails(string clearanceId)
        {


            using (MySqlConnection con = new MySqlConnection(connString))
            {
                string query = "SELECT * FROM policeclearance WHERE ClearanceID = @ClearanceID";
                MySqlCommand cmd = new MySqlCommand(query, con);
                cmd.Parameters.AddWithValue("@ClearanceID", clearanceId);

                con.Open();
                MySqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                
                    lblClearanceNo.Text = reader["ClearanceNo"].ToString();
                    lblName.Text = reader["FullName"].ToString();
                    lblAddress.Text = reader["Address"].ToString();
                    lblDOB.Text = Convert.ToDateTime(reader["DOB"]).ToString("MMM dd, yyyy");
                    lblBirthPlace.Text = reader["Address"].ToString();
                    lblSex.Text = reader["Sex"].ToString();
                    lblPurpose.Text = reader["Purpose"].ToString();
                    lblIssuedAt.Text = "Cotabato City";
                    lblDateFiled.Text = Convert.ToDateTime(reader["DateFiled"]).ToString("MMM dd, yyyy hh:mm tt");
                    lblPreparedBy.Text = reader["preparedby"].ToString();
                    lblApprovedBy.Text = reader["approvedby"].ToString();
                }

                con.Close();
            }
        }
        protected void btnAddNew_Click(object sender, EventArgs e)
        {
            ClearFields();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popadd", "$('#pnlEditClearance').modal('show')", true);
        }
        public void savePoloceClearanceApplication(string userid, string filePath)

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
                      
                    }
                    conn.Close();
                    ClearFields();
                }
            }
        }
        public void UpdatePoliceClearanceApplication(string clearanceId, string filepath)
        {
            try

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

         

            using (MySqlConnection conn = new MySqlConnection(connString))
            {
                string sql = @"
            UPDATE policeclearance SET 
                FullName = @FullName,
                Sex = @Sex,
                DOB = @DOB,
                Address = @Address,
                ValidIDType = @ValidIDType,
                ValidID = @ValidID,
                Purpose = @Purpose" +
                  (string.IsNullOrEmpty(filepath) ? "" : ", ValidIDFilePath = @ValidIDFilePath") + @"
            WHERE ClearanceID = @clearanceId";

                using (MySqlCommand cmd = new MySqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@FullName", fullName);
                    cmd.Parameters.AddWithValue("@Sex", sex);
                    cmd.Parameters.AddWithValue("@DOB", dob);
                    cmd.Parameters.AddWithValue("@Address", address);
                    cmd.Parameters.AddWithValue("@ValidIDType", validIDType);
                    cmd.Parameters.AddWithValue("@ValidID", validID);
                    cmd.Parameters.AddWithValue("@Purpose", purpose);
                    cmd.Parameters.AddWithValue("@clearanceId", clearanceId);

                    if (!string.IsNullOrEmpty(filepath))
                        cmd.Parameters.AddWithValue("@ValidIDFilePath", filepath);

                    conn.Open();
                    int rows = cmd.ExecuteNonQuery();
                    conn.Close();

                    if (rows > 0)
                    {
                        AlertNotify.ShowMessage(this, "Application updated successfully!", "Success", AlertNotify.MessageType.Success);
                        ClearFields();
                    }
                    else
                    {
                        AlertNotify.ShowMessage(this, "No record was updated.", "Warning", AlertNotify.MessageType.Warning);
                    }
                }
            }
            }
            catch (Exception ex)
            {
                ErrorLogger.WriteErrorLog(ex);
                AlertNotify.ShowMessage(this, ex.Message.ToString(), "Error", AlertNotify.MessageType.Error);
            }
        }
        private void ClearFields()
        {
            hdfilepath.Value = "";
            hfClearanceID.Value = "";
            txtfirstname.Text = string.Empty;
            txtlastname.Text = string.Empty;
            txtmiddlename.Text = string.Empty;
            DOB.Text = string.Empty;
            DPSEX.SelectedIndex = 0;
            Address.Text = string.Empty;
            ValidID.Text = string.Empty;
            Purpose.Text = string.Empty;
            ValidIDType.SelectedIndex = 0;
            imgID.ImageUrl = "";
            ValidIDImage.FileContent.Dispose(); // Clear uploaded file
            GetUserInfo(Page.User.Identity.Name.ToString());
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
        public void GetPoliceClearanceInfo(string clearanceId)
        {
            try
            {
                imgID.ImageUrl = "";
                using (MySqlConnection conn = new MySqlConnection(connString))
                {
                    string sql = @"SELECT * FROM policeclearance 
                       WHERE ClearanceID = @clearanceId";

                    using (MySqlCommand cmd = new MySqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@clearanceId", clearanceId);
                        conn.Open();

                        using (MySqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                rfvValidIDImage.Enabled = false;
                                hfClearanceID.Value = reader["ClearanceID"].ToString();
                                string fullName = reader["FullName"].ToString();
                                string[] nameParts = fullName.Split(' ');

                                // Optional: Split full name into first, middle initial, and last if you stored it that way
                                txtfirstname.Text = nameParts[0];

                                if (nameParts.Length == 3)
                                {
                                    txtmiddlename.Text = nameParts[1].Replace(".", "");
                                    txtlastname.Text = nameParts[2];
                                }
                                else if (nameParts.Length == 2)
                                {
                                    txtlastname.Text = nameParts[1];
                                }

                                DPSEX.SelectedValue = reader["Sex"].ToString();
                                DOB.Text = Convert.ToDateTime(reader["DOB"]).ToString("yyyy-MM-dd");
                                Address.Text = reader["Address"].ToString();
                                ValidIDType.SelectedValue = reader["ValidIDType"].ToString();
                                ValidID.Text = reader["ValidID"].ToString();
                                Purpose.Text = reader["Purpose"].ToString();

                                // Optionally load ValidIDFilePath for viewing image (if needed)
                                string imgPath = reader["ValidIDFilePath"].ToString();
                                hdfilepath.Value = imgPath;
                                if (!string.IsNullOrEmpty(imgPath))
                                {
                                    imgID.ImageUrl = "../" + imgPath;
                                    imgID.Visible = false;
                                }
                            }
                            else
                            {
                                AlertNotify.ShowMessage(this, "Clearance record not found.", "Error", AlertNotify.MessageType.Error);
                            }
                        }

                        conn.Close();
                    }
                }
            }
            catch(Exception ex)
            {
                ErrorLogger.WriteErrorLog(ex);
                AlertNotify.ShowMessage(this, ex.Message.ToString(), "Error", AlertNotify.MessageType.Error);
            }
        }
        public void GetUserInfo(string Username)
        {
            try
            {
                imgID.ImageUrl = "";
                using (MySqlConnection conn = new MySqlConnection(connString))
                {
                    string sql = @"SELECT * FROM users 
                       WHERE Username = @Username";

                    using (MySqlCommand cmd = new MySqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@Username", Username);
                        conn.Open();

                        using (MySqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                               txtfirstname.Text=  reader["Firstname"].ToString();
                               txtlastname.Text = reader["Lastname"].ToString();
                               txtmiddlename.Text = reader["Middlename"].ToString();
                                Address.Text = reader["Address"].ToString();
                            

                            }
                            else
                            {
                                AlertNotify.ShowMessage(this, "Usr record not found.", "Error", AlertNotify.MessageType.Error);
                            }
                        }

                        conn.Close();
                    }
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.WriteErrorLog(ex);
                AlertNotify.ShowMessage(this, ex.Message.ToString(), "Error", AlertNotify.MessageType.Error);
            }
        }

    }
}