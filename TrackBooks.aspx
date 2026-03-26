<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TrackBooks.aspx.cs" Inherits="WebApplication1.TrackBooks" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <title>Track Book Status</title>
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

        .btn-search {
            background-color: #FFD700; /* Yellow */
            color: #000;
            border: 1px solid #e6c200;
            font-weight: 600;
        }
        .btn-search:hover {
            background-color: #ffcc00; 
            color: #000;
        }

        .table thead th { 
            background-color: #87CEEB; 
            color: #000; 
            font-weight: bold; 
        }
        
        .table-hover tbody tr:hover { background-color: #ffffe0; }
        
        /* Book Image Styling */
        .book-img {
            width: 50px;
            height: 70px;
            object-fit: cover;
            border-radius: 4px;
            border: 1px solid #ccc;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-5">
            
            <div class="card shadow-lg border-0">
                <div class="card-header p-4">
                    <div class="row align-items-center">
                        <div class="col-md-6">
                            <h4 class="mb-0 fw-bold"><i class="fas fa-search-location me-2"></i>Track Book Status</h4>
                        </div>
                        <div class="col-md-6">
                            <div class="input-group">
                                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search by Book Name or ID..."></asp:TextBox>
                                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-search" OnClick="btnSearch_Click" />
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="card-body p-0">
                    <asp:GridView ID="gvBookStatus" runat="server" 
                        CssClass="table table-hover mb-0 align-middle" 
                        AutoGenerateColumns="False" 
                        GridLines="None"
                        EmptyDataText="<div class='p-4 text-center'>No books found.</div>">
                        
                        <Columns>
                            <%-- 1. BOOK ID --%>
                            <asp:BoundField DataField="bkid" HeaderText="ID" ItemStyle-CssClass="fw-bold text-secondary" />

                            <%-- 2. BOOK DETAILS (Image + Title) --%>
                            <asp:TemplateField HeaderText="Book Details">
                                <ItemTemplate>
                                    <div class="d-flex align-items-center">
                                        <%-- <img src='<%# Eval("book_img") %>' class="book-img me-3" alt="Book" /> --%>
                                        <div>
                                            <div class="fw-bold text-dark"><%# Eval("title") %></div>
                                            <small class="text-muted"><%# Eval("author") %></small>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <%-- 3. AVAILABILITY STATUS (Logic handled in Backend Query) --%>
                            <asp:TemplateField HeaderText="Current Status">
                                <ItemTemplate>
                                    <asp:Label ID="lblStatus" runat="server" 
                                        Text='<%# Eval("StatusText") %>' 
                                        CssClass='<%# Eval("StatusText").ToString() == "Available" ? "badge bg-success" : "badge bg-danger" %>'>
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <%-- 4. BORROWER INFO (Only visible if issued) --%>
                            <asp:TemplateField HeaderText="Issued To">
                                <ItemTemplate>
                                    <div runat="server" visible='<%# !string.IsNullOrEmpty(Eval("StudentName").ToString()) %>'>
                                        <div class="fw-bold"><%# Eval("StudentName") %></div>
                                        <small class="text-muted"><i class="fas fa-id-badge me-1"></i><%# Eval("StudentID") %></small>
                                    </div>
                                    <div runat="server" visible='<%# string.IsNullOrEmpty(Eval("StudentName").ToString()) %>' class="text-muted small">
                                        -
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <%-- 5. TIMELINE (Issued/Due Dates) --%>
                            <asp:TemplateField HeaderText="Timeline">
                                <ItemTemplate>
                                    <div runat="server" visible='<%# !string.IsNullOrEmpty(Eval("BorrowDate").ToString()) %>'>
                                        <small class="d-block text-muted">Issued: <span class="text-dark fw-bold"><%# Eval("BorrowDate", "{0:dd MMM}") %></span></small>
                                        <small class="d-block text-danger">Due: <span class="fw-bold"><%# Eval("ReturnDate", "{0:dd MMM}") %></span></small>
                                    </div>
                                     <div runat="server" visible='<%# string.IsNullOrEmpty(Eval("BorrowDate").ToString()) %>' class="text-muted small">
                                        -
                                    </div>
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