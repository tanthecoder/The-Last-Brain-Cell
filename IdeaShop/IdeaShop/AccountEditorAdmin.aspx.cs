using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//using IdeaShop.App_Code;

namespace IdeaShop
{
    public partial class AccountEditorAdmin : System.Web.UI.Page
    {
        //private string cnnString = ConnectionStrings.GetCnnString("cnn");
        private string cnnString = ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;
        private IdeaHeaderAndSide master;
        protected void Page_Load(object sender, EventArgs e)
        {
            changeRegex(null, null);
            if (master == null)
            {
                master = this.Page.Master as IdeaHeaderAndSide;
            }

            master.userIsAdmin("default.aspx");

            foreach (Control ctrl in whereAllThingsAreIn.Controls)
            {
                if (ctrl is TextBox)
                {
                    (ctrl as TextBox).Enabled = false;

                }
            }
            foreach (Control ctrl in addressDiv.Controls)
            {
                if (ctrl is TextBox)
                {
                    (ctrl as TextBox).Enabled = false;

                }
            }
            if (!IsPostBack)
            {
                int id = Convert.ToInt32(Request.QueryString["IDCust"]);
                if (Request.QueryString["IDCust"] != null)
                {
                    LoadUpAccount(id);
                }
                LoadDDLCustomers();
            }
        }

        protected void btnArchive_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection cnn = new SqlConnection(cnnString))
                {
                    List<SqlJacknife.ParmStruct> parms = new List<SqlJacknife.ParmStruct>();
                    parms.Add(new SqlJacknife.ParmStruct("@ID_Cust", lblID.Text, 0, SqlDbType.Int, ParameterDirection.Input));
                    if (SqlJacknife.SendCommand("ArchiveAccount", parms) != 0)
                    {
                        master.messageSuccess("Account is Archived");
                    }
                }
            }
            catch (Exception ex)
            {
                master.messageLoggedError(ex.Message);
                IdeaHeaderAndSide.logMessage("IdeaShop-Account Editor Admin: Archive Account", ex.Message);
                
            }


        }

        public void LoadUpAccount(int Id)
        {
            try
            {
                List<SqlJacknife.ParmStruct> parms = new List<SqlJacknife.ParmStruct>();
                parms.Add(new SqlJacknife.ParmStruct("@ID_Cust", Id, 0, SqlDbType.Int, ParameterDirection.Input));

                DataTable dt = SqlJacknife.GetDataTable("RetrieveAccountByID", parms);
                lblID.Text = Id.ToString();
                username.Text = dt.Rows[0]["username"].ToString();
                password.Text = dt.Rows[0]["password"].ToString();
                fname.Text = dt.Rows[0]["fname"].ToString();
                lname.Text = dt.Rows[0]["lname"].ToString();
                birthDate.Value = dt.Rows[0]["dob"].ToString().Split(' ')[0];
                mname.Text = dt.Rows[0]["mname"].ToString();
                phone.Text = dt.Rows[0]["phone"].ToString();
                email.Text = dt.Rows[0]["email"].ToString();
                country.SelectedValue = dt.Rows[0]["country"].ToString();
                city.Text = dt.Rows[0]["city"].ToString();
                sOrP.Text = dt.Rows[0]["state"].ToString();
                address.Text = dt.Rows[0]["street"].ToString();
                zip.Text = dt.Rows[0]["zip"].ToString();
            }
            catch(Exception x)
            {
                master.messageLoggedError(x.Message);
                IdeaHeaderAndSide.logMessage("AccountEditorInfoLoad", x.Message);
            }
        }

        public void LoadDDLCustomers()
        {
            SqlCommand cmd = new SqlCommand("Customers_Get_All", new SqlConnection(cnnString));
            cmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            try
            {
                if (dt.Rows.Count != 0)
                {
                    customers.DataSource = dt;
                    customers.DataTextField = "username";
                    customers.DataValueField = "ID_Cust";
                    customers.DataBind();
                    customers.SelectedValue = Request.QueryString["IDCust"];
                }
                else
                {
                    master.messageError("Customers not found!");
                }

            }
            catch (Exception ex)
            {
                master.messageError(ex.Message);

            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            List<SqlJacknife.ParmStruct> parms = new List<SqlJacknife.ParmStruct>();
            parms.Add(new SqlJacknife.ParmStruct("@SearchString",txtSearch.Text,50,SqlDbType.VarChar,ParameterDirection.Input));
           
                      
           // SqlCommand cmd = new SqlCommand("Customers_by_Keywords", new SqlConnection(cnnString));
            //cmd.CommandType = CommandType.StoredProcedure;

           // SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = SqlJacknife.GetDataTable("Customers_by_Keywords",parms);

            //da.Fill(dt);
            

            try
            {
                if (dt.Rows.Count != 0)
                {
                    customers.DataSource = dt;
                    customers.DataTextField = "username";
                    customers.DataValueField = "ID_Cust";
                    customers.DataBind();
                    customers.SelectedValue = Request.QueryString["IDCust"];
                }
                else
                {
                    master.messageError("Customers not found!");
                }

            }
            catch (Exception ex)
            {
                master.messageError(ex.Message);

            }
        }

        protected void btnLoadCustomer_Click(object sender, EventArgs e)
        {
            LoadUpAccount(Convert.ToInt32(customers.SelectedValue));
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