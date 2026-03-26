using System;
using System.Web;
using System.Web.UI;

namespace WebApplication1
{
    // IMPORTANT: The class name 'StudentLogout' must match the Inherits="" in your .aspx file
    // IMPORTANT: It must have ': System.Web.UI.Page' at the end
    public partial class StudentLogout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 1. Remove Student-specific session variables
            Session.Remove("sid");
            Session.Remove("role");

            // 2. Abandon the entire session
            Session.Abandon();
            Session.RemoveAll();

            // 3. Clear Authentication Cookie
            if (Request.Cookies["ASP.NET_SessionId"] != null)
            {
                Response.Cookies["ASP.NET_SessionId"].Value = string.Empty;
                Response.Cookies["ASP.NET_SessionId"].Expires = DateTime.Now.AddMonths(-20);
            }

            // 4. Disable Browser Cache
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();
            Response.Cache.SetExpires(DateTime.MinValue);

            // 5. Redirect to Home Page
            Response.Redirect("WebForm1.aspx");
        }
    }
}