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
    public partial class ShippingAddress : System.Web.UI.Page
    {
        private string cnnString = ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;

        

        protected void Page_Load(object sender, EventArgs e)
        {
            
           changeRegex(null, null);
        }

        protected void btnMyAddress_Click(object sender, EventArgs e)
        {
            LoadAddress(Convert.ToInt32(Session["ID_Cust"]));



        }

        protected void LoadAddress(int id)
        {

            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(cnnString))
            {
                conn.Open();
                List<SqlJacknife.ParmStruct> parms = new List<SqlJacknife.ParmStruct>();
                parms.Add(new SqlJacknife.ParmStruct("@ID_Cust", id, 0, System.Data.SqlDbType.Int, System.Data.ParameterDirection.Input));

                dt = SqlJacknife.GetDataTable("Address_By_IDCust", parms);
                if (dt.Rows.Count != 0)
                {
                    if (dt.Rows[0]["country"].ToString() == "United States" || dt.Rows[0]["country"].ToString() == "USA")
                    {
                        country.SelectedIndex = 0;
                    }
                    else if (dt.Rows[0]["country"].ToString() == "Canada")
                    {
                        country.SelectedIndex = 1;
                    }
                    else 
                    {
                        country.SelectedIndex = 2;
                    }
                    zip.Text = dt.Rows[0]["zip"].ToString();
                    sOrP.Text = dt.Rows[0]["state"].ToString();
                    address.Text = dt.Rows[0]["street"].ToString();
                    city.Text = dt.Rows[0]["city"].ToString();
                    changeRegex(null, null);
                }
            }


        }

        protected void btnContinue_Click(object sender, EventArgs e)
        {
            Response.Cookies["address"].Value = country.Text + "," + city.Text + "," + address.Text + "," + zip.Text + "," + sOrP.Text;
            Response.Redirect("Payment.aspx");
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