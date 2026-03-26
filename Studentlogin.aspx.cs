using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;

namespace WebApplication1
{
    public partial class Studentlogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            passwordInput.Attributes["value"] = passwordInput.Text;
        }

        protected void btnSignIn_Click(object sender, EventArgs e)
        {
            string email = emailInput.Text.Trim();
            string password = passwordInput.Text.Trim();

            if (string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(password))
            {
                // Show message on page
                Response.Write("<div style='color:red;'>Please enter both email and password.</div>");
                return;
            }

            string connectionString =
                ConfigurationManager.ConnectionStrings["LibreryDbConnection"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Case-insensitive for email, trim spaces for both
                    const string sql = @"
                        SELECT sid,sname, email, password
                        FROM student
                        WHERE LTRIM(RTRIM(email)) = LTRIM(RTRIM(@Email))
                          AND LTRIM(RTRIM(password)) = LTRIM(RTRIM(@Password));";

                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Password", password);

                        using (SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.SingleRow))
                        {
                            if (reader.Read())
                            {
                                string sid = reader["sid"].ToString();
                                Session["sid"] = sid;
                                Session["StudentName"] = reader["sname"].ToString();
                                Session["StudentEmail"] = reader["email"].ToString();
                                Session["StudentPassword"] = reader["password"].ToString();

                                var ck = new HttpCookie("student_sid", sid) { HttpOnly = true, Expires = DateTime.Now.AddDays(7) };
                                Response.Cookies.Add(ck);

                                // Proper redirect
                                Response.Redirect("~/studentdashboard1.aspx", false);
                                Context.ApplicationInstance.CompleteRequest();
                                return;
                            }
                            else
                            {
                                Response.Write("<div style='color:red;'>Invalid email or password.</div>");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<div style='color:red;'>Error: " + ex.Message + "</div>");
            }
        }
    }
}
