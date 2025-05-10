<%@ Page Title="PCL" Language="C#" MasterPageFile="~/SitePublic.Master" AutoEventWireup="true" CodeBehind="PoliceClearance.aspx.cs" Inherits="policeinfosys.PoliceClearance" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder_header" runat="server">
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
        var printWindow = window.open('', '_blank', 'width=300,height=600');

        printWindow.document.write(`
        <html>
            <head>
                <title>Print Receipt</title>
                <style>
                    @media print {
                        @page {
                            size: 80mm auto;
                            margin: 5mm;
                        }

                        body {
                            font-family: 'Courier New', Courier, monospace;
                            font-size: 11px;
                            width: 72mm;
                            margin: 0;
                        }

                        .receipt-header {
                            text-align: center;
                            font-weight: bold;
                            margin-bottom: 10px;
                        }

                        .receipt-line {
                            border-top: 1px dashed #000;
                            margin: 5px 0;
                        }

                        .receipt-item {
                            margin-bottom: 6px;
                        }

                        img {
                            max-width: 100%;
                        }
                    }
                </style>
            </head>
            <body>
                <div class="receipt-header">Police Information System</div>
                <div class="receipt-header">Application Receipt</div>
                <div class="receipt-line"></div>
                ${content}
                <div class="receipt-line"></div>
                <div style="text-align:center;">Thank you!</div>

                <script>
                    window.onload = function () {
                        window.print();
                        window.onafterprint = function () {
                            window.close();
                        };
                    };
                <\/script>
            </body>
        </html>
        `);

        printWindow.document.close();
    }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder_body" runat="server">
    <div class="container mt-3 ">
    <h4 class="text-center ">Police Clearance Application</h4>
        <hr />
        <asp:HiddenField ID="hd_clearanceno" runat="server" />
        <div class="row mt-1">
          <div class="row">
            <!-- Full Name -->
                 <div class="col-md-3">
                <div class="form-group">
                    <label >Firstname
                          <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtfirstname"
                        ErrorMessage="is required" CssClass="text-danger"  ValidationGroup="add" Display="Dynamic" />
                    </label>
                    <asp:TextBox ID="txtfirstname" runat="server" CssClass="form-control" Placeholder="Enter your Firstname" />
                  
                </div>
            </div>
                 <div class="col-md-3">
                <div class="form-group">
                    <label >Lastname
                          <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtlastname"
                        ErrorMessage="is required" CssClass="text-danger"  ValidationGroup="add" Display="Dynamic" />
                    </label>
                    <asp:TextBox ID="txtlastname" runat="server" CssClass="form-control" Placeholder="Enter your Lastname" />
                  
                </div>
            </div>
                 <div class="col-md-3">
                <div class="form-group">
                    <label >Middle Name
                          <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtmiddlename"
                        ErrorMessage="is required" CssClass="text-danger"  ValidationGroup="add" Display="Dynamic" />
                    </label>
                    <asp:TextBox ID="txtmiddlename" runat="server" CssClass="form-control" Placeholder="Enter your Middle Name" />
                  
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
                <div class="col-md-2">
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
            <div class="col-md-10">
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
                    <label>Upload Valid ID (Image/PDF)</label>
                    <asp:FileUpload ID="ValidIDImage" runat="server" CssClass="form-control-file" />
                    <asp:RequiredFieldValidator ID="rfvValidIDImage" runat="server" ControlToValidate="ValidIDImage"
                        ErrorMessage="Please upload a valid ID file" CssClass="text-danger"  ValidationGroup="add" Display="Dynamic" />
                </div>
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
             <div class="container text-center">
                 <hr />
  <h5>Register a new account or fill in your existing account details:</h5>
                   <hr />
    <div class="row justify-content-center">
        <div class="col-md-4">
            <div class="form-group text-left">
                <label>Username
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtusername"
                        ErrorMessage="is required" CssClass="text-danger" ValidationGroup="add" Display="Dynamic" />
                </label>
                <asp:TextBox ID="txtusername" runat="server" CssClass="form-control" Placeholder="Enter your Username" />
            </div>
        </div>

        <div class="col-md-4">
            <div class="form-group text-left">
                <label>Password
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtpassword"
                        ErrorMessage="is required" CssClass="text-danger" ValidationGroup="add" Display="Dynamic" />
                </label>
                <asp:TextBox ID="txtpassword" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Enter your Password" />
            </div>
        </div>

        <div class="col-md-4">
            <div class="form-group text-left">
                <label>Confirm Password
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtconfirmpass"
                        ErrorMessage="is required" CssClass="text-danger" ValidationGroup="add" Display="Dynamic" />
                </label>
                <asp:TextBox ID="txtconfirmpass" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Confirm your Password" />
            <asp:CompareValidator ID="CompareValidator1" runat="server"
            ControlToCompare="txtpassword"
            ControlToValidate="txtconfirmpass"
            Operator="Equal"
            Type="String"
            ErrorMessage="Confirm password do not match."
            CssClass="text-danger"
            ValidationGroup="add"
            Display="Dynamic" />
                </div>
        </div>
    </div>
</div>
            <!-- Submit Button -->
            <div class="col-md-12 text-center">
                <asp:Button ID="SubmitBtn" runat="server" CssClass="btn btn-primary" Text="Submit" OnClick="SubmitBtn_Click" ValidationGroup="add" />
              <asp:Button ID="btnPrint" runat="server" CssClass="btn btn-secondary" Text="Print Receipt" OnClick="btnPrint_Click" Visible="False" />
            </div>
        </div>

    <!-- Message + Print Button -->
  
    <div class="text-center mt-2">
          <asp:Label ID="lblMessage" runat="server" CssClass="text-success text-center mt-2" Visible="False" /> <br />
      
    </div>
            </div>
</div>

    <!-- Print Modal -->
<div class="modal fade" id="printModal" role="dialog">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">

      <div class="modal-header">
        <h5 class="modal-title">Police Clearance Receipt</h5>
       <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true">×</span></button>
      </div>

      <div class="modal-body">
        <asp:Panel ID="pnlReceipt" runat="server">
            
                      <div class="text-center">
          <p><strong>Clearance No:</strong> <asp:Label ID="lblClearanceNo" runat="server" /></p>
          <p><strong>Name:</strong> <asp:Label ID="lblPrintFullName" runat="server" /></p>
          <p><strong>Date of Birth:</strong> <asp:Label ID="lblPrintDOB" runat="server" /></p>
          <p><strong>Address:</strong> <asp:Label ID="lblPrintAddress" runat="server" /></p>
          <p><strong>Valid ID Type:</strong> <asp:Label ID="lblPrintIDType" runat="server" /></p>
          <p><strong>Valid ID No:</strong> <asp:Label ID="lblPrintValidID" runat="server" /></p>
          <p><strong>Purpose:</strong> <asp:Label ID="lblPrintPurpose" runat="server" /></p>
          <p><strong>Date Filed:</strong> <asp:Label ID="lblPrintDateFiled" runat="server" /></p>
              <p><strong>Status:</strong> Pending (For review)</p>
                          </div>
        </asp:Panel>
      </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal" aria-label="Close">Close</button>
        <button type="button" class="btn btn-primary" onclick="printModalContent('printModal')">Print</button>
      </div>

    </div>
  </div>
</div>
</asp:Content>
