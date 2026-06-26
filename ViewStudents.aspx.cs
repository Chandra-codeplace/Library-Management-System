using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class ViewStudents : Page
    {
        string strcon = ConfigurationManager.ConnectionStrings["LibreryDbConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindStudentGrid();
            }
        }

        // Modified Bind method to support searching
        private void BindStudentGrid(string searchTerm = "")
        {
            try
            {
                using (SqlConnection con = new SqlConnection(strcon))
                {
                    string query = "SELECT sid, sname, email, scon_num, address, Photo FROM student";

                    // Apply filtering if search term exists
                    if (!string.IsNullOrEmpty(searchTerm))
                    {
                        query += " WHERE sname LIKE @search OR sid LIKE @search";
                    }

                    SqlCommand cmd = new SqlCommand(query, con);
                    if (!string.IsNullOrEmpty(searchTerm))
                    {
                        cmd.Parameters.AddWithValue("@search", "%" + searchTerm + "%");
                    }

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvStudents.DataSource = dt;
                    gvStudents.DataBind();
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindStudentGrid(txtSearch.Text.Trim());
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            BindStudentGrid();
        }

        // --- GRIDVIEW EVENTS (EDIT, UPDATE, DELETE, CANCEL) ---

        protected void gvStudents_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvStudents.EditIndex = e.NewEditIndex;
            BindStudentGrid(txtSearch.Text.Trim());
        }

        protected void gvStudents_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvStudents.EditIndex = -1;
            BindStudentGrid(txtSearch.Text.Trim());
        }

        protected void gvStudents_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string studentId = gvStudents.DataKeys[e.RowIndex].Value.ToString();
            GridViewRow row = gvStudents.Rows[e.RowIndex];

            string newName = ((TextBox)row.FindControl("txtEditName")).Text;
            string newEmail = ((TextBox)row.FindControl("txtEditEmail")).Text;
            string newCon = ((TextBox)row.FindControl("txtEditCon")).Text;
            string newAddress = ((TextBox)row.FindControl("txtEditAddress")).Text;

            using (SqlConnection con = new SqlConnection(strcon))
            {
                string query = "UPDATE student SET sname=@name, email=@email, scon_num=@con, address=@addr WHERE sid=@sid";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@name", newName);
                cmd.Parameters.AddWithValue("@email", newEmail);
                cmd.Parameters.AddWithValue("@con", newCon);
                cmd.Parameters.AddWithValue("@addr", newAddress);
                cmd.Parameters.AddWithValue("@sid", studentId);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

            gvStudents.EditIndex = -1;
            BindStudentGrid(txtSearch.Text.Trim());
        }

        protected void gvStudents_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string studentId = gvStudents.DataKeys[e.RowIndex].Value.ToString();

            using (SqlConnection con = new SqlConnection(strcon))
            {
                string query = "DELETE FROM student WHERE sid=@sid";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@sid", studentId);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
            BindStudentGrid(txtSearch.Text.Trim());
        }

        // --- PHOTO HELPER ---
        public string GetImage(object imgData)
        {
            if (imgData != null && imgData != DBNull.Value)
            {
                byte[] bytes = (byte[])imgData;
                string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);
                return "data:image/png;base64," + base64String;
            }
            return "https://www.w3schools.com/howto/img_avatar.png";
        }
    }
}