using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace WebApplication1
{
    public partial class AddNotice : System.Web.UI.Page
    {
        string strcon = ConfigurationManager.ConnectionStrings["LibreryDbConnection"].ConnectionString;

        protected void btnPostNotice_Click(object sender, EventArgs e)
        {
            try
            {
                string fileName = ""; // Default empty string if no PDF is uploaded

                // 1. Handle the File Upload
                if (fuNotice.HasFile)
                {
                    string ext = System.IO.Path.GetExtension(fuNotice.FileName).ToLower();

                    // Safety check: Only allow PDFs
                    if (ext == ".pdf")
                    {
                        // Generate a unique filename using Ticks
                        fileName = DateTime.Now.Ticks.ToString() + "_" + fuNotice.FileName;

                        // Find the physical path of your folder
                        string folderPath = Server.MapPath("~/UploadedNotices/");

                        // Create the folder if it doesn't exist
                        if (!System.IO.Directory.Exists(folderPath))
                        {
                            System.IO.Directory.CreateDirectory(folderPath);
                        }

                        // Save the file to the folder
                        fuNotice.SaveAs(folderPath + fileName);
                    }
                    else
                    {
                        lblMessage.Text = "⚠️ Only PDF files are allowed!";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                        return; // Stop the code here
                    }
                }

                // 2. Save Data to SQL Server
                using (SqlConnection con = new SqlConnection(strcon))
                {
                    // Note: We added @pdf to the query
                    string query = "INSERT INTO Notice (title, content, pdf_file, date_added) " +
                                   "VALUES (@title, @content, @pdf, GETDATE())";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@title", txtTitle.Text.Trim());
                    cmd.Parameters.AddWithValue("@content", txtContent.Text.Trim());

                    // If no file was uploaded, this will be an empty string
                    cmd.Parameters.AddWithValue("@pdf", fileName);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();

                    lblMessage.Text = "✅ Notice Published Successfully!";
                    lblMessage.ForeColor = System.Drawing.Color.Green;

                    // Clear the form
                    txtTitle.Text = "";
                    txtContent.Text = "";
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "❌ Error: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}