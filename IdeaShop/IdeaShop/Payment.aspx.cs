using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IdeaShop
{
    public partial class Payment : System.Web.UI.Page
    {

        IdeaHeaderAndSide master;
        protected void Page_Load(object sender, EventArgs e)
        {
            master = (IdeaHeaderAndSide)this.Master;
        }

        protected void btnContinue_Click(object sender, EventArgs e)
        {
            if (ddlPayment.SelectedIndex <= 0)
            {
                master.messageError("Please select a payment type!");
                return;
            }

            Session["Payment"] = ddlPayment.Text;
            Response.Redirect("Confirmation.aspx");
            return;

            List<SqlJacknife.ParmStruct> parms = new List<SqlJacknife.ParmStruct>();
            parms.Add(new SqlJacknife.ParmStruct("@ID_Cart", Session["ID_Cart"], 8, System.Data.SqlDbType.Int, System.Data.ParameterDirection.Input));
            parms.Add(new SqlJacknife.ParmStruct("@ShippingAddress", Request.Cookies["address"].Value, 300, System.Data.SqlDbType.NVarChar, System.Data.ParameterDirection.Input));
            parms.Add(new SqlJacknife.ParmStruct("@PaymentType", ddlPayment.Text, 20, System.Data.SqlDbType.NVarChar, System.Data.ParameterDirection.Input));
            
            try
            {
                if (SqlJacknife.SendCommand("PlaceOrder", parms) == 0)
                {
                    throw new Exception("Order Failed!");
                }
                sendEmail();
            }
            catch (Exception ex)
            {
                master.messageError(ex.Message);
            }



            Response.Cookies.Clear();
            Response.Cookies["ID_Cart"].Expires = DateTime.Now.AddDays(-1);
            String ordered = Session["ID_Cart"].ToString();
            Session["ID_Cart"] = "";
            master.messageError(ddlPayment.Text);

            Response.Redirect("Ordered.aspx?ordered=" + ordered);

        }

        public void sendEmail()
        {
            String url = "http://localhost:63985/Ordered.aspx?ordered=" + Session["ID_Cart"].ToString();

            String message = "Hello " + Session["UserName"] + ",</br>"
                + "Your order has been placed. You may view it at:</br></br>" +
                "<a href ='" + url + "'>" + url + "</a></br></br>" +
                "- The Last Braincell Team";

            IdeaHeaderAndSide.sendEmail(Session["Email"].ToString(), "ideaShopRobot@noreply", "Order Confirmed!", message);
        }
    }
}