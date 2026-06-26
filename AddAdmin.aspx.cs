using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Text.RegularExpressions;

namespace WebApplication1
{
    public partial class AddAdmin : System.Web.UI.Page
    {
        // Ensure your Web.config has a connection string named "con"
        string strcon = ConfigurationManager.ConnectionStrings["LibreryDbConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Clear message on first load
            if (!IsPostBack)
            {
                lblMessage.Text = "";
            }
        }

        protected void btnAddAdmin_Click(object sender, EventArgs e)
        {
            if (ValidateForm())
            {
                SaveAdminData();
            }
        }

        // Logic for the Show Data button
        protected void btnShowData_Click(object sender, EventArgs e)
        {
            Response.Redirect("ViewAdmins.aspx"); // Replace with your actual data display page name
        }

        private bool ValidateForm()
        {
            // 1. Password Strength Check
            // Rule: Min 8 chars, 1 Uppercase, 1 Lowercase, 1 Number, 1 Special Character
            string password = txtApassword.Text.Trim();
            var passwordRegex = new Regex(@"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");

            if (!passwordRegex.IsMatch(password))
            {
                ShowError("Password must be at least 8 characters long and include uppercase, lowercase, a number, and a special character.");
                return false;
            }

            // 2. Photo Validation
            if (!fuPhoto.HasFile)
            {
                ShowError("Please upload a profile photo.");
                return false;
            }
            else
            {
                // Rule: Under 50 KB (50 * 1024 bytes = 51200)
                int maxFileSize = 50 * 1024;
                if (fuPhoto.PostedFile.ContentLength > maxFileSize)
                {
                    ShowError("Photo size must be under 50 KB. Your file is " + (fuPhoto.PostedFile.ContentLength / 1024) + " KB.");
                    return false;
                }

                // Check extension
                string ext = Path.GetExtension(fuPhoto.FileName).ToLower();
                if (ext != ".jpg" && ext != ".png" && ext != ".jpeg")
                {
                    ShowError("Only JPG, JPEG, or PNG files are allowed.");
                    return false;
                }
            }

            return true;
        }

        private void SaveAdminData()
        {
            try
            {
                // Convert photo to byte array (varbinary)
                byte[] imgBytes;
                using (BinaryReader br = new BinaryReader(fuPhoto.PostedFile.InputStream))
                {
                    imgBytes = br.ReadBytes(fuPhoto.PostedFile.ContentLength);
                }

                using (SqlConnection con = new SqlConnection(strcon))
                {
                    if (con.State == ConnectionState.Closed) con.Open();

                    string query = "INSERT INTO admin (Aname, aemail, apassword, acon_num, a_address, agender, Photo) " +
                                   "VALUES (@Aname, @aemail, @apassword, @acon_num, @a_address, @agender, @Photo)";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@Aname", txtAname.Text.Trim());
                    cmd.Parameters.AddWithValue("@aemail", txtAemail.Text.Trim());
                    cmd.Parameters.AddWithValue("@apassword", txtApassword.Text.Trim());
                    cmd.Parameters.AddWithValue("@acon_num", Convert.ToInt64(txtAcon_num.Text.Trim()));
                    cmd.Parameters.AddWithValue("@a_address", txtAaddress.Text.Trim());
                    cmd.Parameters.AddWithValue("@agender", rbGender.SelectedValue);
                    cmd.Parameters.AddWithValue("@Photo", imgBytes);

                    int result = cmd.ExecuteNonQuery();
                    con.Close();

                    if (result > 0)
                    {
                        // Redirect on success
                        Response.Redirect("ViewAdmins.aspx");
                    }
                }
            }
            catch (Exception ex)
            {
                ShowError("Database Error: " + ex.Message);
            }
        }

        private void ShowError(string msg)
        {
            lblMessage.Text = "⚠️ " + msg;
            lblMessage.ForeColor = System.Drawing.Color.Red;
        }
    }
}