<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewStudents.aspx.cs" Inherits="WebApplication1.ViewStudents" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Students - Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body { background-color: #f0f2f5; font-family: 'Segoe UI', sans-serif; padding: 30px; }
        .container-box { background-color: white; padding: 25px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.08); }
        .header-flex { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .student-img { width: 50px; height: 50px; border-radius: 50%; object-fit: cover; border: 1px solid #ddd; }
        .table-header { background-color: #1a73e8; color: white; }
        
        /* Search Bar Styling */
        .search-container { max-width: 500px; margin-bottom: 20px; display: flex; gap: 10px; }
        .search-input { background-color: #f0f4ff; border: 1px solid #e1e5ee; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="container-box">
                <div class="header-flex">
                    <h2><i class="fas fa-user-graduate"></i> Student Management</h2>
                    <asp:HyperLink ID="hlAdd" runat="server" NavigateUrl="AddStudent.aspx" CssClass="btn btn-primary">
                        <i class="fas fa-plus"></i> Add New Student
                    </asp:HyperLink>
                </div>

                <div class="search-container">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control search-input" placeholder="Search by Name or ID..."></asp:TextBox>
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-dark" OnClick="btnSearch_Click" />
                    <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-outline-secondary" OnClick="btnClear_Click" />
                </div>

                <asp:GridView ID="gvStudents" runat="server" AutoGenerateColumns="False" 
                    CssClass="table table-hover table-bordered shadow-sm" GridLines="None"
                    DataKeyNames="sid" 
                    OnRowEditing="gvStudents_RowEditing" 
                    OnRowDeleting="gvStudents_RowDeleting" 
                    OnRowUpdating="gvStudents_RowUpdating" 
                    OnRowCancelingEdit="gvStudents_RowCancelingEdit">
                    
                    <HeaderStyle CssClass="table-header" />
                    <Columns>
                        <asp:TemplateField HeaderText="Photo">
                            <ItemTemplate>
                                <asp:Image ID="imgStudent" runat="server" CssClass="student-img" 
                                    ImageUrl='<%# GetImage(Eval("Photo")) %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:BoundField DataField="sid" HeaderText="ID" ReadOnly="True" />

                        <asp:TemplateField HeaderText="Name">
                            <ItemTemplate><%# Eval("sname") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditName" runat="server" Text='<%# Bind("sname") %>' CssClass="form-control form-control-sm"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Email">
                            <ItemTemplate><%# Eval("email") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditEmail" runat="server" Text='<%# Bind("email") %>' CssClass="form-control form-control-sm"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Contact">
                            <ItemTemplate><%# Eval("scon_num") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditCon" runat="server" Text='<%# Bind("scon_num") %>' CssClass="form-control form-control-sm"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Address">
                            <ItemTemplate><%# Eval("address") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditAddress" runat="server" Text='<%# Bind("address") %>' CssClass="form-control form-control-sm"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CssClass="text-primary me-2"><i class="fas fa-edit"></i></asp:LinkButton>
                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CssClass="text-danger" OnClientClick="return confirm('Delete this student?');"><i class="fas fa-trash"></i></asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" CssClass="btn btn-sm btn-success text-white me-1">Save</asp:LinkButton>
                                <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" CssClass="btn btn-sm btn-secondary text-white">Cancel</asp:LinkButton>
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="alert alert-warning text-center">No results found matching your search.</div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>
