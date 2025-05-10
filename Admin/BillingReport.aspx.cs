using System;
using System.Collections.Generic;
using System.Linq;
using System;
using System.Configuration;
using System.Data;
using System.Web.Security;
using MySql.Data.MySqlClient;
using System.Web.UI.WebControls;
using System.Web.UI;

namespace policeinfosys.Admin
{
    public partial class BillingReport : System.Web.UI.Page
    {
        public string connStr = ConfigurationManager.ConnectionStrings["myconnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                txtDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                LoadReport(DateTime.Today);
            }
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            DateTime selectedDate;
            if (DateTime.TryParse(txtDate.Text, out selectedDate))
            {
                LoadReport(selectedDate);
            }
        }

        private void LoadReport(DateTime date)
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                string query = "SELECT * FROM vw_invoicereport WHERE invoicedate = @invoicedate";
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@invoicedate", date);
                    using (MySqlDataAdapter da = new MySqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvReport.DataSource = dt;
                        gvReport.DataBind();
                        lblTotalRecords.Text = "Total Records: " + gvReport.Rows.Count.ToString();
                    }
                }
            }
        }
        int rowCount = 0;
        decimal totalAmount = 0;

        protected void gvReport_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            // Accumulate values
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                rowCount++;

                decimal amount = 0;
                Decimal.TryParse(DataBinder.Eval(e.Row.DataItem, "amount").ToString(), out amount);
                totalAmount += amount;
            }

            // Set footer
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                e.Row.Cells[0].Text = "TOTAL";
                e.Row.Cells[0].ColumnSpan = 6;
                e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Right;
                e.Row.Cells.RemoveAt(1); e.Row.Cells.RemoveAt(1); e.Row.Cells.RemoveAt(1); e.Row.Cells.RemoveAt(1); // Adjust for merged cells

                e.Row.Cells[1].Text = "₱ " + totalAmount.ToString("N2"); // Total amount
                e.Row.Font.Bold = true;
            }
        }
    }

}