using System;
using System.Configuration;
using System.Data.SqlClient;

namespace WebApplication1
{
    public partial class Admindashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDashboardStats(); 
                if (Session["AdminName"] != null)
                {
                    lblAdminName.Text = Session["AdminName"].ToString();
                    lblAdminNameContent.Text = Session["AdminName"].ToString();
                }
                else
                {
                    Response.Redirect("Login.aspx"); // Redirect to login if session expired
                }
            }
        }

        private void LoadDashboardStats()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LibreryDbConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    // Get Total Students
                    using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM student", conn))
                    {
                        int StudentCount = (int)cmd.ExecuteScalar();
                        lblTotalStudents.Text = cmd.ExecuteScalar().ToString();
                        Response.Write("Total Books: " + StudentCount);
                    }

                    // Get Total Books
                    using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM book", conn))
                    {
                        int bookCount = (int)cmd.ExecuteScalar(); 
                        lblTotalBooks.Text = cmd.ExecuteScalar().ToString();
                        Response.Write("Total Books: " + bookCount);
                    }

                    // Get Total Issued Books
                    using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Borrow", conn))
                    {

                        int IssuebookCount = (int)cmd.ExecuteScalar(); 
                        lblIssuedBooks.Text = cmd.ExecuteScalar().ToString();
                        Response.Write("Total Books: " + IssuebookCount);
                    }

                    // Get Total Reservations
                    //using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM reservation", conn))
                    //{
                    //    int ReservationCount = (int)cmd.ExecuteScalar();
                    //    lblTotalReservations.Text = cmd.ExecuteScalar().ToString();
                    //    Response.Write("Total Books: " + ReservationCount);
                    //}
                }
                catch (Exception ex)
                {
                    // Log error (Optional: Use logging framework)
                    Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
                }
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Logout logic
            Session.Abandon();
            Response.Redirect("WebForm1.aspx");
        }
    }
}
