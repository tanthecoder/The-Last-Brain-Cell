using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Drawing;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IdeaShop
{
    public partial class IdeaHeaderAndSide : System.Web.UI.MasterPage
    {
        private string cnnString = ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;



        protected void Page_Load(object sender, EventArgs e)
        {
            CheckForMessages();
            CheckLogin();

            if (!IsPostBack)
            {
                getCategories();
                /*
                if (Session["ID_Cust"] == null)
                {
                    loginVisible();
                }
                else
                {
                    loggedInVisible();
                }
                */
            }
        }

        public void CheckLogin()
        {


            if (Session["UserName"] != null || userIsAdmin())
            {
                loggedInVisible();
                if (Session["UserName"] != null)
                {
                    lblUsername.Text = Session["UserName"].ToString();
                }
                else if (userIsAdmin())
                {
                    lblUsername.Text = Session["Email"].ToString().Split('@')[0];
                    aAdminLogin.Visible = false;
                    aAdminSection.Visible = true;
                }
            }
            else
            {
                loginVisible();
                aAdminLogin.Visible = true;
                aAdminSection.Visible = false;
            }
        }

        /// <summary>
        /// Make the login visible and the details invlsible
        /// </summary>
        private void loginVisible()
        {
            loggedInStack.Visible = false;
            loginStack.Visible = true;
            btnLogin.Visible = true;
        }

        private void loggedInVisible()
        {
            loggedInStack.Visible = true;
            loginStack.Visible = false;
            btnLogin.Visible = false;
        }

        /// <summary>
        /// Checks the URL for messages.
        /// </summary>
        private void CheckForMessages()
        {
            if (!string.IsNullOrEmpty(Request.QueryString["messageNormal"]))
            {
                messageNormal(Request.QueryString["messageNormal"].Replace("+", " "));
            }

            else if (!string.IsNullOrEmpty(Request.QueryString["messageSuccess"]))
            {
                messageSuccess(Request.QueryString["messageSuccess"].Replace("+", " "));
            }

            else if (!string.IsNullOrEmpty(Request.QueryString["messageError"]))
            {
                messageError(Request.QueryString["messageError"].Replace("+", " "));
            }

        }

        public void getCategories()
        {
            SqlDataReader dr = default(SqlDataReader);
            SqlCommand cmd = default(SqlCommand);
            try
            {
                using (SqlConnection cnn = new SqlConnection(cnnString))
                {
                    cmd = new SqlCommand("Categ_Get_All", cnn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cnn.Open();

                    dr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);

                    if (dr.HasRows)
                    {
                        rptCategories.DataSource = dr;
                        rptCategories.DataBind();
                    }
                    else
                    {
                        lblMessage.Text = "No Rows Found";
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;

            }
            finally
            {
                dr.Close();
            }
        }

        protected void btnNewProduct_Click(object sender, EventArgs e)
        {
            String leId = Request.QueryString["categoryID"];//Once the list box is set up this should be the selected value.
            if (!string.IsNullOrEmpty(leId))
            {
                Response.Redirect("productEdit.aspx?categoryID=" + leId);
            }
            else
            {
                messageError("Please click a category first!");
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            String inclusion = (chkKeys.Checked) ? "1" : "0";
            String txtToSend = SearchBox.Text.Trim().Replace(", ", "").Replace(" ,", "").Replace(",", "").Replace(" ", ",").Replace(",", "+").Replace(" ", "+");
            Response.Redirect("default.aspx?search=" + SearchBox.Text + "&inclusion=" + inclusion);
        }

        /// <summary>
        /// Clear the top message.
        /// </summary>
        public void messageClear()
        {
            lblMessage.Text = "";
            lblMessage.ForeColor = Color.Black;
        }

        /// <summary>
        /// Sets the top message in black test.
        /// </summary>
        /// <param name="to"></param>
        public void messageNormal(String to)
        {
            lblMessage.Text = to;
            lblMessage.ForeColor = Color.Black;
        }

        /// <summary>
        /// Sets the top message in red test.
        /// </summary>
        /// <param name="to"></param>
        public void messageError(String to)
        {
            lblMessage.Text = to;
            lblMessage.ForeColor = Color.Red;
        }

        /// <summary>
        /// Sets the top message in green test.
        /// </summary>
        /// <param name="to"></param>
        public void messageSuccess(String to)
        {
            lblMessage.Text = to;
            lblMessage.ForeColor = Color.Green;
        }

        #region Save Data Tools
        public void killCookie(string cookieName)
        {
            Response.Cookies[cookieName].Expires = DateTime.Now.AddDays(-1);
        }

        public string getCookie(string key)
        {
            return Response.Cookies[key].Value;
        }

        public string setCookie(string key, string value)
        {
            string oldValue = Response.Cookies[key].Value;

            Response.Cookies[key].Value = value;

            return oldValue;
        }


        public string setCookie(string key, string value, DateTime expiration)
        {
            string oldValue = Response.Cookies[key].Value;

            Response.Cookies[key].Value = value;
            Response.Cookies[key].Expires = expiration;

            return oldValue;
        }

        public string setCookie30(string key, string value)
        {
            return setCookie(key, value, DateTime.Now.AddDays(30));
        }


        public void setSession(string key, string value)
        {
            if (Session[key] == null)
            {
                Session.Add(key, value);
            }
            else
            {
                Session[key] = value;
            }
        }



        #endregion

        #region IdeaShopSpecific

        /// <summary>
        /// Checks if the user is an admin;
        /// </summary>
        /// <returns></returns>
        public bool userIsAdmin()
        {
            int sessionCount = Session.Count;
            String isAdmin = "";

            if (sessionCount != 0)
            {
                isAdmin = Session["IsAdmin"].ToString();
            }

            if (Session.Count == 0 || Session["IsAdmin"].ToString() == "0")
            {
                return false;
            }


                return true;
        }
        /// <summary>
        /// Checks if the user is an admin and redirects them if they are not.
        /// </summary>
        /// <param name="redirect"></param>
        /// <returns></returns>
        public bool userIsAdmin(string redirect)
        {
            if (Session.Count == 0 || Session["IsAdmin"].ToString() == "0")
            {
                Response.Redirect(redirect);
                return false;
            }


            return true;
        }
        /// <summary>
        /// Checks if the user is an admin and redirects them if they are not with a message.
        /// </summary>
        /// <param name="redirect"></param>
        /// <returns></returns>
        public bool userIsAdmin(string redirect,string message)
        {
            if (Session.Count == 0 || Session["IsAdmin"].ToString() == "0")
            {
                Response.Redirect(redirect+"?messageError="+ message);
                return false;
            }


            return true;
        }

        /// <summary>
        /// Returns -1 if neither the cookie or the session contain an ID_Cart
        /// </summary>
        /// <returns></returns>
        public int getCartId()
        {
            if (Session.Count != 0 && !string.IsNullOrEmpty(Session["ID_Cart"].ToString()))
            {
                
                return Convert.ToInt32(Session["ID_Cart"]);
            }

            if (Request.Cookies["ID_Cart"] != null)
            {
                return Convert.ToInt32(Request.Cookies["ID_Cart"].Value);
            }

            return -1;
        }

        public void setCartId(int to)
        {
            if (Session["UserName"] != null)
            {
                Session["ID_Cart"] = to.ToString();
            }
            else
            {
                Response.Cookies["ID_Cart"].Value = to.ToString();
            }
            
        }

        

        #endregion

        public static void sendEmail(string sendTo, string sentFrom, string Subject, string Contents, Label outputLbl = null)
        {
            try
            {
                MailMessage mailMessage = new MailMessage();
                mailMessage.To.Add(sendTo);
                mailMessage.From = new MailAddress(sentFrom);
                mailMessage.Subject = Subject;
                mailMessage.IsBodyHtml = true;
                mailMessage.Body = Contents;
                SmtpClient smtpClient = new SmtpClient("localhost");
                smtpClient.Send(mailMessage);

                if (outputLbl != null)
                {
                    outputLbl.Text = "E-mail sent!";
                }
            }
            catch (Exception ex)
            {
                if (outputLbl != null)
                {
                    outputLbl.Text = ex.Message;
                }
            }
        }

        protected void LoginTry(object sender, EventArgs e)
        {
            
            try
            {
                List<SqlJacknife.ParmStruct> parms = new List<SqlJacknife.ParmStruct>();
                parms.Add(new SqlJacknife.ParmStruct("@UserName", txtLogin.Text, 20, SqlDbType.NVarChar, ParameterDirection.Input));
                parms.Add(new SqlJacknife.ParmStruct("@Password", txtPassword.Text, 15, SqlDbType.NVarChar, ParameterDirection.Input));
                DataTable dt = SqlJacknife.GetDS("Get_User_For_Session", parms).Tables[0];
                setSession("UserName", dt.Rows[0]["UserName"].ToString());
                setSession("ID_Cart", dt.Rows[0]["ID_Cart"].ToString());
                setSession("ID_Cust", dt.Rows[0]["ID_Cust"].ToString());
                setSession("Email", dt.Rows[0]["Email"].ToString());
                setSession("Validated", dt.Rows[0]["Validated"].ToString());
                setSession("IsAdmin","0");
                setSession("Payment", "");

                if (dt.Rows[0]["Validated"].ToString() != "1")
                {
                    messageError("Please validate your account to make purchases!");
                }


                if (Request.Cookies["ID_Cart"] != null)
                {

                    try
                    {
                        List<SqlJacknife.ParmStruct> parms2 = new List<SqlJacknife.ParmStruct>();
                        if (string.IsNullOrEmpty(Session["ID_Cart"].ToString()))//User doesn't have a cart, give them the current one.
                        {
                            parms2.Add(new SqlJacknife.ParmStruct("@ID_Cart", Request.Cookies["ID_Cart"].Value.ToString(), 20, SqlDbType.Int, ParameterDirection.Input));
                            parms2.Add(new SqlJacknife.ParmStruct("@ID_Cust", dt.Rows[0]["ID_Cust"].ToString(), 20, SqlDbType.Int, ParameterDirection.Input));
                            SqlJacknife.SendCommand("Own_Cart", parms2);
                            setCartId(Convert.ToInt32(Request.Cookies["ID_Cart"].Value.ToString()));
                        }
                        else if (Request.Cookies["ID_Cart"] != null)
                        {
                            
                            parms2.Add(new SqlJacknife.ParmStruct("@FeedMe", Convert.ToInt32(Session["ID_Cart"]), 20, SqlDbType.Int, ParameterDirection.Input));
                            parms2.Add(new SqlJacknife.ParmStruct("@EatMe", Convert.ToInt32(Request.Cookies["ID_Cart"].Value.ToString()), 20, SqlDbType.Int, ParameterDirection.Input));
                            SqlJacknife.SendCommand("MergeCarts",parms2);
                        }

                        Response.Cookies["ID_Cart"].Value = null;
                        Response.Cookies["ID_Cart"].Expires = DateTime.Now.AddDays(-1);


                    }
                    catch(Exception ex)
                    {
                        messageError(ex.Message);
                    }


                    /*
                    List<SqlJacknife.ParmStruct> parms2 = new List<SqlJacknife.ParmStruct>();
                    parms2.Add(new SqlJacknife.ParmStruct("@ID_Cart",Request.Cookies["ID_Cart"].Value.ToString(),20,SqlDbType.Int,ParameterDirection.Input));
                    parms2.Add(new SqlJacknife.ParmStruct("@ID_Cust", dt.Rows[0]["ID_Cust"].ToString(), 20, SqlDbType.Int, ParameterDirection.Input));
                    SqlJacknife.SendCommand("Own_Cart",parms2);
                    */
                }

                lblUsername.Text = dt.Rows[0]["UserName"].ToString();
                txtLogin.Text = txtPassword.Text = "";
                loggedInVisible();
                Response.Redirect("default.aspx");

            }
            catch (Exception ex)
            {
                messageError(ex.Message);
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            
            loginVisible();
            Response.Redirect("default.aspx");
        }

        public static void logMessage(String source, String toPut)
        {
            EventLog log = new EventLog();
            log.Source = source;
            log.WriteEntry(toPut, EventLogEntryType.Error);

        }

        /// <summary>
        /// Specifically for errors to be logged
        /// </summary>
        /// <param name="to"></param>
        public void messageLoggedError(String to)
        {
            lblMessage.Text = to + "Please refresh the page or contact administrators at tyson@gmail.com.";
            lblMessage.ForeColor = Color.Red;
        }
    }
}