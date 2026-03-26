<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BorrowedBooks.aspx.cs" Inherits="WebApplication1.BorrowedBooks" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Student - Borrowed Books</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
    
    <style>
        .page-header { background-color: #f8f9fa; padding: 20px 0; margin-bottom: 20px; border-bottom: 1px solid #dee2e6; }
        .table-custom { background-color: white; border-radius: 8px; overflow: hidden; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        
        <div class="page-header">
            <div class="container">
                <h2 class="h4 mb-0 text-primary">
                    <i class="fas fa-book-reader me-2"></i>My Borrowed Books
                </h2>
            </div>
        </div>

        <div class="container">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">Current Borrowing History</h5>
                </div>
                <div class="card-body bg-light">
                    
                    <div class="table-responsive table-custom shadow-sm">
                        <asp:GridView ID="gvBorrowedBooks" runat="server" 
                            CssClass="table table-hover align-middle mb-0" 
                            AutoGenerateColumns="False" 
                            GridLines="None" 
                            OnRowCommand="gvBorrowedBooks_RowCommand"
                            EmptyDataText="No books found.">
                            
                            <Columns>
                                <%-- 1. Borrowed ID --%>
                                <asp:BoundField DataField="BorrowedID" HeaderText="Ref ID" ItemStyle-Font-Bold="true" />

                                <%-- 2. Book Details --%>
                                <asp:TemplateField HeaderText="Book Details">
                                    <ItemTemplate>
                                        <div class="d-flex align-items-center">
                                            <div class="bg-light border rounded p-2 me-3 text-center" style="width: 45px; height: 45px;">
                                                <i class="fas fa-book fa-lg text-secondary"></i>
                                            </div>
                                            <div>
                                                <div class="fw-bold"><%# Eval("BookName") %></div>
                                                <small class="text-muted">Book ID: <%# Eval("BookID") %></small>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <%-- 3. Dates --%>
                                <asp:BoundField DataField="BorrowedDate" HeaderText="Borrowed On" DataFormatString="{0:dd-MMM-yyyy}" />
                                <asp:BoundField DataField="DueDate" HeaderText="Due Date" DataFormatString="{0:dd-MMM-yyyy}" ItemStyle-CssClass="fw-bold" />

                                <%-- 4. Fine 
                                <asp:TemplateField HeaderText="Fine">
                                    <ItemTemplate>
                                        <%# Convert.ToDecimal(Eval("FineAmount")) > 0 
                                            ? "<span class='text-danger fw-bold'>₹" + Eval("FineAmount") + "</span>" 
                                            : "<span class='text-success'>₹0</span>" %>
                                    </ItemTemplate>
                                </asp:TemplateField>--%>

                                <%-- 5. Status (This calls the C# method) --%>
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <span class='badge rounded-pill <%# GetStatusClass(Eval("Status"), Eval("DueDate")) %>'>
                                             <%# GetStatusText(Eval("Status"), Eval("DueDate")) %>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <%-- 6. Action --%>
                                <asp:TemplateField HeaderText="Action">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnReturn" runat="server" 
                                            CommandName="ReturnBook" 
                                            CommandArgument='<%# Eval("BorrowedID") %>' 
                                            CssClass="btn btn-sm btn-outline-primary"
                                            Visible='<%# IsReturnable(Eval("Status")) %>' 
                                            OnClientClick="return confirm('Are you sure you want to return this book?');">
                                            <i class="fas fa-undo me-1"></i> Return
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>

                            </Columns>
                            <HeaderStyle CssClass="table-light text-uppercase small fw-bold text-muted" />
                        </asp:GridView>
                    </div>

                </div>
            </div>
        </div>
    </form>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
