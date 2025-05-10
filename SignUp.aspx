<%@ Page Title="Sign-Up" Language="C#" MasterPageFile="~/SitePublic.Master" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="policeinfosys.SignUp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder_header" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder_body" runat="server">
    
     <div class="container mt-5">
           <div style="text-align:center"><h2>Sign-Up</h2></div> 
          <div class="form-group row">
        <div class="col-sm-4">
            <label class="form-label">First Name</label>
                <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" placeholder="Enter first name"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" ControlToValidate="txtFirstName" ErrorMessage="First name is required." CssClass="text-danger" Display="Dynamic"  ValidationGroup="add"></asp:RequiredFieldValidator>
            </div>
           <div class="col-sm-4">
                <label class="form-label">Last Name</label>
                <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" placeholder="Enter last name"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvLastName" runat="server" ControlToValidate="txtLastName" ErrorMessage="Last name is required." CssClass="text-danger" Display="Dynamic"  ValidationGroup="add"></asp:RequiredFieldValidator>
            </div>
              <div class="col-sm-4">
                <label class="form-label">Middle Name</label>
                <asp:TextBox ID="txtMiddleName" runat="server" CssClass="form-control" placeholder="Enter middle name"></asp:TextBox>
            </div>
      </div>
           
       <div class="form-group row">
            <div class="col-sm-4">
                <label class="form-label">Work/Position</label>
                 <asp:TextBox ID="txtPosition" runat="server" CssClass="form-control" placeholder="Enter Position"></asp:TextBox>
            </div>
           <div class="col-sm-4">
                <label class="form-label">Email</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="Enter email"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required." CssClass="text-danger" Display="Dynamic"  ValidationGroup="add"></asp:RequiredFieldValidator>
            </div>
            <div class="col-sm-4">
                <label class="form-label">Contact No</label>
                <asp:TextBox ID="txtContactNo" runat="server" CssClass="form-control" placeholder="Enter contact number"></asp:TextBox>
            </div>
           
        </div>
           <div class="form-group row">
            <div class="col-sm-12">
                <label class="form-label">Address</label>
                <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Enter address"></asp:TextBox>
            </div>
                
           </div>
            <div class="form-group row">
              <div class="col-sm-4">
                    <label class="form-label">Username</label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Enter username"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername" ErrorMessage="Username is required." CssClass="text-danger" Display="Dynamic"  ValidationGroup="add"></asp:RequiredFieldValidator>
                </div>
               <div class="col-sm-4">
                    <label class="form-label">Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="Password is required." CssClass="text-danger" Display="Dynamic"  ValidationGroup="add"></asp:RequiredFieldValidator>
                </div>
              <div class="col-sm-4">
                    <label class="form-label">Confirm Password</label>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Confirm password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword" ErrorMessage="Confirm password is required." CssClass="text-danger" Display="Dynamic"  ValidationGroup="add"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="cvPasswordMatch" runat="server" ControlToValidate="txtConfirmPassword" ControlToCompare="txtPassword" ErrorMessage="Passwords do not match." CssClass="text-danger" Display="Dynamic"  ValidationGroup="add"></asp:CompareValidator>
                </div>
            </div>
        <div style="text-align: center">
        <asp:Button ID="btnRegister" OnClick="btnRegister_Click" runat="server" Text="Submit" CssClass="btn btn-success" ValidationGroup="add" />
      </div>
    </div>
</asp:Content>
