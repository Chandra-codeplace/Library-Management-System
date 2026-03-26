using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LMS
{
    public partial class TotalBook : Page
    {
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
                    string query = "SELECT title, author, isbn, publisher FROM book";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        SqlDataAdapter sda = new SqlDataAdapter(cmd);
                        sda.Fill(dt);

                        if (!string.IsNullOrEmpty(txtSearch.Text))
                        {
                            DataView dataView = dt.DefaultView;
                            dataView.RowFilter = $"title LIKE '%{txtSearch.Text}%'";
                            GridView2.DataSource = dataView;
                        }
                        else
                        {
                            GridView2.DataSource = dt;
                        }

                        GridView2.DataBind();
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

        protected void lnlEdit_Click(object sender, EventArgs e)
        {
            btnSave.Visible = true;

            GridViewRow gvr = (GridViewRow)(((Control)sender).NamingContainer);
            txtTitle.Text = ((Label)gvr.FindControl("lblTitle")).Text;
            txtAuthor.Text = ((Label)gvr.FindControl("lblAuthor")).Text;
            txtISBN.Text = ((Label)gvr.FindControl("lblISBN")).Text;
            txtPublisher.Text = ((Label)gvr.FindControl("lblPublisher")).Text;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    using (SqlCommand cmd = new SqlCommand("UPDATEBOOKS", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@TITLE", txtTitle.Text.Trim());
                        cmd.Parameters.AddWithValue("@AUTHOR", txtAuthor.Text.Trim());
                        cmd.Parameters.AddWithValue("@ISBN", txtISBN.Text.Trim());
                        cmd.Parameters.AddWithValue("@PUBLISHER", txtPublisher.Text.Trim());

                        conn.Open();
                        int res = cmd.ExecuteNonQuery();

                        lblMsg.Text = res > 0 ? "Data updated successfully" : "Something went wrong";
                        BindGrid();
                    }
                }
                catch (Exception ex)
                {
                    lblMsg.Text = "Error: " + ex.Message;
                }
            }
        }

        protected void lnlDelete_Click(object sender, EventArgs e)
        {
            GridViewRow gvr = (GridViewRow)(((Control)sender).NamingContainer);
            string isbn = ((Label)gvr.FindControl("lblISBN")).Text;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    using (SqlCommand cmd = new SqlCommand("DELETE FROM book WHERE isbn = @isbn", conn))
                    {
                        cmd.Parameters.AddWithValue("@ISBN", isbn);

                        conn.Open();
                        int res = cmd.ExecuteNonQuery();

                        lblMsg.Text = res > 0 ? "Book deleted successfully" : "Something went wrong";
                        BindGrid();
                    }
                }
                catch (Exception ex)
                {
                    lblMsg.Text = "Error: " + ex.Message;
                }
            }
        }
    }
}
