<%@ Page Title="Manage Bill" Language="C#" MasterPageFile="~/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="ManageBill.aspx.cs" Inherits="policeinfosys.Admin.ManageBill" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder_header" runat="server">
    <link rel="stylesheet" href="Content/AdminLTE/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
    <link rel="stylesheet" href="Content/AdminLTE/plugins/select2/css/select2.min.css">
    <script type="text/javascript" src="Content/AdminLTE/plugins/select2/js/select2.full.min.js"></script>
       <script type="text/javascript">
           function openModal() {
               $('#AddChargeModal').modal('show');
           }
           function closeModal() {
               $('#AddChargeModal').modal('hide');
           }
           function getConfirmation_verify() {
               return confirm("Are you sure you want to delete?");
           }
           window.onload = function () {
               load_select();
           };
           //On UpdatePanel Refresh
           var prm = Sys.WebForms.PageRequestManager.getInstance();
           if (prm != null) {
               prm.add_endRequest(function (sender, e) {
                   if (sender._postBackSettings.panelsToUpdate != null) {
                       load_select();
                   }
               });
           };
           function load_select() {
               $(function () {
                   //Initialize Select2 Elements
                   $('.select2bs4').select2({
                       theme: 'bootstrap4'
                   })
               })
           };

     </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder_body" runat="server">
    <section class="content">
     <div class="container mt-5">
      <div class="row">
        <div class="col-md-8">
          <div class="card card-primary card-outline">
                  <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
            <div class="card-header">
              <h3 class="card-title">Item/s</h3>

              <div class="card-tools">
                
                    <div class="form-group row">
                         <div class="col-sm-7">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search charges..." AutoPostBack="True" OnTextChanged="txtSearch_TextChanged"></asp:TextBox>
                      </div>
                           <div class="col-sm-3">
                <asp:Button ID="btnAddCharge" runat="server" Text="Add Item" CssClass="btn btn-success" OnClick="btnAddCharge_Click" />
               </div>
                        </div>
                  </div>
            </div>
            <div class="card-body">
                  <div class="table-responsive">
                  <asp:GridView ID="gvCart" runat="server" CssClass="table table-bordered"
                                AutoGenerateColumns="False"  >
                                <Columns>
                                    <asp:BoundField DataField="chargename" HeaderText="Item/Description" />
                                        <asp:BoundField DataField="qty" HeaderText="Price" DataFormatString="{0:N2}" />
                                    <asp:BoundField DataField="price" HeaderText="Price" DataFormatString="{0:N2}" />
                                     <asp:BoundField DataField="amount" HeaderText="Amount" DataFormatString="{0:N2}" />
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                                 <asp:HiddenField ID="hd_id" Value='<%#Eval("cartid") %>' runat="server"></asp:HiddenField>
                                   
                                      <asp:HiddenField ID="hd_name" Value='<%#Eval("chargename") %>' runat="server"></asp:HiddenField>
                                            <asp:LinkButton ID="btnEdit" runat="server"  onclick="btnEdit_Click"  Text="Edit" CssClass="btn btn-warning btn-sm" />
                                            <asp:LinkButton ID="btnDelete" runat="server"   OnClientClick="return getConfirmation_verifys(this, 'Please confirm','Are you sure you want to Delete?');" onclick="btn_delete_Click" Text="Delete" CssClass="btn btn-danger btn-sm" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                      </div>
              </div>
                <div class="card-footer">
                            <asp:Label ID="lblFooter" CssClass="lbl-b text-lg" runat="server" Text="Total Items: 0 | Total: ₱0.00"></asp:Label>
                        </div>
                </ContentTemplate>
                      </asp:UpdatePanel>
                </div>
              </div>
            
          <div class="col-md-4">
          <div class="card card-primary card-outline">
            <div class="card-header">
              <h3 class="card-title">Billing Statement</h3>

              <div class="card-tools">
   
              
              </div>
            </div>
            <div class="card-body">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                  <asp:HiddenField ID="hd_invid" Value="0" runat="server" />
                              <div class="form-group row">
                                <label  class="col-sm-4 col-form-label">Customer</label>
                                <div class="col-sm-8">
                                     <asp:DropDownList ID="ddlCustomer"  runat="server" CssClass="form-control select2bs4" AppendDataBoundItems="False" Width="100%"></asp:DropDownList>
                                 </div>
                               </div>
                          <div class="form-group row">
                                <label  class="col-sm-4 col-form-label">Billing No</label>
                                <div class="col-sm-8">
                                <asp:TextBox ID="txtInvoiceNo" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>
                                </div>
                            <div class="form-group row">
                                <label  class="col-sm-4 col-form-label">Date</label>
                                  <div class="col-sm-8">
                                <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" TextMode="Date" ></asp:TextBox>
                            </div>
                                  </div>
                 <div class="form-group row">
                                <label  class="col-sm-4 col-form-label">Cost</label>
                             <div class="col-sm-8">
                                <asp:TextBox ID="txtcost" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>
                             </div>
                           <div class="form-group row">
                                <label  class="col-sm-4 col-form-label">Cash Tendered</label>
                                 <div class="col-sm-8">
                                     <asp:HiddenField ID="hd_tamount" Value="0" runat="server" />
                                <asp:TextBox ID="txtCash" runat="server" CssClass="form-control"  AutoPostBack="True" OnTextChanged="txtCash_TextChanged"></asp:TextBox>
                            </div>
                                 </div>
                       <div class="form-group row">
                                <label  class="col-sm-4 col-form-label">Change</label>
                             <div class="col-sm-8">
                                <asp:TextBox ID="txtChange" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>
                             </div>
                            <div class="form-group row">
                                <label  class="col-sm-4 col-form-label">Remarks</label>
                                  <div class="col-sm-8">
                                <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                                  </div>
                            <asp:Button ID="btnSubmit" runat="server" Text="Submit Bill" CssClass="btn btn-success btn-block" OnClick="btnSubmit_Click" />
                           <asp:HyperLink ID="btnPrint" runat="server" Visible="false" CssClass="btn btn-default btn-block" Text='Print Bill' Target="_blank"></asp:HyperLink>
                </ContentTemplate>
                        </asp:UpdatePanel>
                        </div>
            </div>
           </div>
      </div>
     </div>

  </section>


    <!-- Add Item Modal -->
  <div class="modal fade" id="AddChargeModal" role="dialog">
        <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="addItemModalLabel">Add Item </h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
      <div class="modal-body">

          <asp:HiddenField ID="hd_cartid" Value="0" runat="server" />
        <div class="form-group">
          <label >Charge Name</label>
          <asp:DropDownList ID="ddlChargeName" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlChargeName_SelectedIndexChanged">
          </asp:DropDownList>
        </div>
        <div class="form-group">
          <label>Price</label>
          <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
        </div>
        <div class="form-group">
          <label >Quantity</label>
          <asp:TextBox ID="txtQuantity" TextMode="Number" runat="server" CssClass="form-control" AutoPostBack="True" OnTextChanged="txtQuantity_TextChanged"></asp:TextBox>
        </div>
          <div class="form-group">
              <label >Total Amount</label>
              <asp:TextBox ID="txtTotalAmount" runat="server"  ClientIDMode="Static" CssClass="form-control" ReadOnly="true"></asp:TextBox>
            </div>
      </div>
      <div class="modal-footer">
        <asp:Button ID="btnSaveItem" runat="server" Text="Save" CssClass="btn btn-success" OnClick="btnSaveItem_Click" />
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
                </ContentTemplate>
                </asp:UpdatePanel>
    </div>
  </div>
</div>


</asp:Content>
