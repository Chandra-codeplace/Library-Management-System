<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewAdmins.aspx.cs" Inherits="WebApplication1.ViewAdmins" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Directory</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body { background-color: #f0f2f5; font-family: 'Segoe UI', sans-serif; padding: 40px; }
        .header-section { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
        h1 { font-size: 28px; color: #333; margin: 0; }
        .btn-add { background-color: #1a73e8; color: white; padding: 10px 20px; border-radius: 5px; text-decoration: none; font-weight: 500; }
        
        .grid-container { background-color: white; padding: 20px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05); }
        .admin-photo { width: 50px; height: 50px; border-radius: 50%; object-fit: cover; border: 1px solid #ddd; }
        
        /* Search Bar */
        .search-box { max-width: 500px; margin-bottom: 20px; display: flex; gap: 10px; }
        .search-input { background-color: #f0f4ff; border: 1px solid #e1e5ee; }
    </style>
</head>
<body>

    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="header-section">
                <h1>Admin Directory</h1>
                <asp:HyperLink ID="lnkAdd" runat="server" NavigateUrl="AddAdmin.aspx" CssClass="btn-add">
                    <i class="fas fa-plus"></i> Add New Admin
                </asp:HyperLink>
            </div>

            <div class="grid-container">
                <div class="search-box">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control search-input" placeholder="Search by Name or Email..."></asp:TextBox>
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-dark" OnClick="btnSearch_Click" />
                    <asp:Button ID="btnClear" runat="server" Text="Reset" CssClass="btn btn-outline-secondary" OnClick="btnClear_Click" />
                </div>

                <asp:GridView ID="gvAdmins" runat="server" AutoGenerateColumns="False" 
                    CssClass="table table-hover table-bordered" 
                    DataKeyNames="aemail"
                    OnRowEditing="gvAdmins_RowEditing"
                    OnRowDeleting="gvAdmins_RowDeleting"
                    OnRowUpdating="gvAdmins_RowUpdating"
                    OnRowCancelingEdit="gvAdmins_RowCancelingEdit">
                    
                    <Columns>
                        <asp:TemplateField HeaderText="Photo">
                            <ItemTemplate>
                                <asp:Image ID="imgAdmin" runat="server" CssClass="admin-photo" 
                                    ImageUrl='<%# GetImage(Eval("Photo")) %>' />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Name">
                            <ItemTemplate><%# Eval("Aname") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditName" runat="server" Text='<%# Bind("Aname") %>' CssClass="form-control form-control-sm"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="aemail" HeaderText="Email" ReadOnly="True" />

                        <asp:TemplateField HeaderText="Contact">
                            <ItemTemplate><%# Eval("acon_num") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditCon" runat="server" Text='<%# Bind("acon_num") %>' CssClass="form-control form-control-sm"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Gender">
                            <ItemTemplate><%# Eval("agender") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlEditGender" runat="server" CssClass="form-select form-select-sm">
                                    <asp:ListItem>Male</asp:ListItem>
                                    <asp:ListItem>Female</asp:ListItem>
                                    <asp:ListItem>Other</asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Address">
                            <ItemTemplate><%# Eval("a_address") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditAddress" runat="server" Text='<%# Bind("a_address") %>' CssClass="form-control form-control-sm"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CssClass="text-primary me-2"><i class="fas fa-edit"></i></asp:LinkButton>
                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CssClass="text-danger" OnClientClick="return confirm('Delete this Admin?');"><i class="fas fa-trash"></i></asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" CssClass="btn btn-sm btn-success text-white me-1">Update</asp:LinkButton>
                                <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" CssClass="btn btn-sm btn-secondary text-white">Cancel</asp:LinkButton>
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="text-center p-3">No matching admin records found.</div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </form>

</body>
</html>