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
    public partial class ClientComplaint : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["myconnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
                ddlCategory.DataSource = Enum.GetValues(typeof(ComplaintCategory));
                ddlCategory.DataBind();
                LoadComplaints();
                GetUserInfo(Page.User.Identity.Name.ToString());

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
        protected void OnPaging(object sender, GridViewPageEventArgs e)
        {
            gvComplaints.PageIndex = e.NewPageIndex;
            this.LoadComplaints();
        }
        protected void btn_filter_Click(object sender, EventArgs e)
        {
            LoadComplaints();
        }
        protected void btn_reset_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect("ClientComplaint");

        }
        private void LoadComplaints()
        {
            string username = Page.User.Identity.Name.ToString();
            var result = DBUserdefualt.GetUserIdAndRole(username);
            int userId = result.userId;
         
            using (MySqlConnection conn = new MySqlConnection(connString))
            {
                conn.Open();
                using (MySqlCommand cmd = new MySqlCommand())
                {
                    string sql = "select * from complaints where userid =@userid ";

                    if (txt_search.Text.Trim() != "")
                    {
                        sql += @"and
                       (FullName LIKE @search 
                       OR Contact LIKE @search 
                       OR BriefDetails LIKE @search 
                       OR Category LIKE @search
                       OR Status LIKE @search
                       OR PlaceOccurrence LIKE @search) ";
                    }
                    sql += "  order by ComplaintID desc ";
                    cmd.CommandText = sql;
                    cmd.Parameters.AddWithValue("@search", "%" + txt_search.Text + "%");
                    cmd.Parameters.AddWithValue("@userid", userId.ToString());
                    cmd.Connection = conn;
                    using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                    {

                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        gvComplaints.DataSource = dt;
                        gvComplaints.DataBind();

                    }
                }
                conn.Close();
                // lbl_item.Text = gb.footerinfo_gridview(gv_masterlist).ToString();

            }
        }



        protected void btnSave_Click(object sender, EventArgs e)
        {

            try
            {
                string username = Page.User.Identity.Name.ToString();
                var result = DBUserdefualt.GetUserIdAndRole(username);
                int userId = result.userId;

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
              
                if (hd_complaintid.Value == "0") //add
                {
                    using (MySqlConnection conn = new MySqlConnection(connString))
                    {
                        conn.Open();
                        string query = @"INSERT INTO Complaints 
                                 (FullName, Contact, PlaceOccurrence, BriefDetails, Category, Status, EvidenceImage, userid) 
                                 VALUES 
                                 (@FullName, @Contact, @PlaceOccurrence, @BriefDetails, @Category, 'Pending', @EvidenceImage,@userid)";

                        MySqlCommand cmd = new MySqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@FullName", fullName);
                        cmd.Parameters.AddWithValue("@Contact", contact);
                        cmd.Parameters.AddWithValue("@PlaceOccurrence", place);
                        cmd.Parameters.AddWithValue("@BriefDetails", details);
                        cmd.Parameters.AddWithValue("@Category", category);
                        cmd.Parameters.AddWithValue("@EvidenceImage", fileName);
                        cmd.Parameters.AddWithValue("@userid", userId.ToString());


                        cmd.ExecuteNonQuery();
                        conn.Close();

                        // Clear form
                        txtFullName.Text = txtContact.Text = txtPlace.Text = txtDetails.Text = "";
                        ddlCategory.SelectedIndex = 0;

                        AlertNotify.ShowMessage(this, "Complaint submitted successfully!", "Success", AlertNotify.MessageType.Success);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "$('#ComplaintModal').modal('hide')", true);
                    }
                }
                else //edit
                {
                    using (MySqlConnection conn = new MySqlConnection(connString))
                    {
                        conn.Open();

                        string query = @"UPDATE Complaints 
                     SET FullName = @FullName,
                         Contact = @Contact,
                         PlaceOccurrence = @PlaceOccurrence,
                         BriefDetails = @BriefDetails,
                         Category = @Category" +
                        (string.IsNullOrEmpty(fileName) ? "" : ", EvidenceImage = @EvidenceImage") + @"
                    WHERE ComplaintID = @ComplaintID";

                        MySqlCommand cmd = new MySqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@FullName", fullName);
                        cmd.Parameters.AddWithValue("@Contact", contact);
                        cmd.Parameters.AddWithValue("@PlaceOccurrence", place);
                        cmd.Parameters.AddWithValue("@BriefDetails", details);
                        cmd.Parameters.AddWithValue("@Category", category);

                        if (!string.IsNullOrEmpty(fileName))
                            cmd.Parameters.AddWithValue("@EvidenceImage", fileName);
                        cmd.Parameters.AddWithValue("@ComplaintID", hd_complaintid.Value); // must be defined

                        cmd.ExecuteNonQuery();
                        conn.Close();

                        // Clear form
                        txtFullName.Text = txtContact.Text = txtPlace.Text = txtDetails.Text = "";
                        ddlCategory.SelectedIndex = 0;

                        AlertNotify.ShowMessage(this, "Complaint updated successfully!", "Success", AlertNotify.MessageType.Success);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "$('#ComplaintModal').modal('hide')", true);
                    }
                }
                    LoadComplaints(); // Refresh GridView
                    ClearFields();

            }
            catch (Exception ex)
            {
                ErrorLogger.WriteErrorLog(ex);

                AlertNotify.ShowMessage(this, ex.Message.ToString(), "Error", AlertNotify.MessageType.Error);
            }
        }
        private void UpdateComplaintStatus(int complaintId, string newStatus)
        {
            using (MySqlConnection con = new MySqlConnection(connString))
            {
                string updateQuery = "UPDATE Complaints SET Status = @Status WHERE ComplaintID = @ComplaintID";
                MySqlCommand cmd = new MySqlCommand(updateQuery, con);
                cmd.Parameters.AddWithValue("@Status", newStatus);
                cmd.Parameters.AddWithValue("@ComplaintID", complaintId);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
        protected void btnAction_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            // string Complaintid = btn.CommandArgument; // Get UserID from CommandArgument
            GridViewRow item = (GridViewRow)btn.NamingContainer;
            HiddenField hd_idselect = (HiddenField)item.FindControl("hd_id");

            LoadComplaintHistory(int.Parse(hd_idselect.Value));

            using (MySqlConnection con = new MySqlConnection(connString))
            {
                MySqlCommand cmd = new MySqlCommand("SELECT * FROM complaints WHERE ComplaintID = @ComplaintID", con);
                cmd.Parameters.AddWithValue("@ComplaintID", hd_idselect.Value);
                con.Open();
                MySqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    hd_complaintid.Value = dr["ComplaintID"].ToString();
                    lbl_hfullname.Text = dr["FullName"].ToString();
                    lbl_hcontact.Text = dr["Contact"].ToString();
                    lbl_hcategory.Text = dr["Category"].ToString();
                    lbl_hplace.Text = dr["PlaceOccurrence"].ToString();
                    lbl_hdesc.Text = dr["BriefDetails"].ToString();
                    lbl_hstatus.Text = dr["Status"].ToString();
                    lbl_hdatefiled.Text = dr["DateFiled"].ToString();
                    string imgPath = dr["EvidenceImage"].ToString();

                    if (!string.IsNullOrEmpty(imgPath))
                    {
                        imgHEvidence.ImageUrl = imgPath;
                        imgHEvidence.Visible = true;
                    }

                }
                con.Close();
            }

            //// Example: Toggle status in database
            //string query = "UPDATE complaints SET IsActive = CASE WHEN IsActive = 1 THEN 0 ELSE 1 END WHERE ComplaintID = @ComplaintID";

            //using (MySqlConnection con = new MySqlConnection(connString))
            //{
            //    using (MySqlCommand cmd = new MySqlCommand(query, con))
            //    {
            //        cmd.Parameters.AddWithValue("@ComplaintID", userId);
            //        con.Open();
            //        cmd.ExecuteNonQuery();
            //        con.Close();
            //    }
            //}

            //// Refresh GridView after update
            //LoadComplaints();
        }
        protected void btn_select_Click(object sender, EventArgs e)
        {
            try
            {
                imgID.ImageUrl = "";
                LinkButton btn_select = (LinkButton)sender;
                GridViewRow item = (GridViewRow)btn_select.NamingContainer;
                HiddenField hd_idselect = (HiddenField)item.FindControl("hd_id");
                HiddenField hd_name = (HiddenField)item.FindControl("hd_name");
               // HiddenField hd_status = (HiddenField)item.FindControl("hd_status");

                using (MySqlConnection con = new MySqlConnection(connString))
                {
                    MySqlCommand cmd = new MySqlCommand("SELECT * FROM complaints WHERE ComplaintID = @ComplaintID", con);
                    cmd.Parameters.AddWithValue("@ComplaintID", hd_idselect.Value);
                    con.Open();
                    MySqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        hd_complaintid.Value = dr["ComplaintID"].ToString();
                        txtFullName.Text = dr["FullName"].ToString();
                       txtContact.Text = dr["Contact"].ToString();
                        ddlCategory.SelectedValue = dr["Category"].ToString();
                        txtPlace.Text = dr["PlaceOccurrence"].ToString();
                        txtDetails.Text = dr["BriefDetails"].ToString();



                        string imgPath = dr["EvidenceImage"].ToString();
                        string cleanedPath = imgPath.Replace("~/", "");
                        hdfilepath.Value = cleanedPath;
                        if (!string.IsNullOrEmpty(imgPath))
                        {
                            imgID.ImageUrl = "../" + imgPath;
                            imgID.Visible = false;
                        }

                      
                      
                    }
                    con.Close();
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop2", "$('#ComplaintModal').modal('show')", true);
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
                        String cb = "Delete from complaints where ComplaintID = " + hd_idselect.Value + "";
                        cmd.CommandText = cb;
                        cmd.Connection = conn;

                        int result = cmd.ExecuteNonQuery();
                        conn.Close();

                        if (result >= 1)
                        {

                            AlertNotify.ShowMessage(this, "Successfully Deleted!", "Success", AlertNotify.MessageType.Success);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "$('#modalPopUp_Delete').modal('hide')", true);
                            LoadComplaints();
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

        private void ClearFields()
        {
            hd_complaintid.Value = "0";
            hdfilepath.Value = "";
            txtDetails.Text = "";
            txtFullName.Text = "";
            txtContact.Text = "";
            txtPlace.Text = "";
            ddlCategory.ClearSelection();
            GetUserInfo(Page.User.Identity.Name.ToString());

        }
        protected void LoadComplaintHistory(int complaintId)
        {
            string query = "SELECT * FROM complaintactions WHERE ComplaintID = @ComplaintID ORDER BY ActionDate DESC";

            using (MySqlConnection conn = new MySqlConnection(connString))
            using (MySqlCommand cmd = new MySqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@ComplaintID", complaintId);
                conn.Open();

                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvComplaintHistory.DataSource = dt;
                gvComplaintHistory.DataBind();
            }

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop3", "$('#modalComplaintHistory').modal('show');", true);
        }
        protected void btnAddNew_Click(object sender, EventArgs e)
        {
            ClearFields();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popadd", "$('#ComplaintModal').modal('show')", true);
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
                               string fname = reader["Firstname"].ToString();
                                string lname = reader["Lastname"].ToString();
                               string mi = reader["Middlename"].ToString();

                                string middleInitial = string.IsNullOrWhiteSpace(mi) || mi.Length < 1
                                             ? ""
                                             : mi.Substring(0, 1) + ". ";

                              txtFullName.Text = fname + " " + middleInitial + lname;

                                txtContact.Text = reader["ContactNo"].ToString();


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