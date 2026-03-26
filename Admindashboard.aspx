<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admindashboard.aspx.cs" Inherits="WebApplication1.Admindashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Library Admin Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!-- Bootstrap + Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />

    <style>
        :root{
          --bg:#f7f9fb; --text:#232937; --sidebar:#343a40; --sidebar-hover:#495057;
          --cyan:#00c3ed; --amber:#ffd51e; --green:#28a745;
        }
        html,body{height:100%;}
        body{ background:var(--bg); color:var(--text); margin:0; font-family:system-ui,-apple-system,"Segoe UI",Roboto,"Helvetica Neue",Arial,"Noto Sans",sans-serif; }

        /* Sidebar */
        .sidebar{
          width:250px; min-height:100vh; position:fixed; inset:0 auto 0 0;
          background:var(--sidebar); padding:20px 0; box-shadow:2px 0 12px rgba(0,0,0,.06);
        }
        .sidebar a{
          text-decoration:none; display:block; padding:12px 22px;
          color:#e9ecef; font-size:16px; transition:.15s ease;
        }
        .sidebar a:hover{ background:var(--sidebar-hover); color:#fff; }
        .sidebar a i{ width:22px; margin-right:10px; }

        /* Content */
        .content{ margin-left:270px; padding:24px 28px; }

        /* Hide stray top text above form (prevents small artifacts) */
        body > *:first-child:not(form){ display:none; }

        /* Welcome bar */
        .navbar{
          border-radius:10px; background:#fff !important; box-shadow:0 2px 12px rgba(0,0,0,.06)!important; margin-bottom:18px;
        }
        .navbar .navbar-brand{ font-weight:700; color:var(--text); }

        /* Heading */
        h2{ font-size:22px; font-weight:700; margin:6px 0 12px 2px; }

        /* Metrics: 3 tiles fill width; first two are wide like student dashboard */
        .metrics{ display:flex; flex-wrap:wrap; gap:16px; }
        .tile{ flex:1 1 100%; }          /* default stack on small screens */
        @media (min-width:992px){
          .tile.wide{ flex:1 1 calc(50% - 8px); }   /* two wide tiles like student */
          .tile.narrow{ flex:1 1 calc(50% - 8px); } /* third tile shares the row; adjust as needed */
        }

        /* Cards / tiles */
        .card{ border:none; border-radius:12px; overflow:hidden; background:#fff; box-shadow:0 2px 14px rgba(0,0,0,.06); }
        .card .card-header{ border:none; padding:14px 16px; }
        .card .card-body{ padding:22px 18px; }
        .card-header.bg-info{ background: var(--cyan) !important; color:#fff; }
        .card-header.bg-warning{ background: var(--amber) !important; color:#232937; }
        .card-header.bg-success{ background: var(--green) !important; color:#fff; }
        .display-4{ font-size:42px; font-weight:800; margin:0; line-height:1; }

        /* Link inside header */
        .card-header a{ color:inherit; text-decoration:none; }
        .card-header a:hover{ text-decoration:underline; }

        /* Hide pending tile by CSS only (keeps server IDs intact) */
        .pending-tile{ display:none !important; }

        /* Mobile */
        @media (max-width:991.98px){
          .content{ margin-left:0; padding:18px; }
          .navbar{ border-radius:8px; }
        }
    </style>
</head>
<body>
<form runat="server">
    <!-- Welcome bar -->
    <nav class="navbar navbar-expand-lg navbar-light px-3">
        <a class="navbar-brand" href="#">
            Welcome, <asp:Label ID="lblAdminName" runat="server" Text="Admin"></asp:Label>
        </a>
    </nav>

    <div class="d-flex">
        <!-- Sidebar -->
        <div class="sidebar">
            <a href="#"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
            <a href="AddStudent.aspx"><i class="fas fa-user-plus"></i> Add Student</a>
            <a href="AddBook.aspx"><i class="fas fa-book"></i> Add Book</a>
            <a href="availablebook.aspx"><i class="fas fa-book"></i> Available Books</a>
            <a href="adminbookreqandissue.aspx"><i class="fas fa-list"></i> Book Requests &amp; Issue</a>
            <a href="OverdueBooks.aspx"><i class="fas fa-exclamation-circle"></i> Overdue Books</a>
            <%--<a href="IssueBook.aspx"><i class="fas fa-hand-holding"></i> Grant Issue Book</a>--%>
            <a href="TrackBooks.aspx"><i class="fas fa-search"></i> Track Book Status</a>
            <a href="adminlogout.aspx" class="text-danger"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>

        <!-- Main Content -->
        <div class="content">
            <h2>Welcome, <asp:Label ID="lblAdminNameContent" runat="server" Text="Admin"></asp:Label></h2>

            <!-- Metrics: first two wide tiles mimic student dashboard -->
            <div class="metrics">
                <!-- Wide tile 1 -->
                <div class="tile wide">
                    <div class="card text-center">
                        <div class="card-header bg-info text-white"><h5 class="m-0">Total Students</h5></div>
                        <div class="card-body">
                            <asp:Label ID="lblTotalStudents" runat="server" Text="0" CssClass="display-4 fw-bold"></asp:Label>
                        </div>
                    </div>
                </div>

                <!-- Wide tile 2 -->
                <div class="tile wide">
                    <div class="card text-center">
                        <div class="card-header bg-warning text-dark">
                            <a href="gridview.aspx"><h5 class="m-0">Total Books</h5></a>
                        </div>
                        <div class="card-body">
                            <asp:Label ID="lblTotalBooks" runat="server" Text="0" CssClass="display-4 fw-bold"></asp:Label>
                        </div>
                    </div>
                </div>

                <!-- Third tile (narrow but shares row width evenly on desktop) -->
                <div class="tile narrow">
                    <div class="card text-center">
                        <div class="card-header bg-success text-white"><h5 class="m-0">Issued Books</h5></div>
                        <div class="card-body">
                            <asp:Label ID="lblIssuedBooks" runat="server" Text="0" CssClass="display-4 fw-bold"></asp:Label>
                        </div>
                    </div>
                </div>

                <!-- Keep pending tile but hide via CSS (no code-behind change needed) -->
                <div class="tile pending-tile">
                    <div class="card text-center">
                        <div class="card-header bg-info text-white"><h5 class="m-0">Pending Requests</h5></div>
                        <div class="card-body">
                            <asp:Label ID="lblPendingRequests" runat="server" Text="0" CssClass="display-4 fw-bold"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
        </div> <!-- /content -->
    </div> <!-- /d-flex -->
</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
