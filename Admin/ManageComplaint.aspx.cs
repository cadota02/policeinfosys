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
    public partial class ManageComplaint : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["myconnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadComplaints();
              
            }
          
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
            Page.Response.Redirect("ManageComplaint");

        }
        private void LoadComplaints()
        {
            using (MySqlConnection conn = new MySqlConnection(connString))
            {
                conn.Open();
                using (MySqlCommand cmd = new MySqlCommand())
                {
                    string sql = "select * from complaints where 1=1 ";

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
                string actionTaken = dpActionStatus.SelectedValue;
                string remarks = txtRemarks.Text.Trim();
                string actionBy = txtActionBy.Text.Trim();
                int complaintId = int.Parse( hd_complaintid.Value); // you should set this from selected GridView row or ViewState

                using (MySqlConnection con = new MySqlConnection(connString))
                {
                    string query = "INSERT INTO ComplaintActions (ComplaintID, ActionTaken, Remarks, ActionBy) VALUES (@ComplaintID, @ActionTaken, @Remarks, @ActionBy)";
                    MySqlCommand cmd = new MySqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@ComplaintID", complaintId);
                    cmd.Parameters.AddWithValue("@ActionTaken", actionTaken);
                    cmd.Parameters.AddWithValue("@Remarks", remarks);
                    cmd.Parameters.AddWithValue("@ActionBy", actionBy);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }

                // Optional: update status in Complaints table
                UpdateComplaintStatus(complaintId, actionTaken);
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
                    lbl_hplace.Text= dr["PlaceOccurrence"].ToString();
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
                LinkButton btn_select = (LinkButton)sender;
                GridViewRow item = (GridViewRow)btn_select.NamingContainer;
                HiddenField hd_idselect = (HiddenField)item.FindControl("hd_id");
                HiddenField hd_name = (HiddenField)item.FindControl("hd_name");
                HiddenField hd_status = (HiddenField)item.FindControl("hd_status");

                using (MySqlConnection con = new MySqlConnection(connString))
                {
                    MySqlCommand cmd = new MySqlCommand("SELECT * FROM complaints WHERE ComplaintID = @ComplaintID", con);
                    cmd.Parameters.AddWithValue("@ComplaintID", hd_idselect.Value);
                    con.Open();
                    MySqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        hd_complaintid.Value = dr["ComplaintID"].ToString();
                        lblFullName.Text = dr["FullName"].ToString();
                        lblContact.Text = dr["Contact"].ToString();
                        lblCategory.Text = dr["Category"].ToString();
                        lblPlace.Text = dr["PlaceOccurrence"].ToString();
                        lblDescription.Text = dr["BriefDetails"].ToString();
                        lblStatus.Text = dr["Status"].ToString();
                        lblDateFiled.Text = dr["DateFiled"].ToString();
                     
                        string imgPath = dr["EvidenceImage"].ToString();
                       
                        if (!string.IsNullOrEmpty(imgPath))
                        {
                            imgEvidence.ImageUrl = imgPath;
                            imgEvidence.Visible = true;
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
            hd_complaintid.Value = "";
            hd_actionid.Value = "";
            txtActionBy.Text = "";
            txtRemarks.Text = "";
            dpActionStatus.SelectedIndex = 0;
           
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

    }

}