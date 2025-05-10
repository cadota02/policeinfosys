<%@ Page Title="My Complaints" Language="C#" MasterPageFile="~/SiteClient.Master" AutoEventWireup="true" CodeBehind="ClientComplaint.aspx.cs" Inherits="policeinfosys.Client.ClientComplaint" %>
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
              <h3 class="card-title">My Complaints</h3>

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
                                                         <asp:Button ID="btnAddNew" CssClass="btn btn-success btn-sm" runat="server" Text="New Complaint" OnClick="btnAddNew_Click" />
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
                                      <asp:LinkButton ID="btn_select" CssClass="btn btn-success btn-xs "    Visible='<%# Eval("Status").ToString() == "Pending" ? true : false %>'   CommandArgument='<%# Eval("ComplaintID") %>' onclick="btn_select_Click"  runat="server" >Edit</asp:LinkButton>
                                      <asp:LinkButton ID="btn_delete" CssClass="btn btn-danger btn-xs "     Visible='<%# Eval("Status").ToString() == "Pending" ? true : false %>'  onclick="btn_delete_Click" runat="server"
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
                    <h5 class="modal-title">Manage Complaint</h5>
                  <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true">×</span></button>
                </div>
                 <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="modal-body">

                    <!-- Form Fields -->
                      <asp:HiddenField ID="hd_complaintid" Value="0" runat="server" />
                <div class="form-group row">
                <div class="col-sm-6">
                <label>Full Name</label>
                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" Placeholder="Enter your full name"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvFullName"  runat="server" ControlToValidate="txtFullName" ErrorMessage="Full Name is required." CssClass="text-danger" Display="Dynamic" ValidationGroup="add" />
               </div>
                <div class="col-sm-6">
                <label>Contact</label>
                <asp:TextBox ID="txtContact" runat="server" CssClass="form-control" Placeholder="Enter contact number/email"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvContact" runat="server" ControlToValidate="txtContact" ErrorMessage="Contact is required." CssClass="text-danger" Display="Dynamic" ValidationGroup="add" />
                 </div>
          </div>
            <div class="form-group row">
                <div class="col-sm-6">
                <label>Place of Occurrence</label>
                <asp:TextBox ID="txtPlace" runat="server" CssClass="form-control" Placeholder="Where did it happen?"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPlace" runat="server" ControlToValidate="txtPlace" ErrorMessage="Place is required." ValidationGroup="add" CssClass="text-danger" Display="Dynamic" />
             </div>
              <div class="col-sm-6">
                <label>Category</label>
                <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ControlToValidate="ddlCategory" InitialValue="" ValidationGroup="add" ErrorMessage="Category is required." CssClass="text-danger" Display="Dynamic" />
             </div>
          </div>

            <div class="form-group">
                <label>Brief Details</label>
                <asp:TextBox ID="txtDetails" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" Placeholder="Describe the incident..."></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvDetails" runat="server" ControlToValidate="txtDetails" ErrorMessage="Description is required." ValidationGroup="add" CssClass="text-danger" Display="Dynamic" />
            </div>


            <div class="form-group">
                <label>Evidence Image (optional)</label>
                <asp:FileUpload ID="fuEvidence" runat="server" CssClass="form-control-file" />
            </div>
                  <div  class="col-md-12">
               <asp:HiddenField ID="hdfilepath" runat="server" />
                  <asp:Image ID="imgID" runat="server" Width="100%" Visible="false" Height="180px" CssClass="img-fluid border rounded" />
               <img id="previewImg" style="width:100%; height:180px;" class="img-fluid border rounded" />
           </div>
       
      
                   
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnSave" CssClass="btn btn-success"  ValidationGroup="add" runat="server" Text="Submit" OnClick="btnSave_Click" />
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
    <script type="text/javascript">
        function bindImagePreview() {
            var fileInput = document.getElementById('<%= fuEvidence.ClientID %>');
        var imgPreview = document.getElementById('previewImg');
        var hiddenPath = document.getElementById('<%= hdfilepath.ClientID %>');

            // If there's a saved filepath, show it
            if (hiddenPath && hiddenPath.value) {
                imgPreview.src = hiddenPath.value;
            }

            // Bind change event for live preview
            if (fileInput && imgPreview) {
                fileInput.addEventListener("change", function () {
                    if (fileInput.files && fileInput.files[0]) {
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            imgPreview.src = e.target.result;
                        };
                        reader.readAsDataURL(fileInput.files[0]);
                    }
                });
            }
        }

        // Initial load
        document.addEventListener("DOMContentLoaded", bindImagePreview);

        // Rebind after UpdatePanel partial postback
        Sys.Application.add_load(bindImagePreview);
</script>
</asp:Content>
