using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IdeaShop
{
    public partial class AccountEditor : System.Web.UI.Page
    {
        private string cnnString = ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;
        private enum MODE {CREATE, EDIT, CHECKOUT};
        private MODE myMode = MODE.CREATE;
        private IdeaHeaderAndSide master;
        protected void Page_Load(object sender, EventArgs e)
        {
            changeRegex(null, null);
            if (master == null)
            {
                master = (IdeaHeaderAndSide)this.Page.Master;
            }
            if (!IsPostBack)
            {

                if (Session["ID_Cust"] == null)
                {
                    createMode();

                }
                else
                {
                    editMode();
                    loadCustomer(Convert.ToInt32(Session["ID_Cust"]));
                    if (!string.IsNullOrEmpty(Request.QueryString["mode"]))
                    {
                        checkoutMode();
                    }


                }
                
                //birthDate.Value = DateTime.Now.ToString();
            }
        }

        protected void UpdateAccount(int id)
        {
            using (SqlConnection conn = new SqlConnection(cnnString))
            {
                conn.Open();
                SqlTransaction trans = conn.BeginTransaction();
                try
                {
                    List<SqlJacknife.ParmStruct> parms = new List<SqlJacknife.ParmStruct>();
                    parms.Add(new SqlJacknife.ParmStruct("@ID_cust", id, 0, SqlDbType.Int, ParameterDirection.Input));
                    parms.Add(new SqlJacknife.ParmStruct("@fname", fname.Text, 20, SqlDbType.VarChar, ParameterDirection.Input));
                    parms.Add(new SqlJacknife.ParmStruct("@mname", mname.Text, 20, SqlDbType.VarChar, ParameterDirection.Input));
                    parms.Add(new SqlJacknife.ParmStruct("@lname", lname.Text, 20, SqlDbType.VarChar, ParameterDirection.Input));
                    parms.Add(new SqlJacknife.ParmStruct("@username", username.Text, 20, SqlDbType.VarChar, ParameterDirection.Input));
                    parms.Add(new SqlJacknife.ParmStruct("@password", password.Text, 50, SqlDbType.VarChar, ParameterDirection.Input));
                    parms.Add(new SqlJacknife.ParmStruct("@dob", birthDate.Value, 0, SqlDbType.Date, ParameterDirection.Input));
                    parms.Add(new SqlJacknife.ParmStruct("@street", address.Text, 20, SqlDbType.VarChar, ParameterDirection.Input));
                    parms.Add(new SqlJacknife.ParmStruct("@city", city.Text, 20, SqlDbType.VarChar, ParameterDirection.Input));
                    parms.Add(new SqlJacknife.ParmStruct("@state", sOrP.Text, 20, SqlDbType.VarChar, ParameterDirection.Input));
                    parms.Add(new SqlJacknife.ParmStruct("@zip", zip.Text, 10, SqlDbType.NVarChar, ParameterDirection.Input));
                    parms.Add(new SqlJacknife.ParmStruct("@country", country.Text, 20, SqlDbType.VarChar, ParameterDirection.Input));
                    parms.Add(new SqlJacknife.ParmStruct("@phone", phone.Text, 10, SqlDbType.VarChar, ParameterDirection.Input));
                    parms.Add(new SqlJacknife.ParmStruct("@email", email.Text, 50, SqlDbType.VarChar, ParameterDirection.Input));

                    if (SqlJacknife.SendCommand("UpdateAccountUser", parms) != 0)
                    {
                        master.messageSuccess("Account Updated Successfully");
                        trans.Commit();
                    }
                }
                catch (Exception ex)
                {
                    master.messageLoggedError(ex.Message);
                    IdeaHeaderAndSide.logMessage("IdeaShop-Account Editor: Update Account", ex.Message);
                    trans.Rollback();
                }
            }
        }

        protected void CreateAccount()
        {
            using (SqlConnection conn = new SqlConnection(cnnString))
            {
                conn.Open();
                SqlTransaction trans = conn.BeginTransaction();
                try
                {
                    String validCode = generateGarble(8);
                    String message = "Hello, "+ fname.Text + ",</br> Please follow the link to validate your account"
                        + "<p><a href = 'http://localhost:63985/default.aspx?validate=" + validCode + "'>http://localhost:63985/default.aspx?validate=" + validCode + "</a></p>"
                        + "After your account is validated you can purchase ideas!</br></br>"
                        + "- The Last Braincell Team";

                    List<SqlJacknife.ParmStruct> parms = new List<SqlJacknife.ParmStruct>();
                    parms.Add(new SqlJacknife.ParmStruct("@ID_cust", null, 0, SqlDbType.Int, ParameterDirection.Output));
                    parms.Add(new SqlJacknife.ParmStruct("@fname", fname.Text, 20, SqlDbType.VarChar, ParameterDirection.Input));
                    parms.Add(new SqlJacknife.ParmStruct("@mname", mname.Text, 20, SqlDbType.VarChar, ParameterDirection.Input));
                    parms.Add(new SqlJacknife.ParmStruct("@lname", lname.Text, 20, SqlDbType.VarChar, ParameterDirection.Input));
                    parms.Add(new SqlJacknife.ParmStruct("@username", username.Text, 20, SqlDbType.VarChar, ParameterDirection.Input));
                    parms.Add(new SqlJacknife.ParmStruct("@password", password.Text, 50, SqlDbType.VarChar, ParameterDirection.Input));
                    parms.Add(new SqlJacknife.ParmStruct("@dob", ExtractBirthday(), 0, SqlDbType.Date, ParameterDirection.Input));
                    parms.Add(new SqlJacknife.ParmStruct("@street", address.Text, 20, SqlDbType.VarChar, ParameterDirection.Input));
                    parms.Add(new SqlJacknife.ParmStruct("@city", city.Text, 20, SqlDbType.VarChar, ParameterDirection.Input));
                    parms.Add(new SqlJacknife.ParmStruct("@state", sOrP.Text, 20, SqlDbType.VarChar, ParameterDirection.Input));
                    parms.Add(new SqlJacknife.ParmStruct("@zip", zip.Text, 10, SqlDbType.NVarChar, ParameterDirection.Input));
                    parms.Add(new SqlJacknife.ParmStruct("@country", country.Text, 20, SqlDbType.VarChar, ParameterDirection.Input));
                    parms.Add(new SqlJacknife.ParmStruct("@phone", phone.Text, 10, SqlDbType.VarChar, ParameterDirection.Input));
                    parms.Add(new SqlJacknife.ParmStruct("@email", email.Text, 50, SqlDbType.VarChar, ParameterDirection.Input));
                    parms.Add(new SqlJacknife.ParmStruct("@Validate", validCode, 8, SqlDbType.Char, ParameterDirection.Input));


                    string ID = SqlJacknife.SendCommandGetString("CreateCustomer", parms);
                    if (ID != "0")
                    {
                        master.messageSuccess("Account Created Successfully, ID: "+ID.ToString());
                        trans.Commit();
                    }

                    IdeaHeaderAndSide.sendEmail(email.Text,"ideaShopRobot@noreply","One last step, " + fname.Text, message);
                }
                catch (Exception ex)
                {
                    master.messageLoggedError(ex.Message);
                    IdeaHeaderAndSide.logMessage("IdeaShop-Account Editor: Create Account", ex.Message);
                    trans.Rollback();
                }
                

            }

        }

        

        protected void loadCustomer(int id)
        {
           
            try
            {
                List<SqlJacknife.ParmStruct> parms = new List<SqlJacknife.ParmStruct>();
                parms.Add(new SqlJacknife.ParmStruct("@ID_Cust", id, 20, SqlDbType.Int, ParameterDirection.Input));

                DataTable dt = SqlJacknife.GetDataTable("Get_Customer", parms);

                lblId.Text = "Id :" + dt.Rows[0]["ID_Cust"].ToString();
                fname.Text = dt.Rows[0]["FName"].ToString();
                mname.Text = dt.Rows[0]["MName"].ToString();
                lname.Text = dt.Rows[0]["LName"].ToString();
                username.Text = dt.Rows[0]["UserName"].ToString();
                birthDate.Value = dt.Rows[0]["DOB"].ToString().Split(' ')[0];
                phone.Text = dt.Rows[0]["Phone"].ToString();
                email.Text = dt.Rows[0]["Email"].ToString();
                address.Text = dt.Rows[0]["Street"].ToString();
                city.Text = dt.Rows[0]["City"].ToString();
                sOrP.Text = dt.Rows[0]["State"].ToString();
                zip.Text = dt.Rows[0]["ZIP"].ToString();
                country.Text = dt.Rows[0]["Country"].ToString();
                password.Text = dt.Rows[0]["Password"].ToString();
            }
            catch (Exception ex)
            {
                master.messageLoggedError(ex.Message);
                IdeaHeaderAndSide.logMessage("IdeaShop-Account Editor: Retrieving customer data", ex.Message);
            }
        }

        protected void editMode()
        {
            username.Enabled = fname.Enabled = mname.Enabled = lname.Enabled = false;
            btnSave.Text = "Confirm Changes";
            lblContactAdmin.Visible = true;
            lblTop.Text = lblTop.Text.Replace("Create","Update");
            btnCheckout.Visible = checkoutCrumb.Visible = false;
            myMode = MODE.EDIT;
        }

        protected void createMode()
        {
            username.Enabled = fname.Enabled = mname.Enabled = lname.Enabled = true;
            btnSave.Text = "Create Account";
            lblContactAdmin.Visible = false;
            lblTop.Text = lblTop.Text.Replace("Update", "Create");
            btnCheckout.Visible = checkoutCrumb.Visible = false;
            myMode = MODE.CREATE;
        }

        protected void checkoutMode()
        {
            editMode();
            btnCheckout.Visible = checkoutCrumb.Visible = true;
            
            myMode = MODE.CHECKOUT;

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (btnSave.Text.IndexOf("Create") != -1)
            {
                CreateAccount();
            }
            else if (btnSave.Text.IndexOf("Confirm") != -1)
            {
               UpdateAccount(Convert.ToInt32(Session["ID_Cust"]));
            }
            else if (btnSave.Text.IndexOf("Checkout") != -1)
            {
                UpdateAccount(Convert.ToInt32(Session["ID_Cust"]));
                Response.Redirect("ShippingAddress.aspx");
            }
            /*
            //You can tweak this to Cookie as you wish, indeed I think it should be since we also have checkoutMode
            int ID = Convert.ToInt32(Request.QueryString["IDCust"]);
            if (ID == 0)
            {
                CreateAccount();
            }
            else if (ID != 0)
            {
                UpdateAccount(Convert.ToInt32(Request.QueryString["IDCust"]));
            }
            */
        }

        public static string generateGarble(int length)
        {
            char[] chars = { '0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z' };
            string toSend = "";
            Random rand = new Random();

            while (toSend.Length < length)
            {
                int leIndex = rand.Next(chars.Length);
                toSend += chars[leIndex];
            }

            return toSend;
        }

        /// <summary>
        /// Gets the date from the birthdate field, throws an exception of the value is null or it is under 19.
        /// </summary>
        /// <returns></returns>
        public DateTime ExtractBirthday()
        {

            if (string.IsNullOrEmpty(birthDate.Value))
            {
                throw new Exception("Please enter a birthdate!");
            }

            String[] rawDate = birthDate.Value.Split('-');

            DateTime toSend = new DateTime(Convert.ToInt32(rawDate[0]), Convert.ToInt32(rawDate[1]), Convert.ToInt32(rawDate[2]));
            DateTime today = DateTime.Now;
            Exception tooyoung = new Exception("Must be 19 or older to join.");


            //Go home Trunks, you're drunk!
            if (today.Year <= toSend.Year)
            {
                throw tooyoung;
            }

            //Definitely older than 19
            if (today.Year - toSend.Year > 19)
            {
                return toSend;
            }
            else if (today.Year - toSend.Year < 19)
            {
                throw tooyoung;
            }
            if (today.Year - toSend.Year == 19)
            {
                if (toSend.Month < today.Month)//Birthmonth has passed
                {
                    return toSend;
                }
                else if (today.Month == toSend.Month && today.Date >= toSend.Date)//Birthday has passed
                {
                    return toSend;
                }

                throw tooyoung;
            }

            return toSend;
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            Response.Redirect("ShippingAddress.aspx");
        }

        protected void changeRegex(object sender, EventArgs e)
        {
            if (country.Text == "United States")
            {
                regexZip.ValidationExpression = "^\\d{5}(?:[-\\s]\\d{4})?$";
                /* https://stackoverflow.com/questions/2577236/regex-for-zip-code */

            }
            else
            {
                regexZip.ValidationExpression = "[ABCEGHJKLMNPRSTVXY][0-9][ABCEGHJKLMNPRSTVWXYZ] ?[0-9][ABCEGHJKLMNPRSTVWXYZ][0-9]";
                /* https://stackoverflow.com/questions/1146202/canadian-postal-code-validation */
            }
        }
    }

}