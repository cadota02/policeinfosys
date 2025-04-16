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
    public partial class ManageClearance : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["myconnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadClearanceGrid();
            }
        }

        private void LoadClearanceGrid()
        {
            using (MySqlConnection conn = new MySqlConnection(connString))
            {
                conn.Open();
                using (MySqlCommand cmd = new MySqlCommand())
                {
                    string sql = "select * from policeclearance where 1=1 ";

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
            imgID.ImageUrl = "";
            
            txtapprovedby.Text = "";
            txtpreparedby.Text = "";
            txtEditPurpose.Text = "";
            LinkButton btn = (LinkButton)sender;
            GridViewRow item = (GridViewRow)btn.NamingContainer;
            HiddenField hdClearanceID = (HiddenField)item.FindControl("hdClearanceID");
            using (MySqlConnection con = new MySqlConnection(connString))
            {
                string query = "SELECT * FROM policeclearance WHERE ClearanceID = @ID";
                MySqlCommand cmd = new MySqlCommand(query, con);
                cmd.Parameters.AddWithValue("@ID", hdClearanceID.Value);
                con.Open();
                MySqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    hfClearanceID.Value = hdClearanceID.Value;
                    ddlStatus.SelectedValue = dr["Status"].ToString();
                    txtEditPurpose.Text = dr["Purpose"].ToString();
                    txtapprovedby.Text = dr["approvedby"].ToString();
                    txtpreparedby.Text = dr["preparedby"].ToString();


                    lbl_hfullname.Text = dr["FullName"].ToString();
                    lbl_haddress.Text = dr["Address"].ToString();
                    lbl_hIDtype.Text = dr["ValidIDType"].ToString();
                    lbl_hIDno.Text = dr["ValidID"].ToString();
                
                    lbl_hstatus.Text = dr["Status"].ToString();
                    lbl_hdatefiled.Text = dr["DateFiled"].ToString();

                    string imgPath = dr["ValidIDFilePath"].ToString();

                    if (!string.IsNullOrEmpty(imgPath))
                    {
                        imgID.ImageUrl = "../"+ imgPath;
                        imgID.Visible = true;
                    }
                }
            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop2", "$('#pnlEditClearance').modal('show')", true);
            // ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "$('#pnlEditClearance').modal('show');", true);
        }
        protected void btnFilterClearance_Click(object sender, EventArgs e)
        {
            LoadClearanceGrid();
        }
        protected void btnUpdateClearance_Click(object sender, EventArgs e)
        {
            try

            {

                string status = ddlStatus.SelectedValue;
                string purpose = txtEditPurpose.Text;

                using (MySqlConnection con = new MySqlConnection(connString))
                {
                    string query = "UPDATE policeclearance SET Status=@Status, Purpose=@Purpose , preparedby=@preparedby, approvedby=@approvedby WHERE ClearanceID=@ID";
                    MySqlCommand cmd = new MySqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@Status", status);
                    cmd.Parameters.AddWithValue("@Purpose", purpose);
                    cmd.Parameters.AddWithValue("@approvedby", txtapprovedby.Text);
                    cmd.Parameters.AddWithValue("@preparedby", txtpreparedby.Text);
                    cmd.Parameters.AddWithValue("@ID", hfClearanceID.Value);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    AlertNotify.ShowMessage(this, "Successfully Updated!", "Success", AlertNotify.MessageType.Success);
                }

                LoadClearanceGrid();
                ClearFields();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "HideModal", "$('#pnlEditClearance').modal('hide');", true);
            }
            catch (Exception ex)
            {
                AlertNotify.ShowMessage(this, ex.Message.ToString(), "Error", AlertNotify.MessageType.Error);
            }
        }
        protected void btnResetClearance_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect("ManageClearance");
        }
        private void ClearFields()
        {
            


            imgID.ImageUrl = "";
            hfClearanceID.Value = "";
            ddlStatus.ClearSelection();
            txtapprovedby.Text = "";
            txtpreparedby.Text = "";
            txtEditPurpose.Text = "";
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
                    //lblClearanceNo.InnerText = reader["ClearanceNo"].ToString();
                    //lblName.InnerText = reader["FullName"].ToString();
                    //lblDOB.InnerText = Convert.ToDateTime(reader["DOB"]).ToString("MMM dd, yyyy");
                    //lblSex.InnerText = reader["Sex"].ToString();
                    //lblAddress.InnerText = reader["Address"].ToString();
                    //lblValidID.InnerText = reader["ValidIDType"].ToString();
                    //lblGovID.InnerText = reader["ValidID"].ToString();
                    //lblPurpose.InnerText = reader["Purpose"].ToString();
                    //lblStatus.InnerText = reader["Status"].ToString();
                    //lblDateFiled.InnerText = Convert.ToDateTime(reader["DateFiled"]).ToString("MMM dd, yyyy hh:mm tt");
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
    }
 }