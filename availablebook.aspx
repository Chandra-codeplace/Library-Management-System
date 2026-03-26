<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="availablebook.aspx.cs" Inherits="LMS.availablebook" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Available Books</title>
    <style>
       body {
    font-family: 'Segoe UI', Arial, sans-serif;
    background-color: #f4f6f8;
    margin: 0;
    padding: 20px;
    color: #333;
}

.search-box {
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
    margin-bottom: 20px;
    background: #ffffff;
    padding: 15px;
    border-radius: 8px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.08);
}

.search-box input[type="text"] {
    flex: 1;
    min-width: 200px;
    padding: 8px 12px;
    border: 1px solid #ccc;
    border-radius: 5px;
    transition: border-color 0.3s;
}

.search-box input[type="text"]:focus {
    border-color: #0078d7;
    outline: none;
}

.search-box input[type="submit"], 
.search-box button, 
.search-box .aspNetButton {
    background-color: #0078d7;
    color: white;
    border: none;
    padding: 8px 16px;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.25s ease;
}

.search-box input[type="submit"]:hover,
.search-box button:hover {
    background-color: #005a9e;
}

.message {
    color: #d9534f;
    margin-top: 10px;
    font-weight: 500;
}

#GridViewBooks {
    width: 100%;
    border-collapse: collapse;
    background: #fff;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 2px 5px rgba(0,0,0,0.08);
}

#GridViewBooks th {
    background-color: #0078d7;
    color: white;
    text-align: left;
    padding: 10px;
    font-weight: 600;
}

#GridViewBooks td {
    padding: 10px;
    border-bottom: 1px solid #e0e0e0;
}

#GridViewBooks tr:nth-child(even) {
    background-color: #f9f9f9;
}

#GridViewBooks tr:hover {
    background-color: #eef6fb;
}

#GridViewBooks td span {
    font-weight: bold;
}

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="search-box">
            <asp:TextBox ID="txtSearchTitle" runat="server" placeholder="Search by Title"></asp:TextBox>
            <asp:TextBox ID="txtSearchISBN" runat="server" placeholder="Search by ISBN"></asp:TextBox>
            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
        </div>

        <asp:GridView ID="GridViewBooks" runat="server" AutoGenerateColumns="False" OnRowDataBound="GridViewBooks_RowDataBound" BorderWidth="1" CellPadding="5" GridLines="Both">
            <Columns>
                <asp:BoundField DataField="bkid" HeaderText="Book ID" />
                <asp:BoundField DataField="title" HeaderText="Title" />
                <asp:BoundField DataField="author" HeaderText="Author" />
                <asp:BoundField DataField="isbn" HeaderText="ISBN" />
                <asp:BoundField DataField="publisher" HeaderText="Publisher" />
                <asp:BoundField DataField="availability" HeaderText="Availability" HtmlEncode="false" />
            </Columns>
        </asp:GridView>

        <asp:Label ID="lblMsg" runat="server" CssClass="message"></asp:Label>
    </form>
</body>
</html>
