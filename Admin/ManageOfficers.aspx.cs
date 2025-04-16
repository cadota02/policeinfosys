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

namespace policeinfosys.Admin
{
    public partial class ManageOfficers : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["myconnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                LoadOfficers();
            }
        }
        protected void OnPaging(object sender, GridViewPageEventArgs e)
        {
            gvOfficers.PageIndex = e.NewPageIndex;
            this.LoadOfficers();
        }
        protected void btn_filter_Click(object sender, EventArgs e)
        {
            LoadOfficers();
        }
        protected void btn_reset_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect("ManageOfficers");

        }
        private void LoadOfficers()
        {
            using (MySqlConnection conn = new MySqlConnection(connString))
            {
                conn.Open();
                using (MySqlCommand cmd = new MySqlCommand())
                {
                    string sql = "select *, " +
                        "CONCAT(FirstName, ', ', LEFT(MiddleName, 1), '. ', LastName) AS Fullname, " +
                        "CASE WHEN IsActive = 1 THEN 'Active' ELSE 'Inactive' END AS Status " +
                        "from officers where 1=1 ";

                    if (txt_search.Text.Trim() != "")
                    {
                        sql += @"and
                       (FirstName LIKE @search 
                       OR MiddleName LIKE @search 
                       OR LastName LIKE @search 
                       OR Address LIKE @search
                       OR PRank LIKE @search
                       OR Position LIKE @search) ";
                    }
                    sql += "  order by OfficerID desc ";
                    cmd.CommandText = sql;
                    cmd.Parameters.AddWithValue("@search", "%" + txt_search.Text + "%");
                    cmd.Connection = conn;
                    using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                    {

                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        gvOfficers.DataSource = dt;
                        gvOfficers.DataBind();

                    }
                }
                conn.Close();
                // lbl_item.Text = gb.footerinfo_gridview(gv_masterlist).ToString();

            }
        }

            protected void btnAddNew_Click(object sender, EventArgs e)
            {
                ClearFields();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop1", "openModal();", true);
            }
        protected void AddOfficer()
        {
           try
            { 
                using (MySqlConnection conn = new MySqlConnection(connString))
                {
                    string query = @"INSERT INTO officers 
            (FirstName, LastName, MiddleName, Position, PRank, Address, ContactNo, Email, Content, ImagePath, IsActive, CreatedAt, UpdatedAt) 
            VALUES 
            (@FirstName, @LastName, @MiddleName, @Position, @Rank, @Address, @ContactNo, @Email, @Content, @ImagePath, 1, NOW(), NOW())";

                    using (MySqlCommand cmd = new MySqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@FirstName", txtFirstName.Text.Trim());
                        cmd.Parameters.AddWithValue("@LastName", txtLastName.Text.Trim());
                        cmd.Parameters.AddWithValue("@MiddleName", txtMiddleName.Text.Trim());
                        cmd.Parameters.AddWithValue("@Position", txtPosition.Text.Trim());
                        cmd.Parameters.AddWithValue("@Rank", txtRank.Text.Trim());
                        cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
                        cmd.Parameters.AddWithValue("@ContactNo", txtContact.Text.Trim());
                        cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                        cmd.Parameters.AddWithValue("@Content", txtContent.Text.Trim());

                        // Save uploaded image if exists
                        string imagePath = "";
                        if (fuImage.HasFile)
                        {
                            string filename = Path.GetFileName(fuImage.FileName);
                            imagePath = "~/Content/images/officers/" + filename;
                            fuImage.SaveAs(Server.MapPath(imagePath));
                        }
                        cmd.Parameters.AddWithValue("@ImagePath", imagePath);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                     
                        AlertNotify.ShowMessage(this, "Successfully Saved!", "Success", AlertNotify.MessageType.Success);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pops2", "$('#officerModal').modal('hide')", true);
                        }
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.WriteErrorLog(ex);
                AlertNotify.ShowMessage(this, ex.Message.ToString(), "Error", AlertNotify.MessageType.Error);
            }
            //lblMessage.Text = "Officer added successfully.";
          
        }
        protected void UpdateOfficer(int officerId)
        {
            try

            { 
              
                using (MySqlConnection conn = new MySqlConnection(connString))
                {
                    string query = @"UPDATE officers SET 
            FirstName = @FirstName, LastName = @LastName, MiddleName = @MiddleName, 
            Position = @Position, PRank = @Rank, Address = @Address, ContactNo = @ContactNo, 
            Email = @Email, Content = @Content, ImagePath = @ImagePath, 
            UpdatedAt = NOW()
            WHERE OfficerID = @OfficerID";

                    using (MySqlCommand cmd = new MySqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@OfficerID", officerId);
                        cmd.Parameters.AddWithValue("@FirstName", txtFirstName.Text.Trim());
                        cmd.Parameters.AddWithValue("@LastName", txtLastName.Text.Trim());
                        cmd.Parameters.AddWithValue("@MiddleName", txtMiddleName.Text.Trim());
                        cmd.Parameters.AddWithValue("@Position", txtPosition.Text.Trim());
                        cmd.Parameters.AddWithValue("@Rank", txtRank.Text.Trim());
                        cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
                        cmd.Parameters.AddWithValue("@ContactNo", txtContact.Text.Trim());
                        cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                        cmd.Parameters.AddWithValue("@Content", txtContent.Text.Trim());

                        string imagePath = ""; // Store old path here
                        if (fuImage.HasFile)
                        {
                            string filename = Path.GetFileName(fuImage.FileName);
                            imagePath = "~/Content/images/officers/" + filename;
                            fuImage.SaveAs(Server.MapPath(imagePath));
                        }
                       else
                        {
                            imagePath = hdimagepath.Value;
                        }
                        cmd.Parameters.AddWithValue("@ImagePath", imagePath);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                        AlertNotify.ShowMessage(this, "Successfully Saved!", "Success", AlertNotify.MessageType.Success);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pops2", "$('#officerModal').modal('hide')", true);
                       
                        }
                }
             }
            catch (Exception ex)
            {
                ErrorLogger.WriteErrorLog(ex);
                AlertNotify.ShowMessage(this, ex.Message.ToString(), "Error", AlertNotify.MessageType.Error);
            }
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {

            try
            {
                string imagePath = "";

            if (fuImage.HasFile)
            {
                string ext = Path.GetExtension(fuImage.FileName).ToLower();
                if (ext != ".jpeg" && ext != ".png" && ext != ".jpg")
                {
                    // Handle invalid file
                    AlertNotify.ShowMessage(this, "", "Invalid image format. Only .jpeg and .png files are allowed.", AlertNotify.MessageType.Warning);
                    return;
                }
            }
                string officerid = hfOfficerID.Value;
                if (officerid == "0") //add
                {
                    AddOfficer();

                }
                 else
                {
                    UpdateOfficer(int.Parse(officerid)); //edit
                }
                LoadOfficers(); // Refresh GridView
                ClearFields();

            }
            catch (Exception ex)
            {
                ErrorLogger.WriteErrorLog(ex);

                AlertNotify.ShowMessage(this, ex.Message.ToString(), "Error", AlertNotify.MessageType.Error);
            }
        }
        protected void btnAction_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            string userId = btn.CommandArgument; // Get UserID from CommandArgument

            // Example: Toggle status in database
            string query = "UPDATE officers SET IsActive = CASE WHEN IsActive = 1 THEN 0 ELSE 1 END WHERE OfficerID = @OfficerID";

            using (MySqlConnection con = new MySqlConnection(connString))
            {
                using (MySqlCommand cmd = new MySqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@OfficerID", userId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }

            // Refresh GridView after update
            LoadOfficers();
        }
        protected void btn_select_Click(object sender, EventArgs e)
        {
            try
            {
                LinkButton btn_select = (LinkButton)sender;
                GridViewRow item = (GridViewRow)btn_select.NamingContainer;
                HiddenField hd_idselect = (HiddenField)item.FindControl("hd_id");
                HiddenField hd_name = (HiddenField)item.FindControl("hd_name");
                HiddenField hd_status = (HiddenField)item.FindControl("hd_status");

                using (MySqlConnection con = new MySqlConnection(connString))
                {
                    MySqlCommand cmd = new MySqlCommand("SELECT * FROM officers WHERE OfficerID = @OfficerID", con);
                    cmd.Parameters.AddWithValue("@OfficerID", hd_idselect.Value);
                    con.Open();
                    MySqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        hfOfficerID.Value = dr["OfficerID"].ToString();
                        txtFirstName.Text = dr["FirstName"].ToString();
                        txtLastName.Text = dr["LastName"].ToString();
                        txtMiddleName.Text = dr["MiddleName"].ToString();
                        txtPosition.Text = dr["Position"].ToString();
                        txtRank.Text = dr["PRank"].ToString();
                        txtAddress.Text = dr["Address"].ToString();
                        txtContact.Text = dr["ContactNo"].ToString();
                        txtEmail.Text = dr["Email"].ToString();
                        txtContent.Text = dr["Content"].ToString();
                        string imgPath = dr["ImagePath"].ToString();
                        hdimagepath.Value = imgPath;
                        if (!string.IsNullOrEmpty(imgPath))
                        {
                            imgPreview.ImageUrl = imgPath;
                            imgPreview.Visible = true;
                        }
                    }
                    con.Close();
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop2", "$('#officerModal').modal('show')", true);
                //  ScriptManager.RegisterStartupScript(this, this.GetType(), "EditModal", "openModal(" + hd_idselect.Value + ");", true);
            }
            catch (Exception ex)
            {

                AlertNotify.ShowMessage(this, ex.Message.ToString(), "Error", AlertNotify.MessageType.Error);
            }
        }
        protected void btn_delete_Click(object sender, EventArgs e)
        {
            try
            {
                LinkButton btn_select = (LinkButton)sender;
                GridViewRow item = (GridViewRow)btn_select.NamingContainer;

                HiddenField hd_idselect = (HiddenField)item.FindControl("hd_id");
                HiddenField hd_name = (HiddenField)item.FindControl("hd_name");


                using (MySqlConnection conn = new MySqlConnection(connString))
                {
                    conn.Open();
                    using (MySqlCommand cmd = new MySqlCommand())
                    {
                        String cb = "Delete from officers where OfficerID = " + hd_idselect.Value + "";
                        cmd.CommandText = cb;
                        cmd.Connection = conn;

                        int result = cmd.ExecuteNonQuery();
                        conn.Close();

                        if (result >= 1)
                        {

                            AlertNotify.ShowMessage(this, "Successfully Deleted!", "Success", AlertNotify.MessageType.Success);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "$('#modalPopUp_Delete').modal('hide')", true);
                            LoadOfficers();

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
       
            private void ClearFields()
           {
                hdimagepath.Value = "";
                imgPreview.ImageUrl = "";
                imgPreview.Visible = false;
                hfOfficerID.Value = "0";
                txtFirstName.Text = txtLastName.Text = txtMiddleName.Text = txtPosition.Text = txtRank.Text = "";
                txtAddress.Text = txtContact.Text = txtEmail.Text = txtContent.Text = "";
            }
        
    }
}