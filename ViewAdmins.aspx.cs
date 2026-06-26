using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class ViewAdmins : Page
    {
        string strcon = ConfigurationManager.ConnectionStrings["LibreryDbConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        private void BindGrid(string search = "")
        {
            try
            {
                using (SqlConnection con = new SqlConnection(strcon))
                {
                    string query = "SELECT Aname, aemail, acon_num, a_address, agender, Photo FROM admin";

                    if (!string.IsNullOrEmpty(search))
                    {
                        query += " WHERE Aname LIKE @search OR aemail LIKE @search";
                    }

                    SqlCommand cmd = new SqlCommand(query, con);
                    if (!string.IsNullOrEmpty(search))
                    {
                        cmd.Parameters.AddWithValue("@search", "%" + search + "%");
                    }

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvAdmins.DataSource = dt;
                    gvAdmins.DataBind();
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }

        // --- SEARCH ACTIONS ---
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindGrid(txtSearch.Text.Trim());
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            BindGrid();
        }

        // --- GRIDVIEW EDITING ---
        protected void gvAdmins_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvAdmins.EditIndex = e.NewEditIndex;
            BindGrid(txtSearch.Text.Trim());
        }

        protected void gvAdmins_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvAdmins.EditIndex = -1;
            BindGrid(txtSearch.Text.Trim());
        }

        protected void gvAdmins_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            // Retrieve Email (Primary Key)
            string email = gvAdmins.DataKeys[e.RowIndex].Value.ToString();

            // Find Controls
            GridViewRow row = gvAdmins.Rows[e.RowIndex];
            string name = ((TextBox)row.FindControl("txtEditName")).Text;
            string contact = ((TextBox)row.FindControl("txtEditCon")).Text;
            string address = ((TextBox)row.FindControl("txtEditAddress")).Text;
            string gender = ((DropDownList)row.FindControl("ddlEditGender")).SelectedValue;

            using (SqlConnection con = new SqlConnection(strcon))
            {
                string query = "UPDATE admin SET Aname=@name, acon_num=@con, a_address=@addr, agender=@gen WHERE aemail=@email";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@name", name);
                cmd.Parameters.AddWithValue("@con", contact);
                cmd.Parameters.AddWithValue("@addr", address);
                cmd.Parameters.AddWithValue("@gen", gender);
                cmd.Parameters.AddWithValue("@email", email);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            gvAdmins.EditIndex = -1;
            BindGrid(txtSearch.Text.Trim());
        }

        protected void gvAdmins_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string email = gvAdmins.DataKeys[e.RowIndex].Value.ToString();

            using (SqlConnection con = new SqlConnection(strcon))
            {
                string query = "DELETE FROM admin WHERE aemail=@email";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@email", email);

                con.Open();
                cmd.ExecuteNonQuery();
            }
            BindGrid(txtSearch.Text.Trim());
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
            return "https://via.placeholder.com/50";
        }
    }
}