using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;           // REQUIRED FOR GMAIL
using System.Net.Mail;      // REQUIRED FOR GMAIL

namespace WebApplication1
{
    public partial class OverdueBooks : System.Web.UI.Page
    {
        string strcon = ConfigurationManager.ConnectionStrings["LibreryDbConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindRealData();
            }
        }

        private void BindRealData()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(strcon))
                {
                    if (con.State == ConnectionState.Closed) con.Open();

                    string query = @"
                        SELECT 
                            B.bkid AS BookID,
                            BK.title AS BookName,
                            S.sid AS StudentID,
                            S.sname AS StudentName,
                            S.email AS StudentEmail,
                            B.bdate AS BorrowDate,
                            B.returndt AS ReturnDate,
                            DATEDIFF(day, B.returndt, GETDATE()) AS DaysLate
                        FROM Borrow B
                        INNER JOIN book BK ON B.bkid = BK.bkid
                        INNER JOIN student S ON B.sid = S.sid
                        WHERE B.returndt < GETDATE() 
                        AND (B.status != 'Returned' OR B.status IS NULL)
                        ORDER BY B.returndt ASC";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);
                            gvOverdue.DataSource = dt;
                            gvOverdue.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Database Error: " + ex.Message + "');</script>");
            }
        }

        protected void gvOverdue_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "SendAlert")
            {
                try
                {
                    int rowIndex = Convert.ToInt32(e.CommandArgument);
                    GridViewRow row = gvOverdue.Rows[rowIndex];

                    // Fetch data
                    string email = ((HiddenField)row.FindControl("hfEmail")).Value;
                    string name = ((HiddenField)row.FindControl("hfStudentName")).Value;
                    string book = ((HiddenField)row.FindControl("hfBookName")).Value; // I added book name back for the email body

                    // CALL THE GMAIL FUNCTION
                    bool success = SendGmail(email, name, book);

                    if (success)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Email Sent Successfully via Gmail!');", true);
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Failed to send email. Check App Password.');", true);
                    }
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error: " + ex.Message + "');", true);
                }
            }
        }

        // --- NEW GMAIL SMTP METHOD ---
        private bool SendGmail(string toEmail, string studentName, string bookName)
        {
            try
            {
                // ==================================================
                // 1. YOUR GMAIL CREDENTIALS
                // ==================================================
                string fromEmail = ConfigurationManager.AppSettings["GmailEmail"];
                string appPassword = ConfigurationManager.AppSettings["GmailAppPassword"]; // <--- PASTE YOUR 16-CHAR APP PASSWORD HERE
                // ==================================================

                MailMessage mail = new MailMessage();
                mail.From = new MailAddress(fromEmail, "CIME E-Library Management Team");
                mail.To.Add(toEmail);
                mail.Subject = "Library Book Overdue Alert";
                mail.IsBodyHtml = true;

                // HTML BODY
                mail.Body = $@"
                    <html>
                        <body style='font-family: Arial, sans-serif;'>
                            <h3 style='color: #d9534f;'>Overdue Book Alert</h3>
                            <p>Dear Student,</p>
                            <p>This is to inform you that the book issued to you is currently overdue.</p>
                            <p>Please return it to the library immediately to avoid late fines.</p>
                            <br>
                            <p>Regards,<br>CIME E-Library Management System</p>
                        </body>
                    </html>";

                // SMTP CONFIGURATION (Google Standard)
                SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
                smtp.EnableSsl = true;
                smtp.UseDefaultCredentials = false;
                smtp.Credentials = new NetworkCredential(fromEmail, appPassword);

                // SEND
                smtp.Send(mail);
                return true;
            }
            catch (Exception ex)
            {
                // Show specific error if it fails
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Gmail Error: " + ex.Message + "');", true);
                return false;
            }
        }
    }
}