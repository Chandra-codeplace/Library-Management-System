using System;
using System.Configuration;
using System.Data.SqlClient;

namespace WebApplication1
{
    public partial class adminregistration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Optional: Code to handle Page Load
        }

        protected void RegisterAdmin_Click(object sender, EventArgs e)
        {
            // Retrieve the form field values
            string nameValue = name.Text.Trim();
            string emailValue = email.Text.Trim();
            string passValue = pass.Text.Trim();
            string mobnoValue = mobno.Text.Trim();
            string addressValue = address.Text.Trim();
            string gender = "";

            // Validate the form inputs
            if (string.IsNullOrWhiteSpace(nameValue) ||
                string.IsNullOrWhiteSpace(emailValue) ||
                string.IsNullOrWhiteSpace(passValue) ||
                string.IsNullOrWhiteSpace(mobnoValue) ||
                string.IsNullOrWhiteSpace(addressValue))
            {
                lblMessage.Text = "All fields are required.";
                return;
            }

            if (!femaleGender.Checked && !maleGender.Checked && !otherGender.Checked)
            {
                lblMessage.Text = "Please select a gender.";
                return;
            }

            // Determine the selected gender
            if (femaleGender.Checked)
            {
                gender = "Female";
            }
            else if (maleGender.Checked)
            {
                gender = "Male";
            }
            else if (otherGender.Checked)
            {
                gender = "Other";
            }

            // Database operation
            try
            {
                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["LibreryDbConnection"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "INSERT INTO admin (Aname, aemail, apassword, acon_num, a_address, agender) " +
                                   "VALUES (@Aname, @aemail, @apassword, @acon_num, @a_address, @agender)";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Aname", nameValue);
                        cmd.Parameters.AddWithValue("@aemail", emailValue);
                        cmd.Parameters.AddWithValue("@apassword", passValue);
                        cmd.Parameters.AddWithValue("@acon_num", mobnoValue);
                        cmd.Parameters.AddWithValue("@a_address", addressValue);
                        cmd.Parameters.AddWithValue("@agender", gender);

                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            lblMessage.ForeColor = System.Drawing.Color.Green;
                            lblMessage.Text = "Registration successful!";
                        }
                        else
                        {
                            lblMessage.Text = "Registration failed. Please try again.";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
            }

            // Clear the password field after submission
            pass.Text = string.Empty;
        }

    }
}
