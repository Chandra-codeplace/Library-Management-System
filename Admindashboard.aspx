<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admindashboard.aspx.cs" Inherits="WebApplication1.Admindashboard" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <title>Library Admin Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />

    <style>
        :root {
            --bg: #f7f9fb; --text: #232937; --sidebar: #343a40; --sidebar-hover: #495057;
            --cyan: #00c3ed; --amber: #ffd51e; --green: #28a745;
        }
        body { background: var(--bg); color: var(--text); font-family: 'Segoe UI', Tahoma, sans-serif; }

        /* Sidebar - Exact same as provided */
        .sidebar {
            width: 250px; min-height: 100vh; position: fixed; left: 0; top: 0;
            background: var(--sidebar); padding: 20px 0; z-index: 1000;
        }
        .sidebar a {
            text-decoration: none; display: block; padding: 12px 22px;
            color: #e9ecef; font-size: 15px; transition: .2s;
        }
        .sidebar a:hover { background: var(--sidebar-hover); color: #fff; }
        .sidebar a i { width: 25px; margin-right: 10px; }

        /* Content Adjustment */
        .main-wrapper { margin-left: 250px; width: calc(100% - 250px); }
        .content { padding: 30px; }

        /* Navbar Style */
        .navbar {
            background: #fff !important; box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            padding: 15px 30px; margin-bottom: 30px;
        }
        .navbar-brand { font-weight: 700; color: var(--text) !important; }

        /* Dashboard Cards */
        .card { 
            border: none; border-radius: 12px; transition: transform 0.3s; 
            box-shadow: 0 4px 15px rgba(0,0,0,0.05); 
        }
        .card:hover { transform: translateY(-5px); }
        .card-header { border: none; padding: 15px; font-weight: 600; }
        .card-header a { color: inherit; text-decoration: none; }
        .card-header a:hover { text-decoration: underline; }
        
        .card-body { padding: 30px 20px; }
        .display-4 { font-size: 3rem; font-weight: 800; }

        /* Category Colors */
        .bg-cyan { background-color: var(--cyan) !important; color: white; }
        .bg-amber { background-color: var(--amber) !important; color: var(--text); }
        .bg-green { background-color: var(--green) !important; color: white; }

        @media (max-width: 991px) {
            .sidebar { width: 70px; }
            .sidebar a span { display: none; }
            .main-wrapper { margin-left: 70px; width: calc(100% - 70px); }
        }
    </style>
</head>
<body>
<form runat="server">
    <div class="sidebar">
        <div class="px-4 mb-4 text-white"><h4>LMS Admin</h4></div>
        <a href="Admindashboard.aspx"><i class="fas fa-tachometer-alt"></i> <span>Dashboard</span></a>
        <a href="AddAdmin.aspx"><i class="fas fa-user-shield"></i> <span>Add Admin</span></a>
        <a href="AddStudent.aspx"><i class="fas fa-user-plus"></i> <span>Add Student</span></a>
        <a href="AddBook.aspx"><i class="fas fa-book"></i> <span>Add Book</span></a>
        <a href="availablebook.aspx"><i class="fas fa-book-open"></i> <span>Available Books</span></a>
        <a href="adminbookreqandissue.aspx"><i class="fas fa-exchange-alt"></i> <span>Book Requests</span></a>
        <a href="OverdueBooks.aspx"><i class="fas fa-clock"></i> <span>Overdue Books</span></a>
        <a href="TrackBooks.aspx"><i class="fas fa-search"></i> <span>Track Status</span></a>
        <a href="AddNotice.aspx"><i class="fa-solid fa-circle-exclamation"></i> <span>Add Notice</span></a>
        <asp:LinkButton ID="btnLog" runat="server" OnClick="btnLogout_Click" CssClass="text-danger mt-5">
            <i class="fas fa-sign-out-alt"></i> <span>Logout</span>
        </asp:LinkButton>
    </div>

    <div class="main-wrapper">
        <nav class="navbar navbar-light">
            <span class="navbar-brand">
                <i class="fas fa-bars me-3 d-lg-none"></i>
                Hello, <asp:Label ID="lblAdminName" runat="server" Text="Admin"></asp:Label>
            </span>
        </nav>

        <div class="content">
            <h2 class="mb-4">Admin Overview</h2>
            
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="card text-center h-100">
                        <div class="card-header bg-cyan">
                            <a href="ViewStudents.aspx"><h5 class="m-0">Total Students</h5></a>
                        </div>
                        <div class="card-body">
                            <asp:Label ID="lblTotalStudents" runat="server" Text="0" CssClass="display-4"></asp:Label>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card text-center h-100">
                        <div class="card-header bg-amber">
                            <a href="gridview.aspx"><h5 class="m-0">Total Books</h5></a>
                        </div>
                        <div class="card-body">
                            <asp:Label ID="lblTotalBooks" runat="server" Text="0" CssClass="display-4"></asp:Label>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card text-center h-100">
                        <div class="card-header bg-green">
                            <h5 class="m-0">Issued Books</h5>
                        </div>
                        <div class="card-body">
                            <asp:Label ID="lblIssuedBooks" runat="server" Text="0" CssClass="display-4"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>
</body>
</html>