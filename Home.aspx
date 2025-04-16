<%@ Page Title="Home" Language="C#" MasterPageFile="~/SitePublic.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="policeinfosys.Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder_header" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder_body" runat="server">
      <div class="container mt-5">
        <h2 class="text-center mb-3">Welcome to Police Information System</h2>
        <p class="text-center text-muted">Securing your community, one report at a time.</p>

        <div class="row mt-4">
            <!-- Column 1 -->
            <div class="col-md-4">
                <div class="card shadow">
                    <img src="content/images/banner/crime1.jpg" class="card-img-top" alt="Crime Report">
                    <div class="card-body text-center">
                        <h5 class="card-title">View Crime Reports</h5>
                        <p class="card-text">Stay informed with the latest crime activities.</p>
                        <a href="CrimeReports.aspx" class="btn btn-primary">View Reports</a>
                    </div>
                </div>
            </div>

            <!-- Column 2 -->
            <div class="col-md-4">
                <div class="card shadow">
                    <img src="content/images/banner/officer1.jpg" class="card-img-top" alt="Officers">
                    <div class="card-body text-center">
                        <h5 class="card-title">Police Officers</h5>
                        <p class="card-text">Meet the officers assigned to your area.</p>
                        <a href="Officers" class="btn btn-success">View Officers</a>
                    </div>
                </div>
            </div>

            <!-- Column 3 -->
            <div class="col-md-4">
                <div class="card shadow">
                    <img src="content/images/banner/crime2.jpg" class="card-img-top" alt="Crime Details">
                    <div class="card-body text-center">
                        <h5 class="card-title">Crime Details</h5>
                        <p class="card-text">Get detailed insights about specific incidents.</p>
                        <a href="CrimeDetails.aspx" class="btn btn-danger">View Details</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
