<%@ Page Title="Daily Report" Language="C#" MasterPageFile="~/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="BillingReport.aspx.cs" Inherits="policeinfosys.Admin.BillingReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder_header" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder_body" runat="server">
    <section class="content">
     <div class="container mt-5">
      <div class="row">
        <div class="col-md-12">
          <div class="card card-primary card-outline">
                  <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
            <div class="card-header">
              <h3 class="card-title">Billing Report</h3>

              <div class="card-tools">
                
             
                   
              </div>
             
            </div>
            <div class="card-body">
                
                           <div class="form-group row">
                         <div class="col-sm-4">
                    <asp:TextBox ID="txtDate" CssClass="form-control"  runat="server" TextMode="Date"></asp:TextBox>
                      </div>
                           <div class="col-sm-2">
                <asp:Button ID="btnFilter" runat="server" Text="Filter" CssClass="btn btn-success" OnClick="btnFilter_Click" />
                         </div>
                         <div class="col-sm-2">
                <asp:Button ID="btnPrint" runat="server" Text="Print" CssClass="btn btn-secondary" OnClientClick="printReport(); return false;" />
                        </div>
                        </div>
            
                <hr />
    <div id="printableArea" runat="server">
      
        <asp:GridView ID="gvReport" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered mt-3"
            ShowFooter="true" OnRowDataBound="gvReport_RowDataBound">
            <Columns>
                <asp:BoundField DataField="invoiceno" HeaderText="Billing No" />
                  <asp:BoundField DataField="customerid" HeaderText="Customer" />
                <asp:BoundField DataField="invoicedate" HeaderText="Date" DataFormatString="{0:MMM dd, yyyy}" />
                <asp:BoundField DataField="chargename" HeaderText="Item/Description" />
                <asp:BoundField DataField="qty" HeaderText="Qty" />
                <asp:BoundField DataField="price" HeaderText="Price" DataFormatString="{0:N2}" />
                <asp:BoundField DataField="amount" HeaderText="Total Amount" DataFormatString="{0:N2}" />
            </Columns>
        </asp:GridView>
        <asp:Label ID="lblTotalRecords" runat="server" CssClass="font-weight-bold mt-3"></asp:Label>
    </div>


              </div>
                </ContentTemplate>
            </asp:UpdatePanel>
              </div>
            </div>
          </div>
         </div>
        </section>
        <script type="text/javascript">
            function printReport() {
                var reportHeader = `
            <div style="text-align:center; margin-bottom: 20px;">
                <h5>Police Information System</h5>
                <h4>Daily Billing Report</h4>
                <p>Date Printed: ${new Date().toLocaleDateString()}</p>
                <hr />
            </div>
        `;
                var printContents = document.getElementById('<%= printableArea.ClientID %>').innerHTML;
                var originalContents = document.body.innerHTML;

                document.body.innerHTML = reportHeader+ printContents;
                window.print();
                document.body.innerHTML = originalContents;
                location.reload();
            }
    </script>
</asp:Content>
