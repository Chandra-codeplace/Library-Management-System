using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplication1
{
    public partial class Admindashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["AdminName"] != null)
                {
                    lblAdminName.Text = Session["AdminName"].ToString();
                    LoadDashboardStats();
                }
                else
                {
                    Response.Redirect("Login.aspx");
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

                    // Total Students
                    using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM student", conn))
                    {
                        lblTotalStudents.Text = cmd.ExecuteScalar().ToString();
                    }

                    // Total Books
                    using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM book", conn))
                    {
                        lblTotalBooks.Text = cmd.ExecuteScalar().ToString();
                    }

                    // Total Issued Books
                    using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Borrow", conn))
                    {
                        lblIssuedBooks.Text = cmd.ExecuteScalar().ToString();
                    }
                }
                catch (Exception ex)
                {
                    // Shows error as a popup instead of breaking layout
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Error loading stats: " + ex.Message + "');", true);
                }
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Session.Clear();
            Response.Redirect("adminlogout.aspx"); // Aligned with your login redirect
        }
    }
}