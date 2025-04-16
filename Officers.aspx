<%@ Page Title="Officers" Language="C#" MasterPageFile="~/SitePublic.Master" AutoEventWireup="true" CodeBehind="Officers.aspx.cs" Inherits="policeinfosys.Officers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder_header" runat="server">
     <div class="content-header">
      <div class="container">
        <div class="row mb-2">
                <div class="col-sm-6">
                 <h3> Officers</h3> 
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="Home">Home</a></li>
                        <li class="breadcrumb-item active">Officers</li>
                    </ol>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder_body" runat="server">
    
    <div class="container">
    <section class="content">

    <div class="card card-solid">
      <div class="card-body pb-0">
        <div class="row d-flex align-items-stretch">

          <asp:Repeater ID="rptOfficers" runat="server">
            <ItemTemplate>
               <div class="col-12 col-sm-6 col-md-4 d-flex align-items-stretch">
              <div class="card bg-light">
                <div class="card-header text-muted border-bottom-0">
                    <%# Eval("Position") %> |    <%# Eval("PRank") %>
                  </div>
                  <div class="card-body pt-0">
                    <div class="row">
                      <div class="col-7">
                        <h2 class="lead"><b><%# Eval("FirstName") %> <%# Eval("LastName") %></b></h2>
                        <p class="text-muted text-sm"><b>About: </b><%# Eval("Content") %> </p>
                        <ul class="ml-4 mb-0 fa-ul text-muted">
                          <li class="small"><span class="fa-li"><i class="fas fa-lg fa-building"></i></span> Address: <%# Eval("Address") %></li>
                          <li class="small"><span class="fa-li"><i class="fas fa-lg fa-phone"></i></span> Phone #: <%# Eval("ContactNo") %></li>
                        </ul>
                      </div>
                      <div class="col-5 text-center">
                        <img src='<%# Eval("ImagePath").ToString().Substring(2) %>' style="height:115px; width:115px" alt="" class="img-circle img-fluid">
                      </div>
                    </div>
                  </div>
                 <%-- <div class="card-footer">
                    <div class="text-right">
                      <a href="mailto:<%# Eval("Email") %>" class="btn btn-sm bg-teal">
                        <i class="fas fa-envelope"></i>
                      </a>
                      <a href="#" class="btn btn-sm btn-primary">
                        <i class="fas fa-user"></i> View Profile
                      </a>
                    </div>
                  </div>--%>
                </div>
              </div>
            </ItemTemplate>
          </asp:Repeater>

        </div>
      </div>
    
     </div>
  </section>
        </div>
</asp:Content>
