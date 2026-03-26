using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class TrackBooks : System.Web.UI.Page
    {
        string strcon = ConfigurationManager.ConnectionStrings["LibreryDbConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindBookData();
            }
        }

        // Search Button Click
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindBookData();
        }

        private void BindBookData()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(strcon))
                {
                    if (con.State == ConnectionState.Closed) con.Open();

                    // --- THE LOGIC ---
                    // 1. SELECT all columns from 'book'
                    // 2. LEFT JOIN 'Borrow' to find if anyone has it right now (Status != Returned)
                    // 3. LEFT JOIN 'student' to get the name of that person

                    string query = @"
                        SELECT 
                            BK.bkid,
                            BK.title,
                            BK.author,
                            -- BK.book_img,  <-- Uncomment if you have this column
                            
                            -- Logic: If the join finds a Student ID, the book is 'Issued', else 'Available'
                            CASE 
                                WHEN S.sname IS NOT NULL THEN 'Issued' 
                                ELSE 'Available' 
                            END AS StatusText,

                            S.sname AS StudentName,
                            S.sid AS StudentID,
                            B.bdate AS BorrowDate,
                            B.returndt AS ReturnDate

                        FROM book BK
                        -- Join only with ACTIVE borrow records (Not returned yet)
                        LEFT JOIN Borrow B ON BK.bkid = B.bkid AND (B.status IS NULL OR B.status != 'Returned')
                        LEFT JOIN student S ON B.sid = S.sid

                        WHERE 
                            (@SearchText = '' OR BK.title LIKE '%' + @SearchText + '%' OR CAST(BK.bkid AS NVARCHAR) = @SearchText)
                        
                        ORDER BY BK.bkid ASC";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        // Add Search Parameter (If textbox is empty, it shows all)
                        cmd.Parameters.AddWithValue("@SearchText", txtSearch.Text.Trim());

                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);
                            gvBookStatus.DataSource = dt;
                            gvBookStatus.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }
    }
}