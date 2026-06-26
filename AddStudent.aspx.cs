using System;
using System.Data.SqlClient;

namespace WebApplication1
{
    public partial class AddStudent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnAddStudent_Click(object sender, EventArgs e)
        {
            string sid = Request.Form["sid"];
            string sname = Request.Form["sname"];
            string email = Request.Form["email"];
            string password = Request.Form["password"];
            string scon_num = Request.Form["scon_num"];
            string address = Request.Form["address"];

            byte[] imageBytes = null;

            // ✅ GET IMAGE AS BYTE ARRAY
            if (studentPhoto.HasFile)
            {
                imageBytes = studentPhoto.FileBytes;
            }

            string connectionString = System.Configuration.ConfigurationManager
                .ConnectionStrings["LibreryDbConnection"].ConnectionString;

            string query = @"INSERT INTO student 
                            (sid, sname, email, password, scon_num, address, photo)
                            VALUES 
                            (@sid, @sname, @email, @password, @scon_num, @address, @photo)";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@sid", sid);
                    command.Parameters.AddWithValue("@sname", sname);
                    command.Parameters.AddWithValue("@email", email);
                    command.Parameters.AddWithValue("@password", password);
                    command.Parameters.AddWithValue("@scon_num", scon_num);
                    command.Parameters.AddWithValue("@address", address);

                    // ✅ STORE IMAGE IN DB
                    if (imageBytes != null)
                        command.Parameters.AddWithValue("@photo", imageBytes);
                    else
                        command.Parameters.AddWithValue("@photo", DBNull.Value);

                    try
                    {
                        connection.Open();
                        int result = command.ExecuteNonQuery();

                        if (result > 0)
                        {
                            lblMessage.Text = "Student added successfully!";
                            lblMessage.ForeColor = System.Drawing.Color.Green;
                        }
                        else
                        {
                            lblMessage.Text = "Failed to add student.";
                            lblMessage.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                    catch (Exception ex)
                    {
                        lblMessage.Text = "Error: " + ex.Message;
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                    }
                }
            }
        }
    }
}