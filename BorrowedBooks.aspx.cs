using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication1;

namespace WebApplication1
{
    public partial class BorrowedBooks : System.Web.UI.Page
    {
        string strcon = ConfigurationManager.ConnectionStrings["LibreryDbConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["sid"] == null)
                {
                    Response.Redirect("Studentlogin.aspx");
                }
                else
                {
                    string loggedInSid = Session["sid"].ToString().Trim();
                    BindBorrowedBooksGrid(loggedInSid);
                }
            }
        }

        private void BindBorrowedBooksGrid(string studentID)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(strcon))
                {
                    if (con.State == ConnectionState.Closed) con.Open();

                    string query = @"
                        SELECT 
                            B.bid AS BorrowedID,      
                            B.bkid AS BookID,         
                            BK.title AS BookName,     
                            B.bdate AS BorrowedDate,  
                            B.returndt AS DueDate,
                            B.status AS Status,       
                            CASE 
                                WHEN GETDATE() > B.returndt AND B.status != 'Returned' THEN DATEDIFF(day, B.returndt, GETDATE()) * 10 
                                ELSE 0 
                            END AS FineAmount
                        FROM Borrow B
                        INNER JOIN book BK ON B.bkid = BK.bkid
                        WHERE B.sid = @student_id  
                        ORDER BY 
                            CASE WHEN B.status = 'Returned' THEN 1 ELSE 0 END, 
                            B.returndt ASC";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@student_id", studentID);
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvBorrowedBooks.DataSource = dt;
                        gvBorrowedBooks.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }

        protected void gvBorrowedBooks_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ReturnBook")
            {
                string borrowedID = e.CommandArgument.ToString();
                ReturnBookInDatabase(borrowedID);

                // Refresh Grid
                string loggedInSid = Session["sid"].ToString().Trim();
                BindBorrowedBooksGrid(loggedInSid);
            }
        }

        private void ReturnBookInDatabase(string borrowID)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(strcon))
                {
                    if (con.State == ConnectionState.Closed) con.Open();
                    string query = @"UPDATE Borrow SET status = 'Returned',returned_date = GETDATE() WHERE bid = @bid;  
                        UPDATE book
                        SET availability = 1
                        WHERE bkid = (SELECT bkid FROM Borrow WHERE bid = @bid);";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@bid", borrowID);
                        cmd.ExecuteNonQuery();
                    }
                }
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Book Returned Successfully!');", true);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }

        // --- HELPER METHODS (Ensure there is only ONE copy of each below) ---

        // 1. Get Status Color
        protected string GetStatusClass(object statusObj, object dueDateObj)
        {
            string status = statusObj?.ToString();
            if (status == "Returned") return "bg-secondary"; // Gray

            if (dueDateObj == null || dueDateObj == DBNull.Value) return "bg-warning";
            DateTime dueDate = Convert.ToDateTime(dueDateObj);
            return (dueDate < DateTime.Now) ? "bg-danger" : "bg-success";
        }

        // 2. Get Status Text
        protected string GetStatusText(object statusObj, object dueDateObj)
        {
            string status = statusObj?.ToString();
            if (status == "Returned") return "Returned";

            if (dueDateObj == null || dueDateObj == DBNull.Value) return "Unknown";
            DateTime dueDate = Convert.ToDateTime(dueDateObj);
            return (dueDate < DateTime.Now) ? "Overdue" : "Borrowed";
        }

        // 3. Check if Returnable (Hides button if already returned)
        protected bool IsReturnable(object statusObj)
        {
            string status = statusObj?.ToString();
            return status != "Returned";
        }
    }
}