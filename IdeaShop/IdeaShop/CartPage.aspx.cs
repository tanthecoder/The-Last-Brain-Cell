using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IdeaShop
{
    public partial class CartPage : System.Web.UI.Page
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
            if (master.getCartId() == -1)//(Request.Cookies["ID_Cart"] == null)
            {
                Response.Redirect("default.aspx?messageError=Your cart is empty!");
                return;
                
            }

            try
            {
                    DataTable dt;
                    List<SqlJacknife.ParmStruct> parms = new List<SqlJacknife.ParmStruct>();

                    int cartID = 0;
                    cartID = master.getCartId();//Convert.ToInt32(Request.Cookies["ID_Cart"].Value);

                    parms.Add(new SqlJacknife.ParmStruct("@ID_Cart", cartID, 0, SqlDbType.Int, ParameterDirection.Input));
                    dt = SqlJacknife.GetDS("spLoadCartItems", parms).Tables[0];
          

                if (dt.Rows.Count != 0)
                {
                    grdCartItems.DataSource = dt;
                    grdCartItems.DataBind();

                    double subtotal = 0;
                    foreach (GridViewRow row in grdCartItems.Rows)
                    {
                        subtotal += Convert.ToDouble(((Label)(row.Cells[3].FindControl("lblSubTotal"))).Text.Substring(1));
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
                    grdCartItems.DataSource = dt;
                    grdCartItems.DataBind();
                    lblSubtotal.Text = 0.ToString("c");
                    lblTax.Text = 0.ToString("c");
                    lblShipping.Text = 0.ToString("c");
                    lblTotal.Text = 0.ToString("c");
                    Response.Cookies.Remove("ID_Cart");
                    Response.Cookies["ID_Cart"].Expires = DateTime.Today.AddDays(-1);
                    Response.Redirect("default.aspx?messageError=Your cart is empty!");
                }
            }
            catch (Exception ex)
            {
                master.messageLoggedError(ex.Message);
                IdeaHeaderAndSide.logMessage("IdeaShop-CartPage: Load Cart", ex.Message);

            }
        }

        private void LoadCartOld()
        {
            if (Request.Cookies["ID_Cart"] == null)
            {
                return;
            }


            DataTable dt;
            List<SqlJacknife.ParmStruct> parms = new List<SqlJacknife.ParmStruct>();

            int cartID = 0;
            cartID = Convert.ToInt32(Request.Cookies["ID_Cart"].Value);

            parms.Add(new SqlJacknife.ParmStruct("@ID_Cart", cartID, 0, SqlDbType.Int, ParameterDirection.Input));
            dt = SqlJacknife.GetDS("spLoadCartItems", parms).Tables[0];
            if (dt.Rows.Count != 0)
            {
                grdCartItems.DataSource = dt;
                grdCartItems.DataBind();

                double subtotal = 0;
                foreach (GridViewRow row in grdCartItems.Rows)
                {
                    subtotal += Convert.ToDouble(((Label)(row.Cells[3].FindControl("lblSubTotal"))).Text.Substring(1));
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
                grdCartItems.DataSource = dt;
                grdCartItems.DataBind();
                lblSubtotal.Text = 0.ToString("c");
                lblTax.Text = 0.ToString("c");
                lblShipping.Text = 0.ToString("c");
                lblTotal.Text = 0.ToString("c");
                Response.Cookies.Remove("ID_Cart");
                Response.Cookies["ID_Cart"].Expires = DateTime.Today.AddDays(-1);
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (master.getCartId() == -1) { return; }
            
            try
            {
                foreach (GridViewRow row in grdCartItems.Rows)
                {
                    List<SqlJacknife.ParmStruct> parms = new List<SqlJacknife.ParmStruct>();
                    parms.Add(new SqlJacknife.ParmStruct("@ID_Cart", master.getCartId(), 0, SqlDbType.Int, ParameterDirection.Input));
                    parms.Add(new SqlJacknife.ParmStruct("@ID_Pr", (row.Cells[0].Text), 4, SqlDbType.Char, ParameterDirection.Input));
                    parms.Add(new SqlJacknife.ParmStruct("@qty", Convert.ToInt32(((TextBox)(row.Cells[2].FindControl("Quantity"))).Text), 0, SqlDbType.Int, ParameterDirection.Input));
                    parms.Add(new SqlJacknife.ParmStruct("@remove", ((CheckBox)(row.Cells[4].FindControl("chkRemove"))).Checked, 0, SqlDbType.Bit, ParameterDirection.Input));

                    SqlJacknife.SendCommand("spUpdateCartItems", parms);
                }
                LoadCart();
                if (grdCartItems.Rows.Count != 0)
                {
                    master.messageSuccess("Cart updated!");
                }
                else
                {
                    master.messageNormal("You don't have any item in your cart");
                }
            }
            catch (Exception ex)
            {
                master.messageLoggedError(ex.Message);
                IdeaHeaderAndSide.logMessage("IdeaShop-CartPage: Update Cart", ex.Message);

            }

        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
           
            if (grdCartItems.Rows.Count != 0)
            {
                if (Session["UserName"] != null)
                {
                    if (Session["Validated"].ToString() != "True")//Don't let the unvalidated buy anything.
                    {
                        master.messageError("Please validate your account to continue this transaction!");
                    }
                    else
                    {
                        Response.Redirect("AccountEditor.aspx?mode=cart");
                    }
                }
               
                else
                {
                    master.messageError("Please log in or create an account to continue.");
                }
            }
            else
            {
                master.messageError("Please add a product to the cart to proceed.");
            }
        }
    }
}