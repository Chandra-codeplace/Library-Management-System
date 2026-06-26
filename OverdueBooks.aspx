
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OverdueBooks.aspx.cs" Inherits="WebApplication1.OverdueBooks" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <title>Overdue Books Manager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    
    <style>
        /* Sky Blue & Yellow Theme */
        body { background-color: #f0f8ff; font-family: 'Segoe UI', sans-serif; }

        .card-header { 
            background-color: #87CEEB; /* Sky Blue */
            color: #000; 
            border: none;
        }

        .table thead th { 
            background-color: #87CEEB; 
            color: #000; 
            font-weight: bold; 
        }

        .btn-custom {
            background-color: #FFD700; /* Yellow */
            color: #000;
            border: 1px solid #e6c200;
            font-weight: 600;
        }
        .btn-custom:hover {
            background-color: #ffcc00; 
            color: #000;
        }
        
        .table-hover tbody tr:hover { background-color: #ffffe0; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-5">
            
            <div class="card shadow-lg border-0">
                <div class="card-header p-4 d-flex justify-content-between align-items-center">
                    <h4 class="mb-0 fw-bold"><i class="fas fa-bell me-2"></i>Overdue Books Manager</h4>
                    <span class="badge bg-white text-dark shadow-sm">Action Required</span>
                </div>
                
                <div class="card-body p-0">
                    <asp:GridView ID="gvOverdue" runat="server" 
                        CssClass="table table-hover mb-0 align-middle" 
                        AutoGenerateColumns="False" 
                        GridLines="None"
                        OnRowCommand="gvOverdue_RowCommand"
                        EmptyDataText="<div class='p-4 text-center'>No overdue books found in the database!</div>">
                        
                        <Columns>
                            <%-- 1. BOOK NAME --%>
                            <asp:BoundField DataField="BookName" HeaderText="Book Title" ItemStyle-Font-Bold="true" />

                            <%-- 2. BOOK ID --%>
                            <asp:BoundField DataField="BookID" HeaderText="Book ID" ItemStyle-CssClass="text-secondary" />

                            <%-- 3. STUDENT INFO --%>
                            <asp:TemplateField HeaderText="Student Info">
                                <ItemTemplate>
                                    <div class="fw-bold text-dark"><%# Eval("StudentName") %></div>
                                    <small class="text-muted"><i class="fas fa-id-card me-1"></i><%# Eval("StudentID") %></small>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <%-- 4. DATES --%>
                            <asp:BoundField DataField="BorrowDate" HeaderText="Borrow Date" DataFormatString="{0:dd MMM yyyy}" />
                            
                            <asp:TemplateField HeaderText="Due Date">
                                <ItemTemplate>
                                    <span class="text-danger fw-bold"><%# Eval("ReturnDate", "{0:dd MMM yyyy}") %></span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <%-- 5. STATUS --%>
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <span class="badge bg-danger rounded-pill">Overdue</span>
                                    <span class="d-block small text-danger fw-bold mt-1">
                                        <%# Eval("DaysLate") %> days late
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <%-- 6. ACTION BUTTON --%>
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnAlert" runat="server" 
                                        CommandName="SendAlert" 
                                        CommandArgument='<%# Container.DataItemIndex %>'
                                        CssClass="btn btn-sm btn-custom shadow-sm">
                                        <i class="fas fa-envelope me-1"></i> Send Alert
                                    </asp:LinkButton>

                                    <asp:HiddenField ID="hfEmail" runat="server" Value='<%# Eval("StudentEmail") %>' />
                                    <asp:HiddenField ID="hfStudentName" runat="server" Value='<%# Eval("StudentName") %>' />
                                    <asp:HiddenField ID="hfBookName" runat="server" Value='<%# Eval("BookName") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </form>
</body>
</html>