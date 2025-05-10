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
    public partial class ManageCharges : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["myconnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCharges();
            }
        }
        protected void OnPaging(object sender, GridViewPageEventArgs e)
        {
            gvCharges.PageIndex = e.NewPageIndex;
            this.LoadCharges();
        }
        protected void btn_filter_Click(object sender, EventArgs e)
        {
            LoadCharges();
        }
        protected void btn_reset_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect("ManageCharges");

        }
        private void LoadCharges()
        {
            using (MySqlConnection conn = new MySqlConnection(connString))
            {
                conn.Open();
                using (MySqlCommand cmd = new MySqlCommand())
                {
                    string sql = "select *, " +
                        "CASE WHEN isactive = 1 THEN 'Active' ELSE 'Inactive' END AS Status " +
                        "from chargeslist where 1=1 ";

                    if (txt_search.Text.Trim() != "")
                    {
                        sql += @"and
                       (chargename LIKE @search  ) ";
                    }
                    sql += "  order by id desc ";
                    cmd.CommandText = sql;
                    cmd.Parameters.AddWithValue("@search", "%" + txt_search.Text + "%");
                    cmd.Connection = conn;
                    using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                    {

                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        gvCharges.DataSource = dt;
                        gvCharges.DataBind();

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
        protected void AddCharges()
        {
            try
            {
                using (MySqlConnection conn = new MySqlConnection(connString))
                {
                    string query = @"INSERT INTO chargeslist 
            (chargename,price,isactive) 
            VALUES 
            (@chargename,@price,@isactive)";

                    using (MySqlCommand cmd = new MySqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@chargename", txt_chargename.Text.Trim());
                        cmd.Parameters.AddWithValue("@price", txt_price.Text.Trim());
                       
                        cmd.Parameters.AddWithValue("@isactive", dpstatus.SelectedValue);

                   
                        conn.Open();
                        cmd.ExecuteNonQuery();

                        AlertNotify.ShowMessage(this, "Successfully Saved!", "Success", AlertNotify.MessageType.Success);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pops2", "$('#ChargesModal').modal('hide')", true);
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
        protected void UpdateCharges(int Id)
        {
            try

            {

                using (MySqlConnection conn = new MySqlConnection(connString))
                {
                    string query = @"UPDATE chargeslist SET 
            chargename=@d1,price=@d2,isactive=@d3
            WHERE id = @id";

                    using (MySqlCommand cmd = new MySqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@id", Id);
                        cmd.Parameters.AddWithValue("@d1", txt_chargename.Text.Trim());
                        cmd.Parameters.AddWithValue("@d2", txt_price.Text.Trim());
                        cmd.Parameters.AddWithValue("@d3", dpstatus.SelectedValue);
                

                      

                        conn.Open();
                        cmd.ExecuteNonQuery();
                        AlertNotify.ShowMessage(this, "Successfully Saved!", "Success", AlertNotify.MessageType.Success);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pops2", "$('#ChargesModal').modal('hide')", true);

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
               
                string officerid = hfchargid.Value;
                if (officerid == "0") //add
                {
                    AddCharges();

                }
                else
                {
                    UpdateCharges(int.Parse(officerid)); //edit
                }
                LoadCharges(); // Refresh GridView
                ClearFields();

            }
            catch (Exception ex)
            {
                ErrorLogger.WriteErrorLog(ex);

                AlertNotify.ShowMessage(this, ex.Message.ToString(), "Error", AlertNotify.MessageType.Error);
            }
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
                    MySqlCommand cmd = new MySqlCommand("SELECT * from chargeslist WHERE id = @id", con);
                    cmd.Parameters.AddWithValue("@id", hd_idselect.Value);
                    con.Open();
                    MySqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        hfchargid.Value = dr["id"].ToString();
                        txt_chargename.Text = dr["chargename"].ToString();
                        txt_price.Text = dr["price"].ToString();
                       dpstatus.SelectedValue = dr["isactive"].ToString();
                      
                    }
                    con.Close();
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop2", "$('#ChargesModal').modal('show')", true);
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
                    using (MySqlCommand checkCmd = new MySqlCommand())
                    {
                        checkCmd.Connection = conn;
                        checkCmd.CommandText = "SELECT COUNT(*) FROM invoicecart WHERE chargename = (SELECT chargename FROM chargeslist WHERE id = @id)";
                        checkCmd.Parameters.AddWithValue("@id", hd_idselect.Value);

                        int usageCount = Convert.ToInt32(checkCmd.ExecuteScalar());

                        if (usageCount > 0)
                        {
                            AlertNotify.ShowMessage(this, "Cannot delete. This charge is already used in an invoice.", "Warning", AlertNotify.MessageType.Warning);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "$('#modalPopUp_Delete').modal('hide')", true);
                            return;
                        }
                    }
                }
                using (MySqlConnection conn = new MySqlConnection(connString))
                {
                    conn.Open();
                    using (MySqlCommand cmd = new MySqlCommand())
                    {
                        String cb = "Delete from chargeslist where id = " + hd_idselect.Value + "";
                        cmd.CommandText = cb;
                        cmd.Connection = conn;

                        int result = cmd.ExecuteNonQuery();
                        conn.Close();

                        if (result >= 1)
                        {

                            AlertNotify.ShowMessage(this, "Successfully Deleted!", "Success", AlertNotify.MessageType.Success);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "$('#modalPopUp_Delete').modal('hide')", true);
                            LoadCharges();

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
           
            hfchargid.Value = "0";
            dpstatus.SelectedIndex = 0;
            txt_chargename.Text = txt_price.Text = "";
       
        }

    }
}