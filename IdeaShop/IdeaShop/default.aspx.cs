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
    public partial class _default : System.Web.UI.Page
    {
        private string cnnString = ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;
        IdeaHeaderAndSide master;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (master == null)
            {
                master = (IdeaHeaderAndSide)this.Master;
            }
            if (!IsPostBack)
            {
                string IdCat = Request.QueryString["categoryID"];
                string keyword = Request.QueryString["search"];
                string validate = Request.QueryString["validate"];

                if (!string.IsNullOrEmpty(validate))
                {
                    tryValidate(validate);
                }

                if (!string.IsNullOrEmpty(IdCat))
                {
                    SeeLabel.Text = "Category: " + Request.QueryString["categoryName"];
                    getProducts(IdCat);
                }
                else if (!string.IsNullOrEmpty(keyword))
                {
                    SeeLabel.Text = "Search: " + keyword;
                    DisplaySearchByKeywords(keyword, Request.QueryString["inclusion"]);

                }

                if (string.IsNullOrEmpty(keyword) && string.IsNullOrEmpty(IdCat))
                {
                    SeeLabel.Text = "Featured Ideas:";
                    SqlJacknife.stapleRepeater("Prods_Get_Featured", rptProducts,lblNoResults);
                }
            }
        }

        public void FindMe (Object sender, CommandEventArgs e)
        {
            master.messageSuccess(FindInRepeater(rptProducts, "btnFindMe",sender).ToString());
        }

        public int FindInRepeater(Repeater rpr, string id,object control)
        {
            for (int a = 0; a < rpr.Items.Count; a++)
            {
                if (rpr.Items[a].FindControl(id).Equals(control))
                {
                    return a;
                }
            }

            return -1;

        }


        private void tryValidate (String validate)
        {
            try
            {
                List<SqlJacknife.ParmStruct> parms = new List<SqlJacknife.ParmStruct>();
                parms.Add(new SqlJacknife.ParmStruct("@Validate", validate, 8, SqlDbType.Char, ParameterDirection.Input));
                DataTable dt = SqlJacknife.GetDS("ValidateCustomer", parms).Tables[0];
                String fname = dt.Rows[0]["fname"].ToString();

                String confirmMessage = "Hello " + fname + ",</br>"+
                    "Your account has been verified and you may now purchase ideas!</br></br>"+
                    "- The Last Braincell Team";
                master.messageSuccess(dt.Rows[0]["UserName"].ToString() + " has been validated!");
                IdeaHeaderAndSide.sendEmail(dt.Rows[0]["Email"].ToString(), "ideaShopRobot@noreply", "You're In!",confirmMessage);
            }
            catch (Exception ex)
            {
                master.messageError(ex.Message);
            }
        }
        /// <summary>
        /// Notice the plural, this takes the keyword property and the inclusive to factor in as many keywords ad possible.
        /// </summary>
        /// <param name="keywordRaw"></param>
        /// <param name="inclusive"></param>
        public void DisplaySearchByKeywords(string keywordRaw, string inclusive)
        {
            String[] keywords = keywordRaw.Split(' ');//Create an array of keywords

            if (keywords.Length == 0)//If there are no keywords don't even bother.
            {
                lblNoResults.Visible = true;
                lblNoResults.Text = "No results :(";
                return; 
            }

            List<SqlJacknife.ParmStruct> parms = new List<SqlJacknife.ParmStruct>();
            parms.Add(new SqlJacknife.ParmStruct("@mustALL", inclusive, 1, SqlDbType.Char, ParameterDirection.Input));//Must all means all must be included.

            for (int a = 0; a < Math.Min(keywords.Length, 5); a++)//Don't exceed 5 keywords
            {
                String myName = "@daWord" + (a + 1).ToString();
                parms.Add(new SqlJacknife.ParmStruct(myName, keywords[a], 50, SqlDbType.VarChar, ParameterDirection.Input));
            }

            //The rest is the same Display Search by Keyword
            DataTable dt = SqlJacknife.GetDS("Prods_by_Keywords", parms, CommandType.StoredProcedure).Tables[0];
            rptProducts.DataSource = dt;
            rptProducts.DataBind();

            if (dt.Rows.Count == 0)
            {
                lblNoResults.Visible = true;
                lblNoResults.Text = "No results :(";
            }
        }



        public void DisplaySearchByKeyword(string keyword)
        {
            List<SqlJacknife.ParmStruct> parms = new List<SqlJacknife.ParmStruct>();
            parms.Add(new SqlJacknife.ParmStruct("@daWord1",keyword, 50, SqlDbType.VarChar, ParameterDirection.Input));
            DataTable dt = SqlJacknife.GetDS("Prods_by_Keyword", parms, CommandType.StoredProcedure).Tables[0];
            rptProducts.DataSource = dt;
            rptProducts.DataBind();

            if (dt.Rows.Count == 0)
            {
                lblNoResults.Visible = true;
                lblNoResults.Text = "No results :(";
            }
        }

        protected void getProducts(string IdCat)
        {
            Label lblMasterMessage = Master.FindControl("lblMessage") as Label;

            SqlDataReader dr = default(SqlDataReader);
            SqlCommand cmd = default(SqlCommand);
            try
            {
                using (SqlConnection cnn = new SqlConnection(cnnString))
                {
                    cmd = new SqlCommand("Prods_byCategory", cnn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    SqlParameter param = new SqlParameter();
                    param.ParameterName = "@ID_Cat";
                    param.SqlDbType = SqlDbType.Int;
                    //Add the parameter to the Parameters collection
                    cmd.Parameters.AddWithValue("@ID_Cat", Convert.ToInt32(IdCat));
                    cnn.Open();

                    dr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);

                    if (dr.HasRows)
                    {
                        rptProducts.DataSource = dr;
                        rptProducts.DataBind();
                    }
                    else
                    {

                        lblNoResults.Visible = true;
                        lblNoResults.Text = "No results :(";
                        //lblMasterMessage.Text = "No Rows Found";
                    }
                }
            }
            catch (Exception ex)
            {
                lblMasterMessage.Text = ex.Message;

            }
            finally
            {
                dr.Close();
            }
        }
    }
}