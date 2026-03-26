<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="front.aspx.cs" Inherits="LMS.TotalBook" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Total Books</title>
    <link rel="stylesheet" href="TotalBook.css" />
</head>
<body>
    <form id="form1" runat="server" class="container">
        <div>
            <asp:TextBox ID="txtSearch" runat="server" placeholder="Search by Title" CssClass="search-box"></asp:TextBox>
            <asp:Button ID="btnSearch" runat="server" Text="Search" 
                        CssClass="btn-search" OnClick="btnSearch_Click" />
            
            <asp:TextBox ID="txtTitle" runat="server" placeholder="Title"></asp:TextBox>
            <asp:TextBox ID="txtAuthor" runat="server" placeholder="Author"></asp:TextBox>
            <asp:TextBox ID="txtISBN" runat="server" placeholder="ISBN"></asp:TextBox>
            <asp:TextBox ID="txtPublisher" runat="server" placeholder="Publisher"></asp:TextBox>
            
            <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" 
                        Visible="false" CssClass="btn-save" />
            
            <asp:Label ID="lblMsg" runat="server" Text="" CssClass="message"></asp:Label>

            <asp:GridView ID="GridView2" runat="server" 
                          CssClass="table" 
                          AutoGenerateColumns="false" EmptyDataText="No data found">
                <Columns>
                    <asp:TemplateField HeaderText="SL">
                        <ItemTemplate>
                            <%# Container.DataItemIndex + 1 %>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Title">
                        <ItemTemplate>
                            <asp:Label ID="lblTitle" runat="server" 
                                       Text='<%# Eval("title") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Author">
                        <ItemTemplate>
                            <asp:Label ID="lblAuthor" runat="server" 
                                       Text='<%# Eval("author") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="ISBN">
                        <ItemTemplate>
                            <asp:Label ID="lblISBN" runat="server" 
                                       Text='<%# Eval("isbn") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Publisher">
                        <ItemTemplate>
                            <asp:Label ID="lblPublisher" runat="server" 
                                       Text='<%# Eval("publisher") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Edit">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnlEdit" runat="server" 
                                            Text="✏️ Edit" 
                                            CssClass="link-edit"
                                            OnClick="lnlEdit_Click"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="Delete">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" 
                                        Text="✏️ Delete" 
                                        CssClass="link-edit"
                                        OnClick="lnlDelete_Click"></asp:LinkButton>
                         </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
