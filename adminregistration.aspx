<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="adminregistration.aspx.cs" Inherits="WebApplication1.adminregistration" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Registration</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <form runat="server" class="registration-form">
        <div class="container">
            <div class="row justify-content-center align-items-center">
                <div class="col-md-6">
                    <div class="form-image-container">
                        <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/draw2.webp" class="img-fluid" alt="Sample image">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-header">
                        <h2>Admin Registration</h2>
                    </div>
                    <div class="form-group">
                        <asp:TextBox ID="name" runat="server" CssClass="form-control" placeholder="Enter Your Name"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:TextBox ID="email" runat="server" CssClass="form-control" placeholder="Email ID"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <h6>Gender:</h6>
                        <asp:RadioButton ID="femaleGender" runat="server" GroupName="gender" Text="Female" />
                        <asp:RadioButton ID="maleGender" runat="server" GroupName="gender" Text="Male" />
                        <asp:RadioButton ID="otherGender" runat="server" GroupName="gender" Text="Other" />
                    </div>
                    <div class="form-group">
                        <asp:TextBox ID="mobno" runat="server" CssClass="form-control" placeholder="Mobile Number"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:TextBox ID="address" runat="server" CssClass="form-control" placeholder="Address"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:TextBox ID="pass" runat="server" CssClass="form-control" TextMode="Password" placeholder="Password"></asp:TextBox>
                    </div>
                    
                    <div class="form-buttons">
                        <button type="reset" class="btn btn-light">Reset all</button>
                        <asp:Label ID="lblMessage" runat="server" ForeColor="Red" />
                        <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="RegisterAdmin_Click" CssClass="btn btn-primary" />
                        <%--<button type="submit" class="btn btn-primary" onclick="RegisterAdmin_Click">Submit</button>--%>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
