<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddAdmin.aspx.cs" Inherits="WebApplication1.AddAdmin" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Admin</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f0f2f5; /* Light gray background from screenshot */
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 20px;
        }

        h1 {
            font-size: 28px;
            color: #333;
            margin-bottom: 20px;
            font-weight: 500;
        }

        /* Centered White Card */
        .form-card {
            background-color: #ffffff;
            width: 100%;
            max-width: 450px;
            margin: 40px auto;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-group label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: #333;
            margin-bottom: 6px;
        }

        /* Input styling matching the screenshot */
        .custom-input {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #e1e5ee;
            border-radius: 5px;
            background-color: #f0f4ff; /* Light blueish tint for inputs */
            font-size: 14px;
            color: #333;
            outline: none;
        }

        .custom-input:focus {
            border-color: #007bff;
            background-color: #fff;
        }

        /* Gender Radio List Styling */
        .gender-container {
            display: flex;
            gap: 15px;
            padding: 5px 0;
        }
        .gender-container label {
            font-weight: normal;
            font-size: 14px;
            margin-left: 5px;
        }

        /* File Upload Styling */
        .file-upload {
            background-color: #f0f4ff;
            border: 1px dashed #ced4da;
            padding: 8px;
            border-radius: 5px;
            font-size: 13px;
        }

        /* Primary Button - Exact Blue */
        .btn-submit {
            width: 100%;
            background-color: #1a73e8; /* Blue from screenshot */
            color: white;
            padding: 12px;
            border: none;
            border-radius: 5px;
            font-size: 15px;
            font-weight: 500;
            cursor: pointer;
            margin-top: 10px;
            transition: background 0.2s;
        }

        .btn-submit:hover {
            background-color: #1557b0;
        }

        .message-label {
            display: block;
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
        }
    </style>
</head>
<body>

    <h1>Add Admin:</h1>

    <div class="form-card">
        <form id="form1" runat="server">
            
            <div class="form-group">
                <label>Admin Name</label>
                <asp:TextBox ID="txtAname" runat="server" CssClass="custom-input" placeholder="Enter Name"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Email</label>
                <asp:TextBox ID="txtAemail" runat="server" CssClass="custom-input" TextMode="Email"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Password</label>
                <asp:TextBox ID="txtApassword" runat="server" CssClass="custom-input" TextMode="Password"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Contact Number</label>
                <asp:TextBox ID="txtAcon_num" runat="server" CssClass="custom-input" TextMode="Number"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Gender</label>
                <div class="gender-container">
                    <asp:RadioButtonList ID="rbGender" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Text="Male" Value="Male" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>
            </div>

            <div class="form-group">
                <label>Address</label>
                <asp:TextBox ID="txtAaddress" runat="server" CssClass="custom-input"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Profile Photo</label>
                <asp:FileUpload ID="fuPhoto" runat="server" CssClass="custom-input file-upload" />
            </div>

            <div class="form-group">
    <asp:Button ID="btnAddAdmin" runat="server" Text="Add Admin" OnClick="btnAddAdmin_Click" CssClass="btn-submit" />
    
    <asp:Button ID="btnShowData" runat="server" Text="Show Data" OnClick="btnShowData_Click" CssClass="btn-show" UseSubmitBehavior="false" />
</div>

            <asp:Label ID="lblMessage" runat="server" CssClass="message-label"></asp:Label>
        </form>
    </div>

</body>
</html>