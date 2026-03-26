using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LMS
{
    public partial class availablebook : Page
    {
        // SQL Server connection string
        private readonly string connectionString = "Data Source=LAPTOP-V7CL7PT7\\SQLEXPRESS; Initial Catalog=project; Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        private void BindGrid()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    DataTable dt = new DataTable();

                    string query = @"
                        SELECT bkid, title, author, isbn, publisher, availability
                        FROM book
                        WHERE (@title = '' OR title LIKE '%' + @title + '%')
                          AND (@isbn = '' OR isbn LIKE '%' + @isbn + '%')
                        ORDER BY bkid";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@title", txtSearchTitle.Text.Trim());
                        cmd.Parameters.AddWithValue("@isbn", txtSearchISBN.Text.Trim());

                        SqlDataAdapter sda = new SqlDataAdapter(cmd);
                        sda.Fill(dt);

                        GridViewBooks.DataSource = dt;
                        GridViewBooks.DataBind();
                    }
                }
                catch (Exception ex)
                {
                    lblMsg.Text = "Error: " + ex.Message;
                }
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindGrid();
        }

        // This formats the Availability column dynamically
        protected void GridViewBooks_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // 1. Get the availability status (Assuming 1 = Available, 0 = Not Available)
                // We use safe casting logic here to prevent crashes if DB value is null
                object availObj = DataBinder.Eval(e.Row.DataItem, "availability");

                // Convert to int first (safety check), then boolean
                bool isAvailable = false;
                if (availObj != DBNull.Value)
                {
                    // If your DB uses 1/0 for Bit/Int:
                    isAvailable = Convert.ToInt32(availObj) == 1;
                }

                // 2. Find the Cell where you want to show the status (Column Index 5)
                TableCell cell = e.Row.Cells[5];

                // 3. Set the Text and Color
                if (isAvailable)
                {
                    cell.Text = "<span class='badge bg-success'>Available</span>";
                    // Or simple style: "<span style='color:green;font-weight:bold;'>Available</span>"
                }
                else
                {
                    cell.Text = "<span class='badge bg-danger'>Not Available</span>";
                    // Or simple style: "<span style='color:red;font-weight:bold;'>Not Available</span>"
                }
            }
        }
    }
}
