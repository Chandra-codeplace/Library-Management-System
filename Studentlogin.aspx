<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Studentlogin.aspx.cs" Inherits="WebApplication1.Studentlogin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Student Login Page</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="~/StyleSheet1.css" />
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
</head>
<body>
    <form runat="server">
    <section class="vh-100">
        <div class="container-fluid h-custom">
            <div class="row d-flex justify-content-center align-items-center h-100">
                <div class="col-md-9 col-lg-6 col-xl-5">
                    <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/draw2.webp"
                         class="img-fluid" alt="Sample image">
                </div>
                <div class="col-md-8 col-lg-6 col-xl-4 offset-xl-1">
                    <div class="form-header">
                        <h2>Student Login</h2>
                    </div>

                    

                    <!-- Email input -->
                    <div class="form-outline mb-4">
                        <asp:TextBox ID="emailInput" CssClass="form-control form-control-lg" placeholder="Enter a valid email address" runat="server" />
                        <label class="form-label" for="emailInput">Email address</label>
                    </div>

                    <!-- Password input -->
                    <div class="form-outline mb-3">
                        <asp:TextBox ID="passwordInput" TextMode="Password" CssClass="form-control form-control-lg" placeholder="Enter password" runat="server" />
                        <label class="form-label" for="passwordInput">Password</label>
                    </div>

                    <div class="d-flex justify-content-between align-items-center">
                        <!-- Checkbox -->
                        <div class="form-check mb-0">
                            <input class="form-check-input me-2" type="checkbox" value="" id="rememberMeCheck" />
                            <label class="form-check-label" for="rememberMeCheck">Remember me</label>
                        </div>
                        <a href="#!" class="text-body">Forgot password?</a>
                    </div>

                    <div class="text-center text-lg-start mt-4 pt-2">
                        <asp:Button ID="btnSignIn" Text="Login" CssClass="btn btn-primary btn-lg" OnClick="btnSignIn_Click" runat="server" />
                        <p class="small fw-bold mt-2 pt-1 mb-0">Don't have an account?<%--register button--%> <a href="adminregistration.aspx" class="link-danger">Register</a></p>
                    </div>
                </div>
            </div>
        </div>
        <div class="d-flex flex-column flex-md-row text-center text-md-start justify-content-between py-4 px-4 px-xl-5 bg-primary">
            <!-- Copyright -->
            <div class="text-white mb-3 mb-md-0">
                Login to your account.
            </div>
            <!-- Right -->
            <div>
                <a href="#!" class="text-white me-4">
                    <i class="fab fa-facebook-f"></i>
                </a>
                <a href="#!" class="text-white me-4">
                    <i class="fab fa-twitter"></i>
                </a>
                <a href="#!" class="text-white me-4">
                    <i class="fab fa-google"></i>
                </a>
                <a href="#!" class="text-white">
                    <i class="fab fa-linkedin-in"></i>
                </a>
            </div>
        </div>
    </section>
    </form>
</body>
</html>

       
