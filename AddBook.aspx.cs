using System;
using System.Data.SqlClient;

namespace WebApplication1
{
    public partial class AddBook : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // This method is called when the page is loaded
        }

        protected void btnAddBook_Click(object sender, EventArgs e)
        {
            // Retrieve form data
            string title = Request.Form["title"];
            string author = Request.Form["author"];
            string publisher = Request.Form["publisher"];
            string isbn = Request.Form["isbn"];
            string pubyrStr = Request.Form["pubyr"];
            string availability = Request.Form["availability"]; // Expected values: "yes" or "no"

            // Convert availability to bit (1 for "yes", 0 for "no")
            int availabilityBit = (availability == "yes") ? 1 : 0;

            // Validate publication year
            if (DateTime.TryParse(pubyrStr, out DateTime pubyr))
            {
                // Define your connection string
                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["LibreryDbConnection"].ConnectionString;

                // SQL query to insert data into the database
                string query = "INSERT INTO book (title, author, publisher, isbn, pub_year, availability) " +
                               "VALUES (@title, @author, @publisher, @isbn, @pub_year, @availability)";

                // Create a connection object
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    // Create a command object
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        // Add parameters to the command
                        command.Parameters.AddWithValue("@title", title);
                        command.Parameters.AddWithValue("@author", author);
                        command.Parameters.AddWithValue("@publisher", publisher);
                        command.Parameters.AddWithValue("@isbn", isbn);
                        command.Parameters.AddWithValue("@pub_year", pubyr);
                        command.Parameters.AddWithValue("@availability", availabilityBit);

                        try
                        {
                            // Open the connection
                            connection.Open();

                            // Execute the command
                            int result = command.ExecuteNonQuery();

                            // Check if the insertion was successful
                            if (result > 0)
                            {
                                lblMessage.Text = "Book added successfully!";
                                lblMessage.ForeColor = System.Drawing.Color.Green;
                            }
                            else
                            {
                                lblMessage.Text = "Failed to add book.";
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
            else
            {
                // Display invalid year format error
                lblMessage.Text = "Invalid publication year format.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}
