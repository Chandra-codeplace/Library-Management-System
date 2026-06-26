<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="WebApplication1.WebForm1" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CIME E-Library | Welcome</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        :root {
            --cime-blue: #004a99;
            --cime-yellow: #ffc107;
            --bg-gradient: linear-gradient(135deg, #e0eafc 0%, #cfdef3 100%);
            --card-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
        }

        body {
            font-family: 'Segoe UI', sans-serif;
            background: var(--bg-gradient);
            background-attachment: fixed;
            color: #2c3e50;
            margin: 0;
        }

        /* Header & Nav */
        header { background: white; padding: 20px 0; border-bottom: 6px solid var(--cime-yellow); box-shadow: 0 4px 20px rgba(0,0,0,0.1); }
        .header-logo img { max-height: 85px; }
        .header-title h1 { color: var(--cime-blue); font-weight: 800; font-size: 1.7rem; margin: 0; }
        .welcome-text { color: var(--cime-yellow); font-weight: 700; font-size: 1.3rem; text-transform: uppercase; letter-spacing: 1px; }

        .navbar { background-color: var(--cime-blue) !important; padding: 12px 0; }
        .nav-link { color: white !important; font-weight: 600; text-transform: uppercase; font-size: 0.85rem; margin: 0 10px; }
        .nav-link:hover { color: var(--cime-yellow) !important; }

        /* Row 1: Hero Section */
        .hero-card {
            background: rgba(255, 255, 255, 0.92);
            border-radius: 24px;
            padding: 40px;
            margin-top: 30px;
            box-shadow: var(--card-shadow);
            border: 1px solid rgba(255, 255, 255, 0.4);
        }
        .mission-title { color: var(--cime-blue); font-weight: 800; border-left: 6px solid var(--cime-yellow); padding-left: 15px; }
        .gate-img-wrapper { border-radius: 20px; overflow: hidden; box-shadow: var(--card-shadow); border: 5px solid white; }

        /* Row 2: Notice Board */
        .notice-card { border: 1px solid var(--cime-blue); border-radius: 12px; overflow: hidden; background: #fff; height: 100%; }
        .notice-header { display: flex; background: var(--cime-blue); }
        .tab-item { flex: 1; padding: 12px; text-align: center; font-weight: bold; color: white; border-right: 1px solid #ffffff33; }
        .tab-active { background: var(--cime-yellow); color: #000; }
        
        .notice-body { height: 320px; overflow-y: auto; padding: 15px; }
        .notice-row { display: flex; align-items: center; padding: 12px 0; border-bottom: 1px solid #eee; }
        
        .date-box { 
            width: 55px; border: 1px solid var(--cime-blue); border-radius: 5px; 
            text-align: center; margin-right: 15px; flex-shrink: 0; background: #fff;
        }
        .date-box .year { font-size: 9px; background: var(--cime-blue); color: white; }
        .date-box .day { font-size: 18px; font-weight: 800; color: #d9534f; line-height: 1.2; }
        .date-box .month { font-size: 10px; font-weight: bold; color: var(--cime-blue); text-transform: uppercase; }

        .notice-link { font-size: 14px; color: var(--cime-blue); text-decoration: none; font-weight: 500; flex-grow: 1; transition: 0.2s; }
        .notice-link:hover { text-decoration: underline; color: #003366; }

        /* Charts Section */
        .chart-card { 
            background: white; padding: 25px; border-radius: 15px; 
            box-shadow: var(--card-shadow); height: 100%; text-align: center;
            display: flex; flex-direction: column; align-items: center;
        }
        .chart-label { font-weight: 700; color: var(--cime-blue); margin-bottom: 15px; border-bottom: 2px solid var(--cime-yellow); display: inline-block; }
        .chart-container { position: relative; height: 220px; width: 100%; display: flex; justify-content: center; }

        footer { background: #111; color: #bbb; padding: 40px 0; margin-top: 60px; }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <header>
            <div class="container">
                <div class="row align-items-center text-center text-md-start">
                    <div class="col-md-2 mb-3 mb-md-0">
                        <div class="header-logo"><img src="cime_logo (2).png" alt="CIME Logo"></div>
                    </div>
                    <div class="col-md-10 text-md-end header-title">
                        <h1>College of IT & Management Education, Bhubaneswar</h1>
                        <span class="welcome-text"><i class="fas fa-book-reader me-2"></i> Welcome to E-Library</span>
                    </div>
                </div>
            </div>
        </header>

        <nav class="navbar navbar-expand-lg sticky-top shadow">
            <div class="container">
                <button class="navbar-toggler text-white border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <i class="fas fa-bars"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav mx-auto">
                        <li class="nav-item"><a class="nav-link" href="#about">About Us</a></li>
                        <li class="nav-item"><a class="nav-link" href="availablebook.aspx">Book List</a></li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navDrop" data-bs-toggle="dropdown">Login Portal</a>
                            <ul class="dropdown-menu shadow-lg border-0">
                                <li><a class="dropdown-item py-2" href="WebForm2.aspx"><i class="fas fa-user-shield me-2"></i>Admin Login</a></li>
                                <li><a class="dropdown-item py-2" href="Studentlogin.aspx"><i class="fas fa-user-graduate me-2"></i>Student Login</a></li>
                            </ul>
                        </li>
                        <li class="nav-item"><a class="nav-link" href="https://www.cime.ac.in" target="_blank">College Home</a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container">
            <div class="hero-card">
                <div class="row align-items-center">
                    <div class="col-lg-7 pe-lg-5">
                        <h2 class="mission-title mb-4">Our Mission</h2>
                        <p class="lead fw-bold text-primary mb-3">Creating a dynamic learning environment through technology and academic rigor.</p>
                        <p class="text-secondary">Our mission for the college's e-library system is to create an inclusive and dynamic learning environment through seamless integration of technology. By providing comprehensive access to digital resources, we aim to foster intellectual curiosity.</p>
                        <p class="text-secondary">The e-library system breaks traditional barriers, offering diverse and evolving collections that cater to the needs of our users. It is an essential tool for personal and academic growth.</p>
                    </div>
                    <div class="col-lg-5 mt-5 mt-lg-0">
                        <div class="gate-img-wrapper">
                            <img src="cime gate.jpg" alt="CIME Campus" class="img-fluid w-100 shadow-sm">
                        </div>
                    </div>
                </div>
            </div>

            <div class="row mt-5 g-4">
                <div class="col-lg-5">
                    <div class="notice-card shadow">
                        <div class="notice-header">
                            <div class="tab-item tab-active">Notice Board</div>
                            <div class="tab-item">News & Events</div>
                        </div>
                        <div class="notice-body">
                            <asp:Repeater ID="rptNotices" runat="server">  <%--it repeats a block of code for each row of database--%>
                                <ItemTemplate>
                                    <div class="notice-row">
                                        <div class="date-box shadow-sm">
                                            <div class="year"><%# Eval("date_added", "{0:yyyy}") %></div>
                                            <div class="day"><%# Eval("date_added", "{0:dd}") %></div>
                                            <div class="month"><%# Eval("date_added", "{0:MMM}") %></div>
                                        </div>
                                        <a href='<%# string.IsNullOrEmpty(Eval("pdf_file").ToString()) ? "#" : "UploadedNotices/" + Eval("pdf_file") %>' 
                                           target='<%# string.IsNullOrEmpty(Eval("pdf_file").ToString()) ? "_self" : "_blank" %>' 
                                           class="notice-link">
                                            <%# Eval("title") %>
                                        </a>
                                        <%# !string.IsNullOrEmpty(Eval("pdf_file").ToString()) ? "<i class='far fa-file-pdf text-danger fs-5 ms-2'></i>" : "" %>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </div>

                <div class="col-lg-7">
                    <div class="row g-4 h-100">
                        <div class="col-md-6">
                            <div class="chart-card">
                                <h6 class="chart-label">Books by Course</h6>
                                <div class="chart-container">
                                    <canvas id="courseChart"></canvas>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="chart-card">
                                <h6 class="chart-label">Live Availability</h6>
                                <div class="chart-container">
                                    <canvas id="availChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="noticeModal" tabindex="-1" aria-hidden="true">  <%--popup point--%>
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content border-0 shadow-lg" style="border-radius: 15px;">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title"><i class="fas fa-bullhorn me-2"></i>Latest Announcement</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body p-4 text-center">
                        <h4 id="popTitle" class="text-primary fw-bold"></h4>
                        <hr>
                        <p id="popContent" class="fs-5 text-secondary"></p>
                    </div>
                </div>
            </div>
        </div>

        <footer class="text-center">
            <div class="container">
                <p class="mb-1">© 2026 College of IT & Management Education, Bhubaneswar</p>
                <div class="small opacity-50">Constituent College of BPUT, Odisha</div>
            </div>
        </footer>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        var mba = <%= mba %>; var mca = <%= mca %>; var other = <%= other %>;
        var avail = <%= avail %>; var issued = <%= issued %>;

        // Fallback styling just in case the database is completely empty so the chart doesn't vanish
        var availData = (avail === 0 && issued === 0) ? [1] : [avail, issued];
        var availColors = (avail === 0 && issued === 0) ? ["#e9ecef"] : ["#28a745", "#dc3545"];
        var availLabels = (avail === 0 && issued === 0) ? ["No Data"] : ["Available", "Issued"];

        var courseData = (mba === 0 && mca === 0 && other === 0) ? [1] : [mba, mca, other];
        var courseColors = (mba === 0 && mca === 0 && other === 0) ? ["#e9ecef"] : ["#004a99", "#ffc107", "#28a745"];
        var courseLabels = (mba === 0 && mca === 0 && other === 0) ? ["No Data"] : ["MBA", "MCA", "Other"];

        window.onload = function () {
            var latestT = '<%= latestTitle %>';
            if (latestT !== "") {
                document.getElementById('popTitle').innerText = latestT;
                document.getElementById('popContent').innerText = '<%= latestContent %>';
                new bootstrap.Modal(document.getElementById('noticeModal')).show();
            }

            new Chart(document.getElementById("courseChart"), {
                type: 'pie',
                data: {
                    labels: courseLabels,
                    datasets: [{
                        data: courseData,
                        backgroundColor: courseColors
                    }]
                },
                options: {
                    maintainAspectRatio: false,
                    plugins: { legend: { position: 'bottom' } }
                }
            });

            new Chart(document.getElementById("availChart"), {
                type: 'doughnut',
                data: {
                    labels: availLabels,
                    datasets: [{
                        data: availData,
                        backgroundColor: availColors
                    }]
                },
                options: {
                    maintainAspectRatio: false,
                    plugins: { legend: { position: 'bottom' } }
                }
            });
        };
    </script>
</body>
</html>