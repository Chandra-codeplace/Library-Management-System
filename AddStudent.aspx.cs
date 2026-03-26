using System;
using System.Data.SqlClient;

namespace WebApplication1
{
    public partial class AddStudent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // This method is called when the page is loaded
        }

        protected void btnAddStudent_Click(object sender, EventArgs e)
        {
            // Retrieve form data
            string sid = Request.Form["sid"];
            string sname = Request.Form["sname"];
            string email = Request.Form["email"];
            string password = Request.Form["password"];
            string scon_num = Request.Form["scon_num"];
            string address = Request.Form["address"];

            // Define your connection string
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["LibreryDbConnection"].ConnectionString;

            // SQL query to insert data into the database
            string query = "INSERT INTO student (sid, sname, email, password, scon_num, address) VALUES (@sid, @sname, @email, @password, @scon_num, @address)";

            // Create a connection object
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // Create a command object
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Add parameters to the command
                    command.Parameters.AddWithValue("@sid", sid);
                    command.Parameters.AddWithValue("@sname", sname);
                    command.Parameters.AddWithValue("@email", email);
                    command.Parameters.AddWithValue("@password", password);
                    command.Parameters.AddWithValue("@scon_num", scon_num);
                    command.Parameters.AddWithValue("@address", address);

                    try
                    {
                        // Open the connection
                        connection.Open();

                        // Execute the command
                        int result = command.ExecuteNonQuery();

                        // Check if the insertion was successful
                        if (result > 0)
                        {
                            // Display success message
                            lblMessage.Text = "Student added successfully!";
                            lblMessage.ForeColor = System.Drawing.Color.Green;
                        }
                        else
                        {
                            // Display error message
                            lblMessage.Text = "Failed to add student.";
                            lblMessage.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                    catch (Exception ex)
                    {
                        // Display error message
                        lblMessage.Text = "Error: " + ex.Message;
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                    }
                    finally
                    {
                        // Close the connection
                        connection.Close();
                    }
                }
            }
        }
    }
}