<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="WebApplication1.WebForm1" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Welcome To Main Page</title>
    <link rel="stylesheet" type="text/css" href="~/StyleSheet2.css" />
</head>
<body>
    <%--<form id="form1" runat="server">
        <div>
            <asp:TextBox ID="txtto" runat="server" Placeholder="Recipient Email"></asp:TextBox>
            <br />
            <asp:TextBox ID="txtsub" runat="server" Placeholder="Subject"></asp:TextBox>
            <br />
            <asp:TextBox ID="txtbody" runat="server" TextMode="MultiLine" Rows="5" Placeholder="Message Body"></asp:TextBox>
            <br />
            <asp:Button ID="btnSendEmail" runat="server" Text="Send Email" OnClick="btnSendEmail_Click" />
        </div>
    </form>--%>

 
    <div class="container">
        <header>
            <div class="logo">
                <img src="cime_logo (2).png" alt="CIME Logo">
            </div>
            <h1>College of IT & Management Education,Bhubaneswar</h1>
            <h3>Welcome To E-Librery </h3>
        </header>
        <nav>
            <ul>
                <li><a href="#about">About Us</a></li>
                <li><a href="availablebook.aspx">Book List</a></li>
                <li><a href="https://www.cime.ac.in/contacts.html">Help</a></li>
                <li><a href="https://www.cime.ac.in/page.php?purl=contact">Contact</a></li>
                <li><a href="https://www.cime.ac.in/faculties.html">Faculties</a></li>
                <li class="dropdown"><a href="WebForm2.aspx" class="dropbtn">Login</a>
                    <div class="dropdown-content">
                        <a href="WebForm2.aspx">Admin Login</a>
                        <a href="Studentlogin.aspx">Student Login</a>
                    </div>
                </li>
                <li><a href="https://www.cime.ac.in">College Page</a></li>
            </ul>
        </nav>
        <main>
            <div class="banner">
                <h2>Our Mission</h2>
                <p>Our mission for the college's e-library system is to create an inclusive and dynamic learning environment through seamless integration of technology and academic rigor. By providing comprehensive access to digital resources, we aim to foster intellectual curiosity and continuous learning among students, educators, and researchers.</p>

<p>The e-library system breaks traditional barriers, offering diverse and evolving collections that cater to the needs of our users. With personalized services and advanced search capabilities, it becomes an essential tool for academic and personal growth.</p>

<p>Commitment to innovation and partnerships ensures our e-library stays at the forefront of educational resources. By supporting scholarly communication and enhancing user experience, we prepare our community to thrive in a rapidly changing world.</p>
            </div>
            <div class="image">
                <img src="cime gate.jpg" alt="College Building">
            </div>
        </main>
        <aside>
            <div id="about" >
                <h3>About Us</h3>
                <p>College of IT and Management Education (CIME) <br />formerly known as 
                    Centre for IT Education (CITE) came up as an initiative of the Orissa State Electronics Development Corporation Ltd. (A State Government Enterprise, Odisha) under Electronics and Information Technology
                    Department of Government of Odisha on 4th August, 2000 to impart professional educational programs in the field of IT and Management .<br />

As per the decision of Government of Odisha,<br />
                    CIME was taken over by the Government in the Industries Department to run as a Constituent College of Biju Patnaik University of Technology (BPUT) <br />
                    since 1st February 2006 on a self-sustaining model.

As on date, it is one of the Constituent Colleges of BPUT, Odisha.</p>
            </div>
        </aside>
    </div>
</body>
</html>