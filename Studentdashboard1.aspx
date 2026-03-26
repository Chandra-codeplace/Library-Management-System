<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Studentdashboard1.aspx.cs" Inherits="WebApplication1.Studentdashboard1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Student Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            min-height: 100vh;
            background-color: #f8f9fa;
        }
        .sidebar {
            background: #343a40;
            padding-top: 20px;
            width: 250px;
            min-height: 100vh;
            position: fixed;
        }
        .sidebar a {
            color: #fff;
            display: block;
            padding: 10px 20px;
            text-decoration: none;
        }
        .sidebar a:hover {
            background: #495057;
        }
        .content {
            margin-left: 250px;
            padding: 20px;
        }
    </style>
</head>
<body>
<form id="form1" runat="server">
    <div class="sidebar">
        <a href="#Studentdashboard1.aspx"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
        <a href="studentbookrequest.aspx"><i class="fas fa-book"></i> Request Book</a>
        <a href="BorrowedBooks.aspx"><i class="fas fa-book-reader"></i> Borrowed Books</a>
        <a href="StudentLogout.aspx" class="text-danger"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>

    <div class="content">
        <nav class="navbar navbar-light bg-white shadow-sm mb-4 px-3">
            <span class="navbar-brand fw-bold">Welcome, <asp:Label ID="lblStudentName" runat="server"></asp:Label></span>
        </nav>

        <div class="row g-3 mb-4">
            <div class="col-md-6">
                <div class="card text-center h-100 shadow-sm">
                    <div class="card-header bg-info text-white"><h5>Total Borrowed Books</h5></div>
                    <div class="card-body">
                        <h1 class="display-4"><asp:Label ID="lblBorrowedCount" runat="server" Text="0"></asp:Label></h1>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card text-center h-100 shadow-sm">
                    <div class="card-header bg-warning text-dark"><h5>Pending Requests</h5></div>
                    <div class="card-body">
                        <h1 class="display-4"><asp:Label ID="lblPendingCount" runat="server" Text="0"></asp:Label></h1>
                    </div>
                </div>
            </div>
        </div>

        <%--<div id="requestBook" class="mt-5">
            <h4>Request a Book</h4>
            <asp:DropDownList ID="ddlBooks" runat="server" CssClass="form-select"></asp:DropDownList>
            <asp:Button ID="btnRequestBook" runat="server" Text="Request Book" CssClass="btn btn-primary mt-2" OnClick="btnRequestBook_Click" />
            <asp:Label ID="lblRequestStatus" runat="server" CssClass="text-success mt-2"></asp:Label>
        </div>--%>

        <%--<div id="borrowedBooks" class="mt-5">
            <h4>Your Borrowed Books</h4>
            <asp:GridView ID="gvBorrowedBooks" runat="server" CssClass="table table-bordered table-striped" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="BookTitle" HeaderText="Book Title" />
                    <asp:BoundField DataField="IssueDate" HeaderText="Issue Date" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:BoundField DataField="DueDate" HeaderText="Due Date" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:BoundField DataField="Status" HeaderText="Status" />
                </Columns>
            </asp:GridView>
        </div>--%>
    </div>
</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

