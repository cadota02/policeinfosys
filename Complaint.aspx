<%@ Page Title="Complaint" Language="C#" MasterPageFile="~/SitePublic.Master" AutoEventWireup="true" CodeBehind="Complaint.aspx.cs" Inherits="policeinfosys.Complaint" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder_header" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder_body" runat="server">

     <div class="container mt-5">
            <h2>Complaint Form</h2>
          

            <div class="form-group row">
                <div class="col-sm-6">
                <label>Full Name</label>
                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" Placeholder="Enter your full name"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvFullName" runat="server" ControlToValidate="txtFullName" ErrorMessage="Full Name is required." CssClass="text-danger" Display="Dynamic" />
               </div>
                <div class="col-sm-6">
                <label>Contact</label>
                <asp:TextBox ID="txtContact" runat="server" CssClass="form-control" Placeholder="Enter contact number/email"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvContact" runat="server" ControlToValidate="txtContact" ErrorMessage="Contact is required." CssClass="text-danger" Display="Dynamic" />
                 </div>
          </div>
            <div class="form-group row">
                <div class="col-sm-6">
                <label>Place of Occurrence</label>
                <asp:TextBox ID="txtPlace" runat="server" CssClass="form-control" Placeholder="Where did it happen?"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPlace" runat="server" ControlToValidate="txtPlace" ErrorMessage="Place is required." CssClass="text-danger" Display="Dynamic" />
             </div>
              <div class="col-sm-6">
                <label>Category</label>
                <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ControlToValidate="ddlCategory" InitialValue="" ErrorMessage="Category is required." CssClass="text-danger" Display="Dynamic" />
             </div>
          </div>

            <div class="form-group">
                <label>Brief Details</label>
                <asp:TextBox ID="txtDetails" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" Placeholder="Describe the incident..."></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvDetails" runat="server" ControlToValidate="txtDetails" ErrorMessage="Description is required." CssClass="text-danger" Display="Dynamic" />
            </div>


            <div class="form-group">
                <label>Evidence Image (optional)</label>
                <asp:FileUpload ID="fuEvidence" runat="server" CssClass="form-control-file" />
            </div>
             <div class="text-center">
            <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" Text="Submit Complaint" OnClick="btnSubmit_Click" />
             </div>
        </div>
</asp:Content>
