using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class studentbookrequest: System.Web.UI.Page
    {
        // Uses your exact connection string name from web.config
        private readonly string connStr =
            ConfigurationManager.ConnectionStrings["LibreryDbConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Ensure your .aspx has Inherits="LMS.RequestBook"
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        // Load/Filter books into GridView
        private void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(@"
                SELECT 
                    ROW_NUMBER() OVER (ORDER BY b.title) AS SL,
                    b.bkid,
                    b.title,
                    b.author,
                    b.isbn,
                    b.publisher
                FROM dbo.book AS b
                WHERE (@t IS NULL OR b.title    LIKE @tLike)
                  AND (@a IS NULL OR b.author   LIKE @aLike)
                  AND (@i IS NULL OR b.isbn     LIKE @iLike)
                  AND (@p IS NULL OR b.publisher LIKE @pLike)
                ORDER BY b.title;", con))
            {
                string t = string.IsNullOrWhiteSpace(txtTitle.Text) ? null : txtTitle.Text.Trim();
                string a = string.IsNullOrWhiteSpace(txtAuthor.Text) ? null : txtAuthor.Text.Trim();
                string i = string.IsNullOrWhiteSpace(txtISBN.Text) ? null : txtISBN.Text.Trim();
                string p = string.IsNullOrWhiteSpace(txtPublisher.Text) ? null : txtPublisher.Text.Trim();

                cmd.Parameters.AddWithValue("@t", (object)t ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@a", (object)a ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@i", (object)i ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@p", (object)p ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@tLike", "%" + (t ?? "") + "%");
                cmd.Parameters.AddWithValue("@aLike", "%" + (a ?? "") + "%");
                cmd.Parameters.AddWithValue("@iLike", "%" + (i ?? "") + "%");
                cmd.Parameters.AddWithValue("@pLike", "%" + (p ?? "") + "%");

                con.Open();
                DataTable dt = new DataTable();
                dt.Load(cmd.ExecuteReader());
                gvBooks.DataSource = dt;
                gvBooks.DataBind();
            }
        }

        // Search button
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindGrid();
        }

        // Clear button
        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtTitle.Text = txtAuthor.Text = txtISBN.Text = txtPublisher.Text = string.Empty;
            BindGrid();
        }

        // Paging
        protected void gvBooks_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvBooks.PageIndex = e.NewPageIndex;
            BindGrid();
        }
        private string GetSid()
        {
            var sid = Convert.ToString(Session["sid"]);
            if (!string.IsNullOrWhiteSpace(sid)) return sid;

            var ck = Request.Cookies["student_sid"];
            if (ck!= null && !string.IsNullOrWhiteSpace(ck.Value))
            {
                Session["sid"]= ck.Value;
                return ck.Value;
            }
            return null;
        }

        // Request button from each row
        protected void gvBooks_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "Req") return;

            string sid = GetSid(); // set this at login
            if (string.IsNullOrEmpty(sid))
            {
                ShowError("Cannot determine student id.");
                return;
            }

            int bkid;
            if (!int.TryParse(Convert.ToString(e.CommandArgument), out bkid))
            {
                ShowError("Invalid book id.");
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                using (SqlCommand cmd = new SqlCommand(@"
                    INSERT INTO dbo.bookrequest (bkid, sid, requestedat, status)
                    VALUES (@bkid, @sid, SYSDATETIME(), 'pending');", con))
                {
                    cmd.Parameters.Add("@bkid", SqlDbType.Int).Value = bkid;
                    cmd.Parameters.Add("@sid", SqlDbType.VarChar, 50).Value = sid;
                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                ShowSuccess("Request submitted.");
            }
            catch (SqlException ex)
            {
                // If FK constraints fail or duplicate requests are not allowed, message will show here
                ShowError("Could not submit request: " + ex.Message);
            }
        }

        // Helpers
        private void ShowSuccess(string m)
        {
            lblMsg.CssClass = "msg text-success";
            lblMsg.Text = m;
        }
        private void ShowError(string m)
        {
            lblMsg.CssClass = "msg text-danger";
            lblMsg.Text = m;
        }
    }
}
