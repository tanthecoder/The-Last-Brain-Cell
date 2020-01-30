using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IdeaShop
{
    public partial class Confirmation : System.Web.UI.Page
    {
        IdeaHeaderAndSide master;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (master == null)
            {
                master = this.Page.Master as IdeaHeaderAndSide;
            }
            if (!IsPostBack)
            {
                LoadCart();
            }
        }

        private void LoadCart()
        {

            DataTable dt;
            List<SqlJacknife.ParmStruct> parms = new List<SqlJacknife.ParmStruct>();

            int cartID = 0;
            cartID = master.getCartId();

            parms.Add(new SqlJacknife.ParmStruct("@ID_Cart", cartID, 0, SqlDbType.Int, ParameterDirection.Input));
            dt = SqlJacknife.GetDS("spLoadCartItems", parms).Tables[0];
            if (dt.Rows.Count != 0)
            {
                grdCartItems.DataSource = dt;
                grdCartItems.DataBind();

                double subtotal = 0;
                foreach (GridViewRow row in grdCartItems.Rows)
                {
                    subtotal += Convert.ToDouble(row.Cells[4].Text.Substring(1));
                }
                lblSubtotal.Text = subtotal.ToString("c");

                double tax = subtotal * 0.15;

                double shipping = 0;

                if (subtotal <= 75 && subtotal >= 35)
                {
                    shipping = 12;
                }
                else if (subtotal < 35)
                {
                    shipping = 7;
                }
                lblAddress.Text = Request.Cookies["address"].Value;
                lblPayment.Text = Session["Payment"].ToString();
                lblSubtotal.Text = subtotal.ToString("c");
                lblTax.Text = tax.ToString("c");
                lblShipping.Text = shipping.ToString("c");
                lblTotal.Text = (subtotal + tax + shipping).ToString("c");
                //double subtotal = Convert.ToDouble(grdCartItems.Rows[0].Cells[4].Text.Replace("$",""));
            }
            else
            {
                master.messageNormal("You don't have any Item on order");
            }
        }

        protected void btnCart_Click(object sender, EventArgs e)
        {
            Response.Redirect("CartPage.aspx");
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            List<SqlJacknife.ParmStruct> parms = new List<SqlJacknife.ParmStruct>();
            parms.Add(new SqlJacknife.ParmStruct("@ID_Order", 0, 20, SqlDbType.Int, ParameterDirection.Output));
            parms.Add(new SqlJacknife.ParmStruct("@ID_Cart", Session["ID_Cart"], 8, System.Data.SqlDbType.Int, System.Data.ParameterDirection.Input));
            parms.Add(new SqlJacknife.ParmStruct("@ShippingAddress", Request.Cookies["address"].Value, 300, System.Data.SqlDbType.NVarChar, System.Data.ParameterDirection.Input));
            parms.Add(new SqlJacknife.ParmStruct("@PaymentType", Session["Payment"].ToString(), 20, System.Data.SqlDbType.NVarChar, System.Data.ParameterDirection.Input));

            try
            {
               String OrderId = SqlJacknife.SendCommandGetString("PlaceOrderOutput", parms);
                
                 
                sendEmail(OrderId);

                Response.Cookies.Clear();
                Response.Cookies["ID_Cart"].Expires = DateTime.Now.AddDays(-1);
                String ordered = Session["ID_Cart"].ToString();
                Session["ID_Cart"] = "";

                Response.Redirect("Ordered.aspx?ordered=" + ordered + "&messageSuccess=Your ideas are on the way!");
            }
            catch (Exception ex)
            {
                master.messageError(ex.Message);
            }





        }

        public void sendEmail(String OrderId)
        {
            String url = "http://localhost:63985/Ordered.aspx?ordered=" + Session["ID_Cart"].ToString();
            String DEETS = getDeets(OrderId);
            String message = "Hello " + Session["UserName"] + ",</br>"
                + "Your order has been placed. </br>" +DEETS+
                "</br>You may view this at:</br></br>" +
                "<a href ='" + url + "'>" + url + "</a></br></br>" +
                "- The Last Braincell Team";

            IdeaHeaderAndSide.sendEmail(Session["Email"].ToString(), "ideaShopRobot@noreply", "Order Confirmed!", message);
        }

        public String getDeets(String OrderId)
        {
            String toSend = "<h3>Your Order:</h3>" +
                "<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>SubTotal</th></tr>CONTNTS</table>";
            String templateTable = "<tr><td>Product ID</td><td>Product Name</td><td>qty</td><td>HistoricalPrice</td><td>Sub Total</td></tr>";
            String tableGuts = "";
            String BottomTemplate = "<h4><b>TITLE:</b> VALUE</h4>";
            

            for (int a = 0; a < grdCartItems.Rows.Count; a++)
            {
                tableGuts += templateTable.Replace("Product ID", grdCartItems.Rows[a].Cells[0].Text)
                    .Replace("Product Name", grdCartItems.Rows[a].Cells[1].Text)
                    .Replace("qty", grdCartItems.Rows[a].Cells[2].Text)
                    .Replace("HistoricalPrice", grdCartItems.Rows[a].Cells[3].Text)
                    .Replace("Sub Total", grdCartItems.Rows[a].Cells[4].Text);
            }



            toSend = toSend.Replace("CONTNTS", tableGuts);
            toSend += BottomTemplate.Replace("TITLE", "OrderId: ").Replace("VALUE", OrderId);
            toSend += "</hr>";
            toSend += BottomTemplate.Replace("TITLE", "Address: ").Replace("VALUE",lblAddress.Text);
            toSend += BottomTemplate.Replace("TITLE", "Payment Type: ").Replace("VALUE", lblPayment.Text);
            toSend += "</hr>";
            toSend += BottomTemplate.Replace("TITLE", "Subtotal: ").Replace("VALUE", lblSubtotal.Text);
            toSend += BottomTemplate.Replace("TITLE", "Tax: ").Replace("VALUE", lblTax.Text);
            String shippingToPut = (lblShipping.Text == "$0.00") ? "Free":lblShipping.Text;
            toSend += BottomTemplate.Replace("TITLE", "Shipping: ").Replace("VALUE", shippingToPut);
            toSend += "</hr>";
            toSend += BottomTemplate.Replace("TITLE", "Total: ").Replace("VALUE", lblTotal.Text);


            return toSend;
        }
    }
}