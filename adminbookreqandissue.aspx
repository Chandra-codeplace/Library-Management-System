<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="adminbookreqandissue.aspx.cs" Inherits="WebApplication1.adminbookreqandissue" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Book Requests and Issue</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <style>
        /* ===== Global Layout ===== */
        body {
            margin: 0;
            padding: 0;
            background-color: #f0f2f5; /* Softer gray for better contrast */
            font-family: 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            color: #333;
            /* Flexbox to center the .page wrapper vertically */
            display: flex;
            min-height: 100vh;
            align-items: center;
            justify-content: center;
        }

        /* Page wrapper */
        .page {
            width: 100%;
            display: flex;
            justify-content: center; /* Horizontally center the content */
            padding: 20px; /* Prevents card from touching edges on small screens */
            box-sizing: border-box;
        }

        /* Card Container */
        .card {
            width: 100%;
            max-width: 950px; /* Limits width on big screens */
            background: #ffffff;
            border-radius: 20px; /* Modern rounded corners */
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0,0,0, 0.08); /* Soft, deep shadow */
        }

        /* ===== Header ===== */
        .title-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 25px;
            border-bottom: 1px solid #f0f0f0;
            padding-bottom: 15px;
        }

        .title {
            font-size: 24px;
            font-weight: 700;
            color: #1a1a1a;
            margin: 0;
        }

        .tag {
            background: #fff8c5; /* Softer yellow background */
            color: #8a6d0b;       /* Darker yellow text */
            padding: 6px 16px;
            border-radius: 50px;
            font-size: 13px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* ===== Toolbar ===== */
        .tools {
            display: flex;
            gap: 12px;
            align-items: center;
            margin-bottom: 25px;
        }

        .input {
            height: 45px;
            flex-grow: 1; /* Search bar takes available space */
            max-width: 400px;
            padding: 0 16px;
            font-size: 15px;
            border-radius: 8px;
            border: 1px solid #e1e4e8;
            outline: none;
            transition: border-color 0.2s;
        }

        .input:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 3px rgba(13, 110, 253, 0.1);
        }

        /* ===== Buttons ===== */
        .btn {
            height: 45px;
            padding: 0 20px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.2s ease;
        }

        .btn-gray {
            background: #f1f3f5;
            color: #495057;
        }
        .btn-gray:hover { background: #e9ecef; }

        .btn-approve {
            background: #0d6efd;
            color: #ffffff;
            height: 36px; /* Smaller height for table buttons */
            padding: 0 16px;
        }
        .btn-approve:hover { 
            background: #0b5ed7; 
            transform: translateY(-1px);
        }

        .btn-reject {
            background: #ffc107;
            color: #212529;
            height: 36px;
            padding: 0 16px;
        }
        .btn-reject:hover { 
            background: #e0a800; 
            transform: translateY(-1px);
        }

        /* ===== GridView ===== */
        .grid {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        .grid th {
            text-align: left;
            padding: 16px;
            background-color: #f8f9fa;
            color: #6c757d;
            font-size: 13px;
            font-weight: 700;
            text-transform: uppercase;
            border-bottom: 2px solid #e9ecef;
        }

        .grid td {
            padding: 16px;
            border-bottom: 1px solid #f1f3f5;
            color: #212529;
            vertical-align: middle;
        }

        .grid tr:last-child td { border-bottom: none; }
        
        /* Hover effect on rows */
        .grid tr:hover {
            background-color: #fafafa; 
        }

        /* Column specific tweaks */
        .col-id { width: 60px; text-align: center; color: #adb5bd; }
        .col-actions { text-align: right; }

        /* ===== Pager ===== */
        .pager {
            margin-top: 20px;
            text-align: right;
        }
        .pager a {
            padding: 8px 12px;
            margin: 0 2px;
            background: #f8f9fa;
            text-decoration: none;
            color: #0d6efd;
            border-radius: 6px;
        }
        .pager span {
            padding: 8px 12px;
            margin: 0 2px;
            background: #0d6efd;
            color: white;
            border-radius: 6px;
        }

        /* ===== Empty State ===== */
        .empty-wrap {
            text-align: center;
            padding: 60px 0;
            color: #adb5bd;
        }
        .empty-text { font-size: 16px; font-weight: 500; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="page">
            <div class="card">
                <div class="title-row">
                    <h2 class="title">Pending Book Requests</h2>
                    <span class="tag">Pending Queue</span>
                </div>

                <div class="tools">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="input" placeholder="Search by Title or Student ID"></asp:TextBox>
                    <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-gray" Text="Search" OnClick="btnSearch_Click" />
                    <asp:Button ID="btnClear" runat="server" CssClass="btn btn-gray" Text="Clear" OnClick="btnClear_Click" />
                </div>

                <asp:GridView ID="gvRequests" runat="server"
                    CssClass="grid"
                    GridLines="None"
                    AutoGenerateColumns="False"
                    DataKeyNames="requestid"
                    AllowPaging="True"
                    PageSize="8"
                    OnPageIndexChanging="gvRequests_PageIndexChanging"
                    OnRowCommand="gvRequests_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="requestid" HeaderText="Req Id">
                            <ItemStyle CssClass="col-id" />
                            <HeaderStyle CssClass="col-id" />
                        </asp:BoundField>
                        
                        <asp:BoundField DataField="requestedat" HeaderText="Date" DataFormatString="{0:MMM dd, yyyy}" />
                        
                        <asp:BoundField DataField="sid" HeaderText="Student ID" >
                            <ItemStyle Font-Bold="true" />
                        </asp:BoundField>
                        
                        <asp:BoundField DataField="title" HeaderText="Book Title" />
                        
                        <asp:BoundField DataField="bkid" HeaderText="Book ID" />

                        <asp:TemplateField HeaderText="Actions">
                            <ItemStyle CssClass="col-actions" />
                            <HeaderStyle CssClass="col-actions" />
                            <ItemTemplate>
                                <asp:Button ID="btnApprove" runat="server" Text="Approve" CssClass="btn btn-approve"
                                    CommandName="Approve"
                                    CommandArgument='<%# Eval("requestid") + "|" + Eval("sid") + "|" + Eval("bkid") %>' />
                                <asp:Button ID="btnReject" runat="server" Text="Reject" CssClass="btn btn-reject" Style="margin-left: 8px"
                                    CommandName="Reject"
                                    CommandArgument='<%# Eval("requestid") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <PagerStyle CssClass="pager" />
                </asp:GridView>

                <asp:Panel ID="pnlEmpty" runat="server" Visible="false">
                    <div class="empty-wrap">
                        <div class="empty-text">No pending requests found.</div>
                    </div>
                </asp:Panel>

                <asp:Label ID="lblMsg" runat="server" CssClass="note" style="display:block; margin-top:15px; text-align:center;"></asp:Label>
            </div>
        </div>
    </form>
</body>
</html>