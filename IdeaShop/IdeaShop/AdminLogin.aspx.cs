using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static IdeaShop.SqlJacknife;

namespace IdeaShop
{
    public partial class AdminLogin : System.Web.UI.Page
    {
        IdeaHeaderAndSide master;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (master == null){
                master = (IdeaHeaderAndSide)this.Master;
            }
            if(master.userIsAdmin())
            {
                Response.Redirect("default.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            
            try
            {
                
                
                DataTable dt = LoginTry(txtEmail.Text.Trim(), txtPassword.Text.Trim());

                Session.Add("IsAdmin", "1");
                Session.Add("ID_Adm", dt.Rows[0]["ID_Adm"].ToString());
                Session.Add("Email", dt.Rows[0]["Email"].ToString());

                //master.messageError(Session.Count.ToString());

                //master.setSession("IsAdmin", "1");
                //master.setSession("ID_Adm", dt.Rows[0]["ID_Adm"].ToString());
                //master.setSession("Email", dt.Rows[0]["Email"].ToString());

                
                
                Response.Redirect("AdminSection.aspx");
            }
            catch (Exception ex)
            {
                master.messageError(ex.Message);
            }
        }

        protected DataTable LoginTry(string email, string password)
        {
            

            List<ParmStruct> parms = new List<ParmStruct>();
            parms.Add(new ParmStruct("@Email", email, 50, SqlDbType.NVarChar, ParameterDirection.Input));
            parms.Add(new ParmStruct("@Password", password, 15, SqlDbType.NVarChar, ParameterDirection.Input));

            return GetDataTable("Admin_Login", parms);

        }

      
    }
}