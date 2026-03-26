using System;
using System.Data.SqlClient;
using System.Configuration;

namespace WebApplication1
{
    public partial class adminprofile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminEmail"] == null)
            {
                Response.Redirect("WebForm2.aspx");
            }
            else
            {
                LoadAdminProfile();
            }
        }

        private void LoadAdminProfile()
        {
            string email = Session["AdminEmail"].ToString();
            string connectionString = ConfigurationManager.ConnectionStrings["LibreryDbConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT Aname, aemail, acon_num, a_address FROM admin WHERE aemail=@Email";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        lblprofilename.Text = reader["Aname"].ToString();
                        lblProfileEmail.Text = reader["aemail"].ToString();
                        lblProfilePhone.Text = reader["acon_num"].ToString();
                        lblProfileAddress.Text = reader["a_address"].ToString();
                    }
                }
            }
        }
    }
}
