<%@ Page Title="Home" Language="C#"  MasterPageFile="~/SiteAdmin.Master"
     EnableEventValidation="true" EnableViewState="true"
    CodeBehind="AdminHome.aspx.cs" Inherits="policeinfosys.Admin.AdminHome"  %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder_header" runat="server">
   <%-- <script src=".../Content/AdminLTE/plugins/chart.js/Chart.min.js"></script>--%>
   <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script type="text/javascript">
    Sys.Application.add_load(function () {
        PageMethods.GetComplaintCategoryData(function (result) {
            const data = JSON.parse(result);
            const labels = data.map(item => item.category);
            const counts = data.map(item => item.total);

            new Chart(document.getElementById("pieChart"), {
                type: 'pie',
                data: {
                    labels: labels,
                    datasets: [{
                        label: "Complaints by Category",
                        data: counts,
                        backgroundColor: [
                            '#007bff', '#dc3545', '#ffc107', '#28a745', '#6f42c1'
                        ]
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false
                }
            });
        }, function (error) {
            console.error("WebMethod Error:", error);
        });
    });
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder_body" runat="server">
    <section class="content">
     <div class="container mt-5">
    <div class="row">
  <!-- Total Complaints This Month -->
  <div class="col-lg-3 col-6">
    <div class="small-box bg-info">
      <div class="inner">
        <h3><asp:Label ID="lblThisMonth" runat="server" Text="0" /></h3>
        <p>Complaints This Month</p>
      </div>
      <div class="icon"><i class="fas fa-calendar-alt"></i></div>
    </div>
  </div>

  <!-- Complaints Last Month -->
  <div class="col-lg-3 col-6">
    <div class="small-box bg-secondary">
      <div class="inner">
        <h3><asp:Label ID="lblLastMonth" runat="server" Text="0" /></h3>
        <p>Complaints Last Month</p>
      </div>
      <div class="icon"><i class="fas fa-calendar-minus"></i></div>
    </div>
  </div>

  <!-- Pending Complaints -->
  <div class="col-lg-3 col-6">
    <div class="small-box bg-warning">
      <div class="inner">
        <h3><asp:Label ID="lblPending" runat="server" Text="0" /></h3>
        <p>Pending Complaints</p>
      </div>
      <div class="icon"><i class="fas fa-hourglass-half"></i></div>
    </div>
  </div>

  <!-- Resolved Complaints -->
  <div class="col-lg-3 col-6">
    <div class="small-box bg-success">
      <div class="inner">
        <h3><asp:Label ID="lblResolved" runat="server" Text="0" /></h3>
        <p>Resolved Complaints</p>
      </div>
      <div class="icon"><i class="fas fa-check-circle"></i></div>
    </div>
  </div>

  <!-- Actions Taken -->
  <div class="col-lg-3 col-6">
    <div class="small-box bg-primary">
      <div class="inner">
        <h3><asp:Label ID="lblActions" runat="server" Text="0" /></h3>
        <p>Total Complaint Actions</p>
      </div>
      <div class="icon"><i class="fas fa-tasks"></i></div>
    </div>
  </div>
        <div class="card">
  <div class="card-header">
    <h3 class="card-title">Complaint Categories</h3>
  </div>
  <div class="card-body">
    <canvas id="pieChart" height="200"></canvas>
  </div>
</div>
</div>
         </div>
        </section>
    
</asp:Content>
