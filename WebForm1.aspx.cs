using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace WebApplication1
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        // --- 1. DECLARE VARIABLES AT CLASS LEVEL ---
        public int mba = 0, mca = 0, other = 0, avail = 0, issued = 0;
        public string latestTitle = "", latestContent = "";

        string strcon = ConfigurationManager.ConnectionStrings["LibreryDbConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e) //object sender--who triggered the event , 
        {
            if (!IsPostBack)
            {
                LoadDashboardData();
            }
        }

        private void LoadDashboardData()
        {
            using (SqlConnection con = new SqlConnection(strcon))
            {
                try
                {
                    con.Open();

                    // --- 2. FETCH CHART DATA ---
                    mba = GetScalarValue(con, "SELECT COUNT(*) FROM book WHERE course='MBA'");
                    mca = GetScalarValue(con, "SELECT COUNT(*) FROM book WHERE course='MCA'");
                    other = GetScalarValue(con, "SELECT COUNT(*) FROM book WHERE course='Other'");

                    // Fetch Availability Data (Using 1 and 0 for SQL BIT type)
                    avail = GetScalarValue(con, "SELECT COUNT(*) FROM book WHERE availability=1");
                    issued = GetScalarValue(con, "SELECT COUNT(*) FROM book WHERE availability=0");

                    // --- 3. POPULATE REPEATER ---
                    SqlDataAdapter da = new SqlDataAdapter("SELECT TOP 10 title, date_added, pdf_file FROM Notice ORDER BY id DESC", con);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    rptNotices.DataSource = dt;
                    rptNotices.DataBind();

                    // --- 4. FETCH POPUP DATA (WITH JS ESCAPING FIX) ---
                    SqlCommand cmd = new SqlCommand("SELECT TOP 1 title, content FROM Notice ORDER BY id DESC", con);
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        // Safely escape backslashes, single quotes, and multi-line breaks for JavaScript
                        latestTitle = dr["title"].ToString()
                            .Replace("\\", "\\\\")  // Escape backslashes first
                            .Replace("'", "\\'")    // Escape single quotes
                            .Replace("\r", "")      // Remove carriage returns
                            .Replace("\n", "\\n");  // Convert newlines to JS safe newlines

                        latestContent = dr["content"].ToString()
                            .Replace("\\", "\\\\")

                            .Replace("'", "\\'")
                            .Replace("\r", "")
                            .Replace("\n", "\\n");
                    }
                    dr.Close();
                }
                catch (Exception ex)
                {
                    Response.Write("<script>console.log('Error: " + ex.Message + "');</script>");
                }
            }
        }

        // --- 5. STANDARDIZED HELPER METHOD ---
        private int GetScalarValue(SqlConnection con, string query)
        {
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                object val = cmd.ExecuteScalar();
                return (val == null || val == DBNull.Value) ? 0 : Convert.ToInt32(val);
            }
        }
    }
}