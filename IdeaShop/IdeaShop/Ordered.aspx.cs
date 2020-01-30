using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IdeaShop
{
    public partial class Ordered : System.Web.UI.Page
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
            if (String.IsNullOrEmpty(Request.QueryString["ordered"]))
            {
                return;
            }


            DataTable dt;
            List<SqlJacknife.ParmStruct> parms = new List<SqlJacknife.ParmStruct>();

            int cartID = 0;
            cartID = Convert.ToInt32(Request.QueryString["ordered"]);

            parms.Add(new SqlJacknife.ParmStruct("@ID_Cart", cartID, 0, SqlDbType.Int, ParameterDirection.Input));
            dt = SqlJacknife.GetDS("spLoadOrderedItems", parms).Tables[0];
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

                lblSubtotal.Text = subtotal.ToString("c");
                lblTax.Text = tax.ToString("c");
                lblShipping.Text = shipping.ToString("c");
                lblTotal.Text = (subtotal + tax + shipping).ToString("c");
                //double subtotal = Convert.ToDouble(grdCartItems.Rows[0].Cells[4].Text.Replace("$",""));

                DataTable deets = SqlJacknife.GetDataTable("Get_OrderHistory_Details", parms);
                lblAddress.Text = deets.Rows[0]["ShippingAddress"].ToString();
                lblPayment.Text = deets.Rows[0]["PaymentType"].ToString();
            }
            else
            {
                master.messageNormal("You don't have any Item on order");
            }
        }

        private void LoadCartTest()
        {
     

            DataTable dt;
            List<SqlJacknife.ParmStruct> parms = new List<SqlJacknife.ParmStruct>();

            int cartID = 14;
            

            parms.Add(new SqlJacknife.ParmStruct("@ID_Cart", cartID, 0, SqlDbType.Int, ParameterDirection.Input));
            dt = SqlJacknife.GetDS("spLoadOrderedItems", parms).Tables[0];
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
    }
}