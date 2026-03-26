using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace WebApplication1

{
    public partial class adminbookreqandissue : System.Web.UI.Page
    {
        private readonly string connStr =
            ConfigurationManager.ConnectionStrings["LibreryDbConnection"].ConnectionString;
        

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadGrid();
            }
        }

        private void LoadGrid()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(@"
                SELECT br.requestid, br.sid, br.bkid, br.requestedat, b.title
                FROM dbo.bookrequest AS br
                INNER JOIN dbo.book AS b ON b.bkid = br.bkid
                WHERE br.status = 'pending'
                  AND (@q IS NULL OR b.title LIKE @qLike OR br.sid LIKE @qLike)
                ORDER BY br.requestedat DESC;", con))
            {
                string q = string.IsNullOrWhiteSpace(txtSearch.Text) ? null : txtSearch.Text.Trim();
                cmd.Parameters.AddWithValue("@q", (object)q ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@qLike", "%" + (q ?? "") + "%");

                con.Open();
                DataTable dt = new DataTable();
                using (SqlDataReader rdr = cmd.ExecuteReader())
                {
                    dt.Load(rdr);
                }
                gvRequests.DataSource = dt;
                gvRequests.DataBind();

                // Toggle external empty panel (avoids GridView template parser issues)
                pnlEmpty.Visible = (gvRequests.Rows.Count == 0);
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e) => LoadGrid();

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            LoadGrid();
        }

        protected void gvRequests_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvRequests.PageIndex = e.NewPageIndex;
            LoadGrid();
        }

        protected void gvRequests_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            lblMsg.Text = "";
            if (e.CommandName == "Approve")
            {
                var parts = Convert.ToString(e.CommandArgument).Split('|');
                int requestid = int.Parse(parts[0]);
                string sid = parts[1];
                int bkid = int.Parse(parts[2]);

                ApproveRequest(requestid, sid, bkid);
                LoadGrid();
            }
            else if (e.CommandName == "Reject")
            {
                int requestid = int.Parse(Convert.ToString(e.CommandArgument));
                RejectRequest(requestid);
                LoadGrid();
            }
        }

        private void ApproveRequest(int requestid, string sid, int bkid)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();
                    using (SqlTransaction tx = con.BeginTransaction())
                    {
                        // Ensure request still pending
                        using (SqlCommand c1 = new SqlCommand(
                            "SELECT COUNT(*) FROM dbo.bookrequest WHERE requestid=@rid AND status='pending';", con, tx))
                        {
                            c1.Parameters.AddWithValue("@rid", requestid);
                            if ((int)c1.ExecuteScalar() == 0)
                            {
                                lblMsg.Text = "Request already processed.";
                                tx.Rollback();
                                return;
                            }
                        }

                        // Check availability
                        bool available;
                        using (SqlCommand c2 = new SqlCommand(
                            "SELECT availability FROM dbo.book WHERE bkid=@bkid;", con, tx))
                        {
                            c2.Parameters.AddWithValue("@bkid", bkid);
                            object v = c2.ExecuteScalar();
                            if (v == null)
                            {
                                lblMsg.Text = "Book not found.";
                                tx.Rollback();
                                return;
                            }
                            available = Convert.ToBoolean(v);
                        }
                        if (!available)
                        {
                            lblMsg.Text = "Book is not available.";
                            tx.Rollback();
                            return;
                        }

                        // Next borrow.bid (no identity)
                        int nextBid;
                        using (SqlCommand c3 = new SqlCommand("SELECT ISNULL(MAX(bid),0) FROM dbo.borrow;", con, tx))
                        {
                            nextBid = Convert.ToInt32(c3.ExecuteScalar()) + 1;
                        }

                        // Insert into borrow
                        using (SqlCommand c4 = new SqlCommand(@"
                            INSERT INTO dbo.borrow (bid, sid, bkid, bdate, returndt)
                            VALUES (@bid, @sid, @bkid, CAST(GETDATE() AS date), DATEADD(day,14, CAST(GETDATE() AS date)));", con, tx))
                        {
                            c4.Parameters.AddWithValue("@bid", nextBid);
                            c4.Parameters.AddWithValue("@sid", sid);
                            c4.Parameters.AddWithValue("@bkid", bkid);
                            c4.ExecuteNonQuery();
                        }

                        // Set book unavailable
                        using (SqlCommand c5 = new SqlCommand(
                            "UPDATE dbo.book SET availability = 0 WHERE bkid=@bkid;", con, tx))
                        {
                            c5.Parameters.AddWithValue("@bkid", bkid);
                            c5.ExecuteNonQuery();
                        }

                        // Mark request approved
                        using (SqlCommand c6 = new SqlCommand(
                            "UPDATE dbo.bookrequest SET status='approved' WHERE requestid=@rid;", con, tx))
                        {
                            c6.Parameters.AddWithValue("@rid", requestid);
                            c6.ExecuteNonQuery();
                        }

                        tx.Commit();
                        lblMsg.Style["color"] = "#0b5ed7"; // blue
                        lblMsg.Text = $"Approved. Borrow ID {nextBid}.";
                    }
                }
            }
            catch (SqlException ex)
            {
                lblMsg.Style["color"] = "#c02d3c";
                lblMsg.Text = "SQL error: " + ex.Message;
            }
            catch (Exception ex)
            {
                lblMsg.Style["color"] = "#c02d3c";
                lblMsg.Text = "Error: " + ex.Message;
            }
        }

        private void RejectRequest(int requestid)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                using (SqlCommand cmd = new SqlCommand(
                    "UPDATE dbo.bookrequest SET status='rejected' WHERE requestid=@rid AND status='pending';", con))
                {
                    cmd.Parameters.AddWithValue("@rid", requestid);
                    con.Open();
                    int rows = cmd.ExecuteNonQuery();
                    if (rows == 1)
                    {
                        lblMsg.Style["color"] = "#f3c815"; // yellow
                        lblMsg.Text = "Request rejected.";
                    }
                    else
                    {
                        lblMsg.Style["color"] = "#a56a00";
                        lblMsg.Text = "Request already processed.";
                    }
                }
            }
            catch (SqlException ex)
            {
                lblMsg.Style["color"] = "#c02d3c";
                lblMsg.Text = "SQL error: " + ex.Message;
            }
        }
    }
}
