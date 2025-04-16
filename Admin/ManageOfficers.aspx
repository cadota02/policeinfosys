<%@ Page Title="Officers" Language="C#" MasterPageFile="~/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="ManageOfficers.aspx.cs" Inherits="policeinfosys.Admin.ManageOfficers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder_header" runat="server">
     <script type="text/javascript">
         function openModal() {
             $('#officerModal').modal('show');
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
              <h3 class="card-title">Manage Police Officers</h3>

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
                                                        <asp:Button ID="btnAddNew" CssClass="btn btn-success btn-sm" runat="server" Text="Add New Officer" OnClick="btnAddNew_Click" />
                                                </div>
                                             
                                                  </div>
        <!-- GridView -->
                           <div class="table-responsive">
        <asp:GridView ID="gvOfficers" runat="server" AutoGenerateColumns="False" CssClass="table table-sm table-bordered table-hover"
           AllowPaging="true" OnPageIndexChanging="OnPaging" PageSize="10" PagerSettings-Mode="NumericFirstLast"
             HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Middle" >
            <Columns>
                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                       <HeaderTemplate> # </HeaderTemplate>
                                        <ItemTemplate>
       
                                            <asp:Label ID="lbl_no" runat="server" Text="<%# Container.DataItemIndex + 1 %>  "></asp:Label>
                                         </ItemTemplate>
                                    </asp:TemplateField>
                <asp:BoundField DataField="Fullname" HeaderText="Fullname" />
                <asp:BoundField DataField="Position" HeaderText="Position" />
                <asp:BoundField DataField="PRank" HeaderText="Rank" />
                <asp:ImageField DataImageUrlField="ImagePath" HeaderText="Photo" ItemStyle-HorizontalAlign="Center" ControlStyle-Width="60px" ControlStyle-Height="60px" />
                 <asp:BoundField DataField="Status" HeaderText="Status" />
                 <asp:TemplateField>
                                        <HeaderTemplate> Action </HeaderTemplate>
                                     <ItemTemplate>
                                      <asp:HiddenField ID="hd_id" Value='<%#Eval("OfficerID") %>' runat="server"></asp:HiddenField>
                           <asp:HiddenField ID="hd_status" Value='<%#Eval("IsActive") %>' runat="server"></asp:HiddenField>
                                      <asp:HiddenField ID="hd_name" Value='<%#Eval("Fullname") %>' runat="server"></asp:HiddenField>
                                      <asp:LinkButton ID="btn_select" CssClass="btn btn-primary btn-xs "  CommandArgument='<%# Eval("OfficerID") %>' onclick="btn_select_Click"  runat="server" >Edit</asp:LinkButton>
                                      <asp:LinkButton ID="btn_delete" CssClass="btn btn-danger btn-xs " onclick="btn_delete_Click" runat="server"
                                      OnClientClick="return getConfirmation_verifys(this, 'Please confirm','Are you sure you want to Delete?');"
                                       >Remove</asp:LinkButton>

                                           <asp:Button ID="btnAction" runat="server" 
                    Text='<%# Eval("Status").ToString() == "Active" ? "Inactive" : "Active" %>' 
                    CssClass='<%# Eval("Status").ToString() == "Active" ? "btn btn-xs btn-warning" : "btn btn-xs btn-info" %>' 
                    CommandArgument='<%# Eval("OfficerID") %>'
                    OnClick="btnAction_Click"   OnClientClick='<%# "return getConfirmation_activate(\"" + Eval("Status") + "\");" %>'/>
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
    <div class="modal fade" id="officerModal" role="dialog">
        <div class="modal-dialog" role="document">
            <asp:Panel ID="pnlOfficerForm" CssClass="modal-content" runat="server">
                <div class="modal-header">
                    <h5 class="modal-title">Officer Details</h5>
                  <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true">×</span></button>
                </div>
                 <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="modal-body">

                    <!-- Form Fields -->
                    <asp:HiddenField ID="hfOfficerID" Value="0" runat="server" />
                        <asp:HiddenField ID="hdimagepath" Value="" runat="server" />
                    <div class="row">
    <div class="col-sm-6 mb-2">
        <label for="txtFirstName">First Name
              <asp:RequiredFieldValidator ControlToValidate="txtFirstName" ValidationGroup="add" ErrorMessage="*" ForeColor="Red" Display="Dynamic" runat="server" />
        </label>
        <asp:TextBox ID="txtFirstName" CssClass="form-control" runat="server" Placeholder="Enter first name"></asp:TextBox>
      
    </div>

    <div class="col-sm-6 mb-2">
        <label for="txtLastName">Last Name
              <asp:RequiredFieldValidator ControlToValidate="txtLastName" ValidationGroup="add" ErrorMessage="*" ForeColor="Red" Display="Dynamic" runat="server" />
        </label>
        <asp:TextBox ID="txtLastName" CssClass="form-control" runat="server" Placeholder="Enter last name"></asp:TextBox>
      
    </div>

    <div class="col-sm-6 mb-2">
        <label for="txtMiddleName">Middle Name</label>
        <asp:TextBox ID="txtMiddleName" CssClass="form-control" runat="server" Placeholder="Enter middle name"></asp:TextBox>
    </div>

    <div class="col-sm-6 mb-2">
        <label for="txtPosition">Position
                <asp:RequiredFieldValidator ControlToValidate="txtPosition" ValidationGroup="add" ErrorMessage="*" ForeColor="Red" Display="Dynamic" runat="server" />

        </label>
        <asp:TextBox ID="txtPosition" CssClass="form-control" runat="server" Placeholder="Enter position"></asp:TextBox>
    
    </div>

    <div class="col-sm-12 mb-2">
        <label for="txtRank">Rank
               <asp:RequiredFieldValidator ControlToValidate="txtRank" ValidationGroup="add" ErrorMessage="*" ForeColor="Red" Display="Dynamic" runat="server" />

        </label>
        <asp:TextBox ID="txtRank" CssClass="form-control" runat="server" Placeholder="Enter rank"></asp:TextBox>
     
    </div>

    <div class="col-sm-12 mb-2">
        <label for="txtAddress">Address</label>
        <asp:TextBox ID="txtAddress" CssClass="form-control" runat="server" Placeholder="Enter address"></asp:TextBox>
    </div>

    <div class="col-sm-6 mb-2">
        <label for="txtContact">Contact No.</label>
        <asp:TextBox ID="txtContact" CssClass="form-control" runat="server" Placeholder="Enter contact number"></asp:TextBox>
    </div>

    <div class="col-sm-6 mb-2">
        <label for="txtEmail">Email Address</label>
        <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" Placeholder="Enter email address"></asp:TextBox>
    </div>

    <div class="col-sm-12 mb-2">
        <label for="fuImage">Profile Image</label>
        <asp:FileUpload ID="fuImage" CssClass="form-control" runat="server" />
        <asp:Image ID="imgPreview" runat="server" Width="100" Visible="false" CssClass="mt-2" />
    </div>

    <div class="col-sm-12 mb-2">
        <label for="txtContent">Additional Details</label>
        <asp:TextBox ID="txtContent" TextMode="MultiLine" CssClass="form-control" Rows="3" runat="server" Placeholder="Enter additional information"></asp:TextBox>
    </div>
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
