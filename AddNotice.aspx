<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddNotice.aspx.cs" Inherits="WebApplication1.AddNotice" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Post New Notice</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f0f2f5;
            font-family: 'Segoe UI', sans-serif;
            padding: 20px;
        }

        h1 {
            font-size: 28px;
            color: #333;
            margin-bottom: 20px;
            font-weight: 500;
        }

        .form-card {
            background-color: #ffffff;
            width: 100%;
            max-width: 500px;
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

        .custom-input {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #e1e5ee;
            border-radius: 5px;
            background-color: #f0f4ff;
            font-size: 14px;
            outline: none;
        }

        .btn-post {
            width: 100%;
            background-color: #1a73e8;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 5px;
            font-size: 15px;
            font-weight: 500;
            cursor: pointer;
            margin-top: 10px;
        }

        .message-label {
            display: block;
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
            font-weight: bold;
        }
    </style>
</head>
<body>

    <h1>Post Academic Notice:</h1>

    <div class="form-card">
        <form id="form1" runat="server">
            <div class="form-group">
                <label>Notice Title</label>
                <asp:TextBox ID="txtTitle" runat="server" CssClass="custom-input" placeholder="e.g. Exam Schedule for MCA 2nd Sem"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Notice Content</label>
                <asp:TextBox ID="txtContent" runat="server" CssClass="custom-input" TextMode="MultiLine" Rows="5" placeholder="Type the detailed notice here..."></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Upload PDF Notice (Optional)</label>
                <asp:FileUpload ID="fuNotice" runat="server" CssClass="custom-input" />
                <small class="text-muted">If you upload a PDF, the notice will link to it.</small>
            </div>

            <div class="form-group">
                <asp:Button ID="btnPostNotice" runat="server" Text="Publish Notice" OnClick="btnPostNotice_Click" CssClass="btn-post" />
            </div>

            <asp:Label ID="lblMessage" runat="server" CssClass="message-label"></asp:Label>
        </form>
    </div>

</body>
</html>
