<%@ Page Title="Complaints" Language="C#" MasterPageFile="~/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="ManageComplaint.aspx.cs" Inherits="policeinfosys.Admin.ManageComplaint" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder_header" runat="server">
     <script type="text/javascript">
         function openModal() {
             $('#ComplaintModal').modal('show');
         }
         function openModalHistory() {
             $('#modalComplaintHistory').modal('show');
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
              <h3 class="card-title">Manage Complaints</h3>

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
                                                      
                                                </div>
                                             
                                                  </div>
        <!-- GridView -->
                           <div class="table-responsive">
        <asp:GridView ID="gvComplaints" runat="server" AutoGenerateColumns="False" CssClass="table table-sm table-bordered table-hover"
           AllowPaging="true" OnPageIndexChanging="OnPaging" PageSize="10" PagerSettings-Mode="NumericFirstLast"
             HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Middle" >
            <Columns>
                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                       <HeaderTemplate> # </HeaderTemplate>
                                        <ItemTemplate>
       
                                            <asp:Label ID="lbl_no" runat="server" Text="<%# Container.DataItemIndex + 1 %>  "></asp:Label>
                                         </ItemTemplate>
                                    </asp:TemplateField>
                <asp:BoundField DataField="FullName" HeaderText="Fullname" />
                <asp:BoundField DataField="Contact" HeaderText="Contact" />
                <asp:BoundField DataField="BriefDetails" HeaderText="Details" />
                  <asp:BoundField DataField="PlaceOccurrence" HeaderText="Place" />
                  <asp:BoundField DataField="Category" HeaderText="Category" />

                 <asp:BoundField DataField="Status" HeaderText="Status" />
                             <asp:BoundField DataField="DateFiled" HeaderText="Date" />
                 <asp:TemplateField>
                                        <HeaderTemplate> Action </HeaderTemplate>
                                     <ItemTemplate>
                                      <asp:HiddenField ID="hd_id" Value='<%#Eval("ComplaintID") %>' runat="server"></asp:HiddenField>
                           <asp:HiddenField ID="hd_status" Value='<%#Eval("Status") %>' runat="server"></asp:HiddenField>
                                      <asp:HiddenField ID="hd_name" Value='<%#Eval("FullName") %>' runat="server"></asp:HiddenField>
                                      <asp:LinkButton ID="btn_select" CssClass="btn btn-success btn-xs "  CommandArgument='<%# Eval("ComplaintID") %>' onclick="btn_select_Click"  runat="server" >Action</asp:LinkButton>
                                      <asp:LinkButton ID="btn_delete" CssClass="btn btn-danger btn-xs " onclick="btn_delete_Click" runat="server"
                                      OnClientClick="return getConfirmation_verifys(this, 'Please confirm','Are you sure you want to Delete?');"
                                       >Remove</asp:LinkButton>

                                           <asp:Button ID="btnAction"  CssClass="btn btn-default btn-xs "  runat="server" CommandArgument='<%# Eval("ComplaintID") %>'
                                             OnClick="btnAction_Click"   Text="History Action"/>
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
    <div class="modal fade" id="ComplaintModal" role="dialog">
        <div class="modal-dialog modal-lg " role="document" >
            <asp:Panel ID="pnlOfficerForm" CssClass="modal-content" runat="server">
                <div class="modal-header">
                    <h5 class="modal-title">Complaint Action</h5>
                  <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true">×</span></button>
                </div>
                 <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="modal-body">

                    <!-- Form Fields -->
                      <asp:HiddenField ID="hd_complaintid" Value="0" runat="server" />
                    <asp:HiddenField ID="hd_actionid" Value="0" runat="server" />
                   <asp:Panel ID="pnlComplaintDetails" runat="server">
             <table class="table table-bordered table-hover table-sm">
        <tbody>
            <tr>
                <th>Full Name</th>
                <td><asp:Label ID="lblFullName" runat="server" CssClass="text-dark" /></td>
                <th>Contact</th>
                <td><asp:Label ID="lblContact" runat="server" CssClass="text-dark" /></td>
            </tr>
            <tr>
                <th>Place of Occurrence</th>
                <td><asp:Label ID="lblPlace" runat="server" CssClass="text-dark" /></td>
                <th>Category</th>
                <td><asp:Label ID="lblCategory" runat="server" CssClass="text-dark" /></td>
            </tr>
            <tr>
                <th>Status</th>
                <td><asp:Label ID="lblStatus" runat="server" CssClass="text-dark" /></td>
                <th>Date Filed</th>
                <td><asp:Label ID="lblDateFiled" runat="server" CssClass="text-dark" /></td>
            </tr>
            <tr>
                <th>Description</th>
                <td colspan="3"><asp:Label ID="lblDescription" runat="server" CssClass="text-dark" /></td>
            </tr>
            <tr>
                <th>Evidence/Photo</th>
                <td colspan="3">
                    <asp:Image ID="imgEvidence" runat="server" Width="100%" Height="180px" CssClass="img-fluid border rounded" />
                </td>
            </tr>
        </tbody>
    </table>
       
        </asp:Panel>
                      <div class="form-group row">
                          <div class="col-sm-6">
                      <label>Action Taken</label>
                       <asp:DropDownList ID="dpActionStatus" runat="server" CssClass="form-control">
                           <asp:ListItem>Pending</asp:ListItem>
                           <asp:ListItem>Reviewed</asp:ListItem>
                           <asp:ListItem>Investigating</asp:ListItem>
                               <asp:ListItem>Moved to RTC</asp:ListItem>
                               <asp:ListItem>Rescheduled</asp:ListItem>
                              <asp:ListItem>Completed</asp:ListItem>
                           <asp:ListItem>Resolved</asp:ListItem>
                           <asp:ListItem>Dismissed</asp:ListItem>
                </asp:DropDownList>
                      <asp:RequiredFieldValidator ID="rfvActionTaken" runat="server" ControlToValidate="dpActionStatus"
                        ErrorMessage="Action Taken is required." CssClass="text-danger" ValidationGroup="add"  Display="Dynamic" />
                      </div>
                      <div class="col-sm-6">
                      <label>Action By</label>
                      <asp:TextBox ID="txtActionBy" runat="server" CssClass="form-control" Placeholder="Enter your name or username"></asp:TextBox>
                      <asp:RequiredFieldValidator ID="rfvActionBy" runat="server" ControlToValidate="txtActionBy"
                        ErrorMessage="Action By is required." CssClass="text-danger" ValidationGroup="add" Display="Dynamic" />
                    </div>
                             
                    </div>
                   <div class="form-group row">
                        <div class="col-sm-12">
                      <label >Remarks</label>
                      <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" Placeholder="Remarks or additional notes..."></asp:TextBox>
                      <asp:RequiredFieldValidator ID="rfvRemarks" runat="server" ControlToValidate="txtRemarks"
                        ErrorMessage="Remarks are required." CssClass="text-danger" ValidationGroup="add" Display="Dynamic" />
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
    <!-- Complaint Action History Modal -->
<div class="modal fade" id="modalComplaintHistory"role="dialog" >
  <div class="modal-dialog modal-lg modal-dialog-scrollable" role="document">
    <div class="modal-content">
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title" id="historyModalLabel">Complaint Action History</h5>
         <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true">×</span></button>



      </div>
      <div class="modal-body">
            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
                     
                 <asp:Panel ID="Panel1" runat="server">
             <table class="table table-bordered table-hover table-sm">
        <tbody>
            <tr>
                <th>Full Name</th>
                <td><asp:Label ID="lbl_hfullname" runat="server" CssClass="text-dark" /></td>
                <th>Contact</th>
                <td><asp:Label ID="lbl_hcontact" runat="server" CssClass="text-dark" /></td>
            </tr>
            <tr>
                <th>Place of Occurrence</th>
                <td><asp:Label ID="lbl_hplace" runat="server" CssClass="text-dark" /></td>
                <th>Category</th>
                <td><asp:Label ID="lbl_hcategory" runat="server" CssClass="text-dark" /></td>
            </tr>
            <tr>
                <th>Status</th>
                <td><asp:Label ID="lbl_hstatus" runat="server" CssClass="text-dark" /></td>
                <th>Date Filed</th>
                <td><asp:Label ID="lbl_hdatefiled" runat="server" CssClass="text-dark" /></td>
            </tr>
            <tr>
                <th>Description</th>
                <td colspan="3"><asp:Label ID="lbl_hdesc" runat="server" CssClass="text-dark" /></td>
            </tr>
           <tr>
                <th>Evidence/Photo</th>
                <td colspan="3">
                    <asp:Image ID="imgHEvidence" runat="server" Width="100%" Height="180px" CssClass="img-fluid border rounded" />
                </td>
            </tr>
        </tbody>
    </table>
       
      

        <asp:GridView ID="gvComplaintHistory" runat="server" CssClass="table table-bordered table-striped table-sm"
                      AutoGenerateColumns="False" EmptyDataText="No history available."
                      GridLines="None">
          <Columns>
            <asp:BoundField DataField="ActionDate" HeaderText="Date" DataFormatString="{0:MMM dd, yyyy hh:mm tt}" />
            <asp:BoundField DataField="ActionTaken" HeaderText="Action Taken" />
            <asp:BoundField DataField="Remarks" HeaderText="Remarks" />
            <asp:BoundField DataField="ActionBy" HeaderText="Taken By" />
          </Columns>
        </asp:GridView>
                 </asp:Panel>
                </ContentTemplate>
                </asp:UpdatePanel>
      </div>
      <div class="modal-footer">
              <asp:UpdatePanel ID="UpdatePanel4" runat="server">
            <ContentTemplate>
           <asp:Button ID="btnPrintModal" runat="server" Text="Print Details"
    CssClass="btn btn-primary"
    OnClientClick="printModalContent('modalComplaintHistory'); return false;" />
          </ContentTemplate>
                     <Triggers>
                    <asp:PostBackTrigger ControlID="btnPrintModal" />
                </Triggers>
                </asp:UpdatePanel>
        <button type="button" class="btn btn-secondary" data-dismiss="modal" aria-label="Close">Close</button>
      </div>
    </div>
  </div>
</div>
  <script type="text/javascript">
      function printModalContent(modalId) {
          var modal = document.getElementById(modalId);
          if (!modal) {
              alert("Modal not found!");
              return;
          }

          var modalBody = modal.querySelector(".modal-body");
          if (!modalBody) {
              alert("Modal body not found!");
              return;
          }

          var content = modalBody.innerHTML;
          var printWindow = window.open('', '_blank', 'width=800,height=600');

          printWindow.document.write(`
      <html>
        <head>
          <title>Print</title>
          <link rel="stylesheet" href="Content/bootstrap.min.css">
          <style>
            body { padding: 20px; font-family: Arial; }
            .text-dark { color: #000 !important; }
            img { max-width: 100%; height: auto; }
          </style>
        </head>
        <body>
</br>
        <div style='text-align:center;'><h3>Complaint Status Report</h3></div></br>
            </hr>
          ${content}
          <script>
            window.onload = function() {
              window.print();
              window.onafterprint = function () { window.close(); };
            };
          <\/script>
        </body>
      </html>
    `);
          printWindow.document.close();
      }

      // Rebind any dynamic button events inside this if needed
      Sys.Application.add_load(function () {
          // Optional: rebind JS events if necessary
          // Example:
          // document.getElementById("btnPrint").onclick = function () {
          //   printModalContent('myModalID');
          // };
      });
</script>
</asp:Content>
