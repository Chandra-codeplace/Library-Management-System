<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="studentbookrequest.aspx.cs" Inherits="WebApplication1.studentbookrequest" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Request Book</title>

    <!-- Keep the same CDNs you use across the app -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />

    <style>
        body { min-height:100vh; background:#f8f9fa; margin:0; }
        .sidebar { background:#343a40; padding-top:20px; width:250px; min-height:100vh; position:fixed; }
        .sidebar a { color:#fff; display:block; padding:10px 20px; text-decoration:none; }
        .sidebar a:hover { background:#495057; }
        .content { margin-left:250px; padding:22px 28px; }

        .card-box { background:#fff; border-radius:10px; box-shadow:0 2px 12px rgba(0,0,0,.06); padding:18px; }
        .toolbar { display:flex; gap:10px; flex-wrap:wrap; margin-bottom:14px; }
        .search-input { width:320px; }
        .btn-accent { background:#ffd51e; color:#232937; border:none; font-weight:600; }
        .btn-accent:hover { filter:brightness(.95); }

        .gv th { background:#e9ecef; }
        .gv .btn-request { background:#00c3ed; color:#fff; border:none; padding:6px 10px; border-radius:6px; }
        .msg { margin-top:10px; }
    </style>
</head>
<body>
<form id="form1" runat="server">
    <!-- Your exact sidebar -->
    <div class="sidebar">
        <a href="Studentdashboard1.aspx"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
        <a href="#studentbookrequest.aspx"><i class="fas fa-book"></i> Request Book</a>
        <a href="BorrowedBooks.aspx"><i class="fas fa-book-reader"></i> Borrowed Books</a>
        <a href="StudentLogout.aspx" class="text-danger"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>

    <div class="content">
        <div class="card-box">
            <!-- Search bar -->
            <div class="toolbar">
                <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control search-input" placeholder="Search by Title"></asp:TextBox>
                <asp:TextBox ID="txtAuthor" runat="server" CssClass="form-control search-input" placeholder="Author"></asp:TextBox>
                <asp:TextBox ID="txtISBN" runat="server" CssClass="form-control search-input" placeholder="ISBN"></asp:TextBox>
                <asp:TextBox ID="txtPublisher" runat="server" CssClass="form-control search-input" placeholder="Publisher"></asp:TextBox>
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-accent" OnClick="btnSearch_Click" />
                <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-secondary" OnClick="btnClear_Click" />
            </div>

            <!-- Books Grid -->
            <asp:GridView ID="gvBooks"
                          runat="server"
                          CssClass="table table-bordered table-hover gv"
                          AutoGenerateColumns="False"
                          DataKeyNames="bkid"
                          AllowPaging="True"
                          PageSize="10"
                          OnPageIndexChanging="gvBooks_PageIndexChanging"
                          OnRowCommand="gvBooks_RowCommand">
                <Columns>
                    <asp:BoundField DataField="SL" HeaderText="SL" ItemStyle-Width="60" />
                    <asp:BoundField DataField="title" HeaderText="Title" />
                    <asp:BoundField DataField="author" HeaderText="Author" />
                    <asp:BoundField DataField="isbn" HeaderText="ISBN" />
                    <asp:BoundField DataField="publisher" HeaderText="Publisher" />
                    <asp:TemplateField HeaderText="Request">
                        <ItemTemplate>
                            <asp:Button ID="btnReq" runat="server"
                                        Text="Request"
                                        CssClass="btn-request"
                                        CommandName="Req"
                                        CommandArgument='<%# Eval("bkid") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <asp:Label ID="lblMsg" runat="server" CssClass="msg text-success"></asp:Label>
        </div>
    </div>
</form>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

