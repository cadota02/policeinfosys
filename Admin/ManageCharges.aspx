<%@ Page Title="Charges" Language="C#" MasterPageFile="~/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="ManageCharges.aspx.cs" Inherits="policeinfosys.Admin.ManageCharges" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder_header" runat="server">
     <script type="text/javascript">
         function openModal() {
             $('#ChargesModal').modal('show');
         }
         function getConfirmation_verify() {
             return confirm("Are you sure you want to delete?");
         }
    

     </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder_body" runat="server">
    <section class="content">
     <div class="container mt-5">
      <div class="row">
        <div class="col-md-12">
          <div class="card card-primary card-outline">
            <div class="card-header">
              <h3 class="card-title">Manage Charges</h3>

              <div class="card-tools">
   
              
              </div>
            </div>
            <div class="card-body">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
    

                    <div class="form-group row">
                               
                                                <div class="col-sm-4">
                                       
                                                 <asp:TextBox ID="txt_search" CssClass="form-control form-control-sm" placeholder="Enter keyword" runat="server"></asp:TextBox>
                                                </div>
                                              
                                                <div class="col-sm-8">
                                                 
                                                 <asp:LinkButton ID="btn_filter" CssClass="btn btn-info btn-sm" 
                                                         runat="server" onclick="btn_filter_Click" > Search</asp:LinkButton>
                                                          <asp:LinkButton ID="btn_reset" CssClass="btn btn-default btn-sm" 
                                                         runat="server" onclick="btn_reset_Click" BackColor="#999999">Refresh</asp:LinkButton>
                                                        <asp:Button ID="btnAddNew" CssClass="btn btn-success btn-sm" runat="server" Text="Add New Charge" OnClick="btnAddNew_Click" />
                                                </div>
                                             
                                                  </div>
        <!-- GridView -->
                           <div class="table-responsive">
        <asp:GridView ID="gvCharges" runat="server" AutoGenerateColumns="False" CssClass="table table-sm table-bordered table-hover"
           AllowPaging="true" OnPageIndexChanging="OnPaging" PageSize="10" PagerSettings-Mode="NumericFirstLast"
             HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Middle" >
            <Columns>
                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                       <HeaderTemplate> # </HeaderTemplate>
                                        <ItemTemplate>
       
                                            <asp:Label ID="lbl_no" runat="server" Text="<%# Container.DataItemIndex + 1 %>  "></asp:Label>
                                         </ItemTemplate>
                                    </asp:TemplateField>
                <asp:BoundField DataField="chargename" HeaderText="Item Description" />
                <asp:BoundField DataField="price" HeaderText="Price" />
              
                 <asp:BoundField DataField="Status" HeaderText="Status" />
                 <asp:TemplateField>
                                        <HeaderTemplate> Action </HeaderTemplate>
                                     <ItemTemplate>
                                      <asp:HiddenField ID="hd_id" Value='<%#Eval("id") %>' runat="server"></asp:HiddenField>
                           <asp:HiddenField ID="hd_status" Value='<%#Eval("isactive") %>' runat="server"></asp:HiddenField>
                                      <asp:HiddenField ID="hd_name" Value='<%#Eval("chargename") %>' runat="server"></asp:HiddenField>
                                      <asp:LinkButton ID="btn_select" CssClass="btn btn-primary btn-xs "  CommandArgument='<%# Eval("id") %>' onclick="btn_select_Click"  runat="server" >Edit</asp:LinkButton>
                                      <asp:LinkButton ID="btn_delete" CssClass="btn btn-danger btn-xs " onclick="btn_delete_Click" runat="server"
                                      OnClientClick="return getConfirmation_verifys(this, 'Please confirm','Are you sure you want to Delete?');"
                                       >Remove</asp:LinkButton>

                                       
                                     </ItemTemplate>
                                   </asp:TemplateField>
            </Columns>
        </asp:GridView>
               </div>
            </ContentTemplate>
         </asp:UpdatePanel>
    </div>
       </div>
       </div>
    </div>
   </div>
 </section>

    <!-- Modal -->
    <div class="modal fade" id="ChargesModal" role="dialog">
        <div class="modal-dialog" role="document">
            <asp:Panel ID="pnlOfficerForm" CssClass="modal-content" runat="server">
                <div class="modal-header">
                    <h5 class="modal-title">Charge Details</h5>
                  <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true">×</span></button>
                </div>
                 <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="modal-body">

                    <!-- Form Fields -->
                    <asp:HiddenField ID="hfchargid" Value="0" runat="server" />
                  
         
                                <div class="col-sm-12 mb-2">
                                    <label >Charge Name
                                          <asp:RequiredFieldValidator ControlToValidate="txt_chargename" ValidationGroup="add" ErrorMessage="*" ForeColor="Red" Display="Dynamic" runat="server" />
                                    </label>
                                    <asp:TextBox ID="txt_chargename" CssClass="form-control" runat="server" Placeholder="Enter Charge name"></asp:TextBox>
      
                                </div>

                                <div class="col-sm-12 mb-2">
                                    <label>Price
                                          <asp:RequiredFieldValidator ControlToValidate="txt_price" ValidationGroup="add" ErrorMessage="*" ForeColor="Red" Display="Dynamic" runat="server" />
                                    </label>
                                    <asp:TextBox ID="txt_price" CssClass="form-control" TextMode="Number" runat="server" Placeholder="Enter price"></asp:TextBox>
      
                                </div>

                                <div class="col-sm-12 mb-2">
                                    <labe>Status</label>
                                <asp:DropDownList ID="dpstatus" runat="server" CssClass="form-control">
                                     <asp:ListItem Text="Active" Value="1"></asp:ListItem>
                                                <asp:ListItem Text="Inactive" Value="0"></asp:ListItem>
                                               
                                            </asp:DropDownList>
                                </div>

   
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnSave" CssClass="btn btn-success"  ValidationGroup="add" runat="server" Text="Save" OnClick="btnSave_Click" />
                    <button type="button" class="btn btn-secondary"  data-dismiss="modal" aria-label="Close">Close</button>
                </div>
                </ContentTemplate>
                      <Triggers>
                    <asp:PostBackTrigger ControlID="btnSave" />
                </Triggers>
               </asp:UpdatePanel>
            </asp:Panel>
        </div>
    </div>
</asp:Content>
