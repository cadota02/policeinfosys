<%@ Page Title="My Clearance" Language="C#" MasterPageFile="~/SiteClient.Master" AutoEventWireup="true" CodeBehind="ClientClearance.aspx.cs" Inherits="policeinfosys.Client.ClientClearance" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder_header" runat="server">
     <script type="text/javascript">
         function openModal() {
             $('#pnlEditClearance').modal('show');
         }
         function getConfirmation_verify() {
             return confirm("Are you sure you want to delete?");
         }
     </script>
    <script>
        function printModalContent(modalId) {
            const modal = document.getElementById(modalId);
            const modalBody = modal.querySelector(".modal-body");

            const printWindow = window.open('', '_blank', 'width=400,height=600');
            printWindow.document.write(`
        <html>
        <head>
            <title>Print Clearance</title>
                 <style>
        @page {
            size: letter;
            margin: 5in;
        }

        body {
            font-family: 'Segoe UI', sans-serif;
            font-size: 14px;
            margin: 10px;
            padding: 0;
        }

        .container {
            width: 7.5in; /* fits well within letter page width */
            margin: 0 auto;
            padding: 20px;
            box-sizing: border-box;
        }

        .text-center { text-align: center; }
        .mb-0 { margin-bottom: 0; }
        .mb-2 { margin-bottom: 1rem; }
        .section-title {
            font-size: 18px;
            font-weight: bold;
            text-align: center;
            margin: 10px 0;
            text-transform: uppercase;
        }

        .info-label {
            font-weight: bold;
            display: inline-block;
            width: 150px;
        }

        hr {
            border: 1px solid black;
            margin: 15px 0;
        }

        .signature-block {
            margin-top: 30px;
        }

        @media print {
            body {
                margin: 0;
                padding: 0;
                color-adjust: exact;
                -webkit-print-color-adjust: exact;
            }

            .no-print {
                display: none;
            }
        }
    </style>
        </head>
        <body onload="window.print(); window.onafterprint = function () { window.close(); }">
            ${modalBody.innerHTML}
        </body>
        </html>
    `);
            printWindow.document.close();
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
                                <h3 class="card-title">My Clearance Application</h3>
                            </div>
                            <div class="card-body">
                                 <asp:UpdatePanel ID="UpdatePanelManageClearance" runat="server">
                          <ContentTemplate>
                                <div class="form-group row">
                                    <div class="col-sm-4">
                                        <asp:TextBox ID="txtSearchClearance" CssClass="form-control form-control-sm" placeholder="Enter keyword" runat="server"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-8">
                                        <asp:LinkButton ID="btnFilterClearance" CssClass="btn btn-info btn-sm" runat="server" OnClick="btnFilterClearance_Click">Search</asp:LinkButton>
                                        <asp:LinkButton ID="btnResetClearance" CssClass="btn btn-default btn-sm" runat="server" OnClick="btnResetClearance_Click">Refresh</asp:LinkButton>
                                 <asp:Button ID="btnAddNew" CssClass="btn btn-success btn-sm" runat="server" Text="New application" OnClick="btnAddNew_Click" />
                                        </div>
                                </div>

                                <div class="table-responsive">
                                    <asp:GridView ID="gvClearances" Style="font-size: 10pt;" runat="server" AutoGenerateColumns="False" CssClass="table table-sm table-bordered table-hover"
                                        AllowPaging="true" OnPageIndexChanging="OnPagingClearance" PageSize="10" PagerSettings-Mode="NumericFirstLast"
                                        HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Middle">
                                        <Columns>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                                <HeaderTemplate>Clearance No</HeaderTemplate>
                                                <ItemTemplate>
                                                          <asp:LinkButton ID="btn_showprint" runat="server"  Text='<%# Eval("ClearanceNo") %>'  Enabled='<%# Eval("Status").ToString() != "Pending" && Eval("Status").ToString() != "Disapproved" %>'    OnClick="btn_showprint_Click"></asp:LinkButton>
                        
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                              <asp:BoundField DataField="DateFiled" HeaderText="Date Filed" DataFormatString="{0:MMM dd, yyyy}" HtmlEncode="false" />
                                            <asp:BoundField DataField="FullName" HeaderText="Full Name" />
                                            <asp:BoundField DataField="DOB" HeaderText="Date of Birth"  DataFormatString="{0:MMM dd, yyyy}"/>
                                            <asp:BoundField DataField="Purpose" HeaderText="Purpose" />
                                            <asp:BoundField DataField="ValidIDType" HeaderText="ID Type" />
                                            <asp:BoundField DataField="Status" HeaderText="Status" />
                                            <asp:TemplateField>
                                                <HeaderTemplate>Action</HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:HiddenField ID="hdClearanceID" runat="server" Value='<%# Eval("ClearanceID") %>' />
                                                    <asp:LinkButton ID="btnEditClearance"  Visible='<%# Eval("Status").ToString() != "Approved" && Eval("Status").ToString() != "Released" %>' runat="server" CssClass="btn btn-success btn-xs"  OnClick="btnEditClearance_Click">Edit</asp:LinkButton>
                                                    <asp:LinkButton ID="btnDeleteClearance"  Visible='<%# Eval("Status").ToString() != "Approved" && Eval("Status").ToString() != "Released" %>' runat="server" CssClass="btn btn-danger btn-xs" OnClick="btnDeleteClearance_Click" OnClientClick="return getConfirmation_verifys(this, 'Please confirm','Are you sure you want to Delete?');">Delete</asp:LinkButton>
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
          <!-- Edit Modal Panel -->
                               <div class="modal fade" id="pnlEditClearance" role="dialog">
                                       <div class="modal-dialog modal-lg" role="document" >
                   
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Manage Clearance</h5>
                                                 <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true">×</span></button>
                                            </div>
                                             <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                <ContentTemplate>
                                            <div class="modal-body">
                         
                                                <asp:HiddenField ID="hfClearanceID" runat="server" />
                                               <div class="row mt-1">
          <div class="row">
            <!-- Full Name -->
                 <div class="col-md-3">
                <div class="form-group">
                    <label >Firstname
                         
                    </label>
                    <asp:TextBox ID="txtfirstname" runat="server" CssClass="form-control" Placeholder="Enter your Firstname" />
                   <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtfirstname"
                        ErrorMessage="Firstname is required" CssClass="text-danger"  ValidationGroup="add" Display="Dynamic" />
                </div>
            </div>
                 <div class="col-md-3">
                <div class="form-group">
                    <label >Lastname
                        
                    </label>
                    <asp:TextBox ID="txtlastname" runat="server" CssClass="form-control" Placeholder="Enter your Lastname" />
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtlastname"
                        ErrorMessage="Lastname is required" CssClass="text-danger"  ValidationGroup="add" Display="Dynamic" />
                  
                </div>
            </div>
                 <div class="col-md-3">
                <div class="form-group">
                    <label >Middle Name
                        
                    </label>
                    <asp:TextBox ID="txtmiddlename" runat="server" CssClass="form-control" Placeholder="Enter your Middle Name" />
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtmiddlename"
                        ErrorMessage="Middle Name is required" CssClass="text-danger"  ValidationGroup="add" Display="Dynamic" />
                  
                </div>
            </div>
        

            <!-- Date of Birth -->
            <div class="col-md-3">
                <div class="form-group">
                    <label >Date of Birth</label>
                    <asp:TextBox ID="DOB" runat="server" CssClass="form-control" TextMode="Date" Placeholder="yyyy-mm-dd" />
                    <asp:RequiredFieldValidator ID="rfvDOB" runat="server" ControlToValidate="DOB"
                        ErrorMessage="Date of Birth is required"  ValidationGroup="add" CssClass="text-danger" Display="Dynamic" />
                </div>
            </div>
                <div class="col-md-3">
                <div class="form-group">
                    <label>Sex</label>
                   <asp:DropDownList ID="DPSEX" runat="server" CssClass="form-control">
                        <asp:ListItem Text="-- Select Sex Type --" Value="" />
                        <asp:ListItem Text="MALE" Value="MALE" />
                        <asp:ListItem Text="FEMALE" Value="FEMALE" />
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="DPSEX"
                        ErrorMessage="Sex is required" InitialValue=""  ValidationGroup="add" CssClass="text-danger" Display="Dynamic" />
                </div>
            </div>
            <!-- Address -->
            <div class="col-md-9">
                <div class="form-group">
                    <label >Address</label>
                    <asp:TextBox ID="Address" runat="server" CssClass="form-control" Placeholder="Enter your complete address" />
                    <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ControlToValidate="Address"
                        ErrorMessage="Address is required" CssClass="text-danger"  ValidationGroup="add" Display="Dynamic" />
                </div>
            </div>

            <!-- Valid ID Type -->
            <div class="col-md-4">
                <div class="form-group">
                    <label >Valid ID Type</label>
                    <asp:DropDownList ID="ValidIDType" runat="server" CssClass="form-control">
                        <asp:ListItem Text="-- Select ID Type --" Value="" />
                        <asp:ListItem Text="UMID" Value="UMID" />
                        <asp:ListItem Text="GSIS" Value="GSIS" />
                        <asp:ListItem Text="SSS" Value="SSS" />
                        <asp:ListItem Text="Driver's License" Value="Driver's License" />
                        <asp:ListItem Text="PhilHealth" Value="PhilHealth" />
                        <asp:ListItem Text="Passport" Value="Passport" />
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvIDType" runat="server" ControlToValidate="ValidIDType"
                        InitialValue="" ErrorMessage="Valid ID Type is required"  ValidationGroup="add" CssClass="text-danger" Display="Dynamic" />
                </div>
            </div>

            <!-- Valid ID Number -->
            <div class="col-md-4">
                <div class="form-group">
                    <label >Valid ID Number</label>
                    <asp:TextBox ID="ValidID" runat="server" CssClass="form-control" Placeholder="Enter your ID number" />
                    <asp:RequiredFieldValidator ID="rfvValidID" runat="server" ControlToValidate="ValidID"
                        ErrorMessage="Valid ID number is required" CssClass="text-danger"  ValidationGroup="add" Display="Dynamic" />
                </div>
            </div>

            <!-- Upload Valid ID Image -->
            <div class="col-md-4">
                <div class="form-group">
                    <label>Upload Valid ID (Image)</label>
                    <asp:FileUpload ID="ValidIDImage" runat="server" CssClass="form-control-file" />
                    <asp:RequiredFieldValidator ID="rfvValidIDImage" runat="server" ControlToValidate="ValidIDImage"
                        ErrorMessage="Please upload a valid ID file" CssClass="text-danger"  ValidationGroup="add" Display="Dynamic" />
                </div>
            </div>
           <div  class="col-md-12">
               <asp:HiddenField ID="hdfilepath" runat="server" />
                  <asp:Image ID="imgID" runat="server" Width="100%" Visible="false" Height="180px" CssClass="img-fluid border rounded" />
               <img id="previewImg" style="width:100%; height:180px;" class="img-fluid border rounded" />
           </div>
            <!-- Purpose -->
            <div class="col-md-12">
                <div class="form-group">
                    <label>Purpose</label>
                    <asp:TextBox ID="Purpose" runat="server" CssClass="form-control" Placeholder="Enter purpose for clearance" />
                    <asp:RequiredFieldValidator ID="rfvPurpose" runat="server" ControlToValidate="Purpose"
                        ErrorMessage="Purpose is required" CssClass="text-danger"  ValidationGroup="add" Display="Dynamic" />
                </div>
            </div>
                                               
                                        </div>
                                                   </div>
                                              
                                            </div>
                                            <div class="modal-footer">
                                             
                                                <button type="button" class="btn btn-secondary" onclick="$('.modal').modal('hide');">Close</button>
                                                 
                                            <asp:Button ID="btnSubmit" ValidationGroup="add" runat="server" Text="Submit"  CssClass="btn btn-primary"  OnClick="btnSubmit_Click" />
                                                
                                            </div>

                                                </ContentTemplate>
                                               <Triggers>    <asp:PostBackTrigger ControlID="btnSubmit" />
                                               </Triggers>
                                        </asp:UpdatePanel>
                                        </div>
                                    </div>
                               </div>

    <div class="modal fade" id="policeClearanceModal"role="dialog" >
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header text-center">
        <h5 class="modal-title w-100" id="modalTitle">Police Clearance</h5>
        <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true">×</span></button>
      </div>
      <div class="modal-body" id="receiptContent">
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                          <ContentTemplate>
        <div class="border-box">

    <div class="text-center">
        <img src="Content/images/pnplogo.png" alt="Police Logo" style="height: 60px;" />
        <h5 class="mb-0">Republic of the Philippines</h5>
        <p class="mb-0">NATIONAL POLICE COMMISSION</p>
        <p class="mb-0">PHILIPPINE NATIONAL POLICE</p>
        <p class="mb-0">COTABATO CITY POLICE STATION</p>
        <p class="mb-0">ROSARY HEIGHTS MOTHER, COTABATO CITY, MAGUINDANAO DEL NORTE</p>
        <p>Date: <strong><%: DateTime.Now.ToString("MMMM dd, yyyy") %></strong></p>
    </div>

    <div class="section-title">POLICE CLEARANCE</div>

    <p><span class="info-label">Clearance No.:</span> <asp:Label ID="lblClearanceNo" runat="server" /> </p>
    <p><span class="info-label">Name:</span> <asp:Label ID="lblName" runat="server" /></p>
    <p><span class="info-label">Address:</span> <asp:Label ID="lblAddress" runat="server" /></p>
    <p><span class="info-label">Birth Date:</span> <asp:Label ID="lblDOB" runat="server" /></p>
    <p><span class="info-label">Birth Place:</span> <asp:Label ID="lblBirthPlace" runat="server" /></p>
    <p><span class="info-label">Sex:</span> <asp:Label ID="lblSex" runat="server" /></p>

    <p><span class="info-label">Purpose:</span> <asp:Label ID="lblPurpose" runat="server" /></p>
    
    <hr />

    <p class="text-center"><strong>No derogatory record on file as of this date.</strong></p>

    <hr />

    <p><span class="info-label">Issued at:</span> <asp:Label ID="lblIssuedAt" runat="server" /></p>
    <p><span class="info-label">Date Filed:</span> <asp:Label ID="lblDateFiled" runat="server" /></p>

    <div class="signature-block">
    <table style="width: 100%; border-collapse: collapse;">
    <tr>
        <!-- Prepared by - Left Column -->
        <td style="width: 50%; vertical-align: top; padding-right: 30px;">
            <p><strong>Prepared by:</strong></p>
            <p class="mb-0">__________________________</p>
            <p class="mb-0"><asp:Label ID="lblPreparedBy" runat="server" /></p>
            <p class="mb-2">Duty PNCO</p>
        </td>

        <!-- Approved by - Right Column -->
        <td style="width: 50%; vertical-align: top;">
            <p><strong>Approved by:</strong></p>
            <p class="mb-0">__________________________</p>
            <p class="mb-0"><asp:Label ID="lblApprovedBy" runat="server" /></p>
            <p>Officer-In-Charge</p>
        </td>
    </tr>
</table>
    </div>

</div>
             </ContentTemplate>
                                        </asp:UpdatePanel>
      </div>
      <div class="modal-footer justify-content-center">
        <button class="btn btn-secondary btn-sm" onclick="printModalContent('policeClearanceModal')">🖨️ Print</button>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
    function bindImagePreview() {
        var fileInput = document.getElementById('<%= ValidIDImage.ClientID %>');
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
