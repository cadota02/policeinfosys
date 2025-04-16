<%@ Page Title="Home" Language="C#"  MasterPageFile="~/SiteAdmin.Master" EnableEventValidation="true" EnableViewState="true" CodeBehind="AdminHome.aspx.cs" Inherits="policeinfosys.Admin.AdminHome"  %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder_header" runat="server">
    <script src="Content/AdminLTE/plugins/chart.js/Chart.min.js"></script>
        <script src="Content/AdminLTE/customjs/dashboard.js"></script>
  <%-- <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>--%>
    <script>

        // countcomplaints
        $(document).ready(function () {
            $.ajax({
                url: 'ComplaintStats.ashx',
                method: 'GET',
                dataType: 'json',
                success: function (data) {
                    $('#<%= lblThisMonth.ClientID %>').text(data.ThisMonth);
                    $('#<%= lblLastMonth.ClientID %>').text(data.LastMonth);
                    $('#<%= lblPending.ClientID %>').text(data.Pending);
                    $('#<%= lblResolved.ClientID %>').text(data.Resolved);
                    $('#<%= lblActions.ClientID %>').text(data.ActionsTaken);
                     //$('#lblThisMonth').text(data.ThisMonth); <span id="lblLastMonth"></span>
                  },
                 error: function () {
                    console.error('Failed to load complaint stats.');
                     }
                });
        });
        $(document).ready(function () {
            $.getJSON('ClearanceStats.ashx', function (data) {
                $('#statPending').text(data.Pending);
                $('#statApproved').text(data.Approved);
                $('#statRejected').text(data.Rejected);
                $('#statReleased').text(data.Released);
            });
        });
    </script>
  <script>
      $(document).ready(function () {
          $.ajax({
              url: 'ClearanceAndComplaintsTrend.ashx',
              method: 'GET',
              dataType: 'json',
              success: function (data) {
                  var ctx = document.getElementById('trendChart').getContext('2d');
                  new Chart(ctx, {
                      type: 'line',
                      data: {
                          labels: data.labels,
                          datasets: [
                              {
                                  label: 'Complaints',
                                  data: data.complaints,
                                  borderColor: '#f39c12',
                                  backgroundColor: 'rgba(243, 156, 18, 0.2)',
                                  fill: true,
                                  tension: 0.4
                              },
                              {
                                  label: 'Clearances',
                                  data: data.clearances,
                                  borderColor: '#00c0ef',
                                  backgroundColor: 'rgba(0, 192, 239, 0.2)',
                                  fill: true,
                                  tension: 0.4
                              }
                          ]
                      },
                      options: {
                          responsive: true,
                          maintainAspectRatio: false,
                          plugins: {
                              legend: {
                                  display: true,
                                  position: 'bottom'
                              }
                          },
                          scales: {
                              y: {
                                  beginAtZero: true
                              }
                          }
                      }
                  });
              },
              error: function (xhr, status, error) {
                  console.error('Failed to load data:', error);
              }
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
        <h3><asp:Label ID="lblThisMonth"  ClientIDMode="Static" runat="server" Text="0" /></h3>
        <p>Complaints This Month
 
        </p>
      </div>
      <div class="icon"><i class="fas fa-calendar-alt"></i></div>
    </div>
  </div>

  <!-- Complaints Last Month -->
  <div class="col-lg-3 col-6" style="display:none;">
    <div class="small-box bg-secondary">
      <div class="inner">
        <h3><asp:Label ID="lblLastMonth"  ClientIDMode="Static" runat="server" Text="0" /></h3>
        <p>Complaints Last Month</p>
      </div>
      <div class="icon"><i class="fas fa-calendar-minus"></i></div>
    </div>
  </div>

  <!-- Pending Complaints -->
  <div class="col-lg-3 col-6">
    <div class="small-box bg-warning">
      <div class="inner">
        <h3><asp:Label ID="lblPending"  ClientIDMode="Static" runat="server" Text="0" /></h3>
        <p>Pending Complaints</p>
      </div>
      <div class="icon"><i class="fas fa-hourglass-half"></i></div>
    </div>
  </div>

  <!-- Resolved Complaints -->
  <div class="col-lg-3 col-6">
    <div class="small-box bg-success">
      <div class="inner">
        <h3><asp:Label ID="lblResolved"   ClientIDMode="Static" runat="server" Text="0" /></h3>
        <p>Resolved Complaints</p>
      </div>
      <div class="icon"><i class="fas fa-check-circle"></i></div>
    </div>
  </div>
          <!-- Actions Taken -->
  <div class="col-lg-3 col-6">
    <div class="small-box bg-primary">
      <div class="inner">
        <h3><asp:Label ID="lblActions"  ClientIDMode="Static" runat="server" Text="0" /></h3>
        <p>Total Complaint Actions</p>
      </div>
      <div class="icon"><i class="fas fa-tasks"></i></div>
    </div>
  </div>

     
  <div class="col-lg-3 col-6">
    <div class="small-box bg-warning">
      <div class="inner">
        <h3 id="statPending">0</h3>
        <p>Pending Clearance</p>
      </div>
      <div class="icon">
        <i class="fas fa-clock"></i>
      </div>
    </div>
  </div>

  <div class="col-lg-3 col-6">
    <div class="small-box bg-success">
      <div class="inner">
        <h3 id="statApproved">0</h3>
        <p>Approved Clearance</p>
      </div>
      <div class="icon">
        <i class="fas fa-thumbs-up"></i>
      </div>
    </div>
  </div>

  <div class="col-lg-3 col-6">
    <div class="small-box bg-danger">
      <div class="inner">
        <h3 id="statRejected">0</h3>
        <p>Rejected Clearance</p>
      </div>
      <div class="icon">
        <i class="fas fa-times-circle"></i>
      </div>
    </div>
  </div>

  <div class="col-lg-3 col-6">
    <div class="small-box bg-info">
      <div class="inner">
        <h3 id="statReleased">0</h3>
        <p>Released Clearance</p>
      </div>
      <div class="icon">
        <i class="fas fa-share-square"></i>
      </div>
    </div>
  </div>

      
        </div>
           <div class="row ">
            <div class="col-sm-4">
          <div class="card">
          <div class="card-header">
            <h3 class="card-title">Complaint Categories</h3>
          </div>
          

          <div class="card-body">
            <canvas id="pieChart" height="200"></canvas>
          </div>
        </div>
                </div>
             <div class="col-sm-8">
                <div class="card">
          <div class="card-header">
            <h3 class="card-title">Monthly Request Clearances & Complaints Trend</h3>
          </div>
          <div class="card-body">
            <canvas id="trendChart" height="200"></canvas>
          </div>
             </div>
        </div>
        </div>
         </div>
        </section>
    
</asp:Content>
