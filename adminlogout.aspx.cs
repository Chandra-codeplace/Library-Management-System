using System;
using System.Web;
using System.Web.UI;

namespace WebApplication1
{
    public partial class adminlogout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 1. Kill the specific Admin sessions
            Session.Remove("AdminName");
            Session.Remove("role");

            // 2. Abandon the entire session (Clear everything)
            Session.Abandon();
            Session.RemoveAll();

            // 3. Clear the Authentication Cookie (Important for security)
            if (Request.Cookies["ASP.NET_SessionId"] != null)
            {
                Response.Cookies["ASP.NET_SessionId"].Value = string.Empty;
                Response.Cookies["ASP.NET_SessionId"].Expires = DateTime.Now.AddMonths(-20);
            }

            // 4. Prevent the browser "Back" button from working
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();
            Response.Cache.SetExpires(DateTime.MinValue);

            // 5. Redirect to Home Page (WebForm1.aspx)
            Response.Redirect("WebForm1.aspx");
        }
    }
}