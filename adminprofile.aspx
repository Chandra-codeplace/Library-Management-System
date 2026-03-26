<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="adminprofile.aspx.cs" Inherits="WebApplication1.adminprofile" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Admin Profile</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <form runat="server">
        <div class="container mt-5">
            <h2>Admin Profile</h2>
            <div class="card">
                <div class="card-body">
                    <p><strong>Name:</strong> <asp:Label ID="lblprofilename" runat="server"></asp:Label></p>
                    <p><strong>Email:</strong> <asp:Label ID="lblProfileEmail" runat="server"></asp:Label></p>
                    <p><strong>Phone:</strong> <asp:Label ID="lblProfilePhone" runat="server"></asp:Label></p>
                    <p><strong>Address:</strong> <asp:Label ID="lblProfileAddress" runat="server"></asp:Label></p>
                </div>
            </div>
        </div>
    </form>
</body>
</html>

