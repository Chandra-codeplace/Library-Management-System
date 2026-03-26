<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddStudent.aspx.cs" Inherits="WebApplication1.AddStudent" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Student</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">   
    <style>
        /* General Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            display: flex;
            background-color: #f4f4f9;
        }

        /* Sidebar */
        .sidebar {
            width: 250px;
            background-color: #343a40;
            color: white;
            height: 100vh;
            padding: 20px;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
        }

        .sidebar a {
            color: white;
            text-decoration: none;
            display: block;
            padding: 10px;
            font-size: 16px;
           
           /* border-radius: 5px;
            transition: background-color 0.3s;*/
        }

        .sidebar a:hover {
           background-color: #495057;
           border-radius: 5px;
        }

        /* Main Content */
        .main-content {
            flex-grow: 1;
            padding: 40px;
        }

        .main-content h1 {
            margin-bottom: 20px;
            color: #2c3e50;
            font-size: 2rem;
        }

        /* Form Container */
        .form-container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 0 auto;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
            transition: border-color 0.3s;
        }

        .form-group input:focus {
            border-color: #2c3e50;
            outline: none;
        }

        .form-group button {
            width: 100%;
            padding: 12px;
            background-color: #2c3e50;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .form-group button:hover {
            background-color: #34495e;
        }
        .message {
           display: block;
           margin-top: 10px;
           font-size: 1rem;
           font-weight: bold;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
   <%-- <div class="sidebar">
        
            <a href="Admindashboard.aspx"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
            <a href="AddStudent.aspx"><i class="fas fa-user-plus"></i> Add Student</a>
            <a href="AddBook.aspx"><i class="fas fa-book"></i> Add Book</a>
            <a href="AddBook.aspx"><i class="fas fa-book"></i> Available Books</a>
            <a href="ManageRequests.aspx"><i class="fas fa-list"></i> Book Requests</a>
            <a href="OverdueBooks.aspx"><i class="fas fa-exclamation-circle"></i> Overdue Books</a>
            <a href="IssueBook.aspx"><i class="fas fa-hand-holding"></i> Grant Issue Book</a>
            <a href="TrackBook.aspx"><i class="fas fa-search"></i> Track Book Status</a>
            <a href="adminlogout.aspx" class="text-danger"><i class="fas fa-sign-out-alt"></i> Logout</a>
     </div>--%>

    <!-- Main Content -->
    <!-- Main Content -->
<div class="main-content">
    <h1>Add Student:</h1>
    <div class="form-container">
        <form id="form1" runat="server">
            <div class="form-group">
                <label for="sid">Student ID</label>
                <input type="text" id="sid" name="sid" required>
            </div>
            <div class="form-group">
                <label for="sname">Student Name</label>
                <input type="text" id="sname" name="sname" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label for="scon_num">Contact Number</label>
                <input type="number" id="scon_num" name="scon_num" required>
            </div>
            <div class="form-group">
                <label for="address">Address</label>
                <input type="text" id="address" name="address" required>
            </div>
            <div class="form-group">
                <asp:Button ID="btnAddStudent" runat="server" Text="Add Student" OnClick="btnAddStudent_Click" CssClass="btn btn-primary" />
            </div>
            <div class="form-group">
                <asp:Label ID="lblMessage" runat="server" Text="" CssClass="message"></asp:Label>
            </div>
        </form>
    </div>
</div>
</body>
</html>