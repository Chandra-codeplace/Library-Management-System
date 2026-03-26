using System;
using System.Configuration;
using System.Data.SqlClient;

namespace WebApplication1
{
    public partial class Studentdashboard1 : System.Web.UI.Page
    {
        private readonly string connStr =
            ConfigurationManager.ConnectionStrings["LibreryDbConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblStudentName.Text = Convert.ToString(Session["StudentName"]);
                BindCounts();
            }
        }

        private string GetSid()
        {
            // Prefer session; fall back to cookie if you set it at login
            var sid = Convert.ToString(Session["sid"]);
            if (!string.IsNullOrWhiteSpace(sid)) return sid;

            var ck = Request.Cookies["student_sid"];
            if (ck != null && !string.IsNullOrWhiteSpace(ck.Value))
            {
                Session["sid"] = ck.Value;
                return ck.Value;
            }
            return null;
        }

        private void BindCounts()
        {
            string sid = GetSid();
            if (string.IsNullOrEmpty(sid))
            {
                lblBorrowedCount.Text = "0";
                lblPendingCount.Text = "0";
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();

                    // Total borrowed books for this student (dbo.borrow)
                    using (SqlCommand cmd = new SqlCommand(
                        "SELECT COUNT(*) FROM dbo.borrow WHERE sid=@sid;", con))
                    {
                        cmd.Parameters.AddWithValue("@sid", sid);
                        lblBorrowedCount.Text = Convert.ToString(cmd.ExecuteScalar());
                    }

                    // Pending requests for this student (dbo.bookrequest)
                    using (SqlCommand cmd = new SqlCommand(
                        "SELECT COUNT(*) FROM dbo.bookrequest WHERE sid=@sid AND status='pending';", con))
                    {
                        cmd.Parameters.AddWithValue("@sid", sid);
                        lblPendingCount.Text = Convert.ToString(cmd.ExecuteScalar());
                    }
                }
            }
            catch (Exception ex)
            {
                // Optional: display a friendly message or log the error
                // For now, keep counters as-is on error.
            }
        }
    }
}
