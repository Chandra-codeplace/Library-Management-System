using System;
using System.Data.SqlClient;
using System.Configuration;

namespace WebApplication1
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSignIn_Click(object sender, EventArgs e)
        {
            string email = emailInput.Text.Trim();
            string password = passwordInput.Text.Trim();

            string connectionString = ConfigurationManager.ConnectionStrings["LibreryDbConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT Aname, aemail FROM admin WHERE aemail=@Email AND apassword=@Password";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Password", password);

                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        Session["AdminEmail"] = reader["aemail"].ToString();
                        Session["AdminName"] = reader["Aname"].ToString();
                        Response.Redirect("Admindashboard.aspx");
                    }
                    else
                    {
                       // lblMessage.Text = "Invalid Email or Password.";
                    }
                }
            }
        }
    }
}
