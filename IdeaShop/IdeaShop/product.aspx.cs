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
    public partial class product : System.Web.UI.Page
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
                master.messageClear();
                string Prod_Id = Request.QueryString["IDPR"];
                if (!string.IsNullOrEmpty(Prod_Id))
                {
                    GetProductDetails(Prod_Id);
                }
            }
        }

        protected void GetProductDetails(string Prod_Id)
        {
            
            SqlDataReader dr = default(SqlDataReader);
            SqlCommand cmd = default(SqlCommand);
            try
            {
                using (SqlConnection cnn = new SqlConnection(cnnString))
                {
                    cmd = new SqlCommand("Prods_Get_One", cnn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    

                    SqlParameter pProdId = new SqlParameter("@ID_Pr", System.Data.SqlDbType.Char, 4);
                    cmd.Parameters.AddWithValue(pProdId.ParameterName, Prod_Id);
                    cnn.Open();

                    dr = cmd.ExecuteReader();

                    if (dr.HasRows)
                    {
                        dr.Read();
                        pro_name.Text = dr["pro_name"].ToString();
                        ID_Pr.Text = dr["ID_Pr"].ToString();
                        cat_name.Text = dr["cat_name"].ToString();
                        price.Text = Convert.ToDouble(dr["price"].ToString()).ToString("c");
                        descriptionFull.Text = dr["descriptionFull"].ToString();
                        descriptionBrief.Text = dr["descriptionBrief"].ToString();
                        pic.ImageUrl = "~/images/" + dr["pic"].ToString();
                        str_stat.Text = "Status: " + dr["str_stat"].ToString();
                        lblQty.Visible = nudIntoCart.Visible = btnAddCart.Visible = (dr["statID"].ToString() == "1");
                        if (Convert.ToBoolean(dr["isFeatured"]))
                        {
                            featured.Text = "Is Featured";
                        }
                        else
                        {
                            featured.Text = "";
                        }
                    }
                    else
                    {
                        lblMsg.Text = "No rows found";
                    }
                }
            }
            catch (Exception ex)
            {
                lblMsg.Text = ex.Message;

            }
            finally
            {
                dr.Close();
            }
        }


        protected void btnEdit_Click(object sender, EventArgs e)
        {

            String leId = ID_Pr.Text;
            if (!string.IsNullOrEmpty(leId))
            {
                Response.Redirect("productEdit.aspx?productID=" + leId);
            }
            else
            {
                master.messageError("Please click a category!");
            }

        }

        protected void btnAddCart_Click(object sender, EventArgs e)
        {
            SqlConnection cnn = new SqlConnection(cnnString);
            if (master.userIsAdmin())
            {
                Response.Redirect("default.aspx?messageError=Please log into your customer account to make purchases");
                return;
            }
            try
            {
                cnn.Open();
                SqlTransaction objTrans = cnn.BeginTransaction();

                using (cnn)
                {
                    try
                    {
                        List<SqlJacknife.ParmStruct> parmsProd = new List<SqlJacknife.ParmStruct>();
                        List<SqlJacknife.ParmStruct> parmsCart = new List<SqlJacknife.ParmStruct>();

                        int cartID = 0;


                        if (master.getCartId() > 0)//((Request.Cookies["ID_Cart"] != null))//A an Id cart is present;
                        {
                            cartID = master.getCartId();
                            /*
                            if (Session["ID_Cust"] != null)
                            {
                                Session["ID_Cart"] = cartID.ToString();
                            }
                            */
                        }
                        else
                        {
                            parmsCart.Add(new SqlJacknife.ParmStruct("@ID_Cart", cartID, 0, SqlDbType.Int, ParameterDirection.Output));
                            cartID = Convert.ToInt32(SqlJacknife.SendCommandGetString("spCreateNewCart", parmsCart));
                            if (Session.Count != 0)
                            {
                                if (string.IsNullOrEmpty(Session["ID_Cart"].ToString()))//...and the user does not have a card.
                                {
                                    List<SqlJacknife.ParmStruct> parms2 = new List<SqlJacknife.ParmStruct>();
                                    parms2.Add(new SqlJacknife.ParmStruct("@ID_Cart", cartID, 20, SqlDbType.Int, ParameterDirection.Input));
                                    parms2.Add(new SqlJacknife.ParmStruct("@ID_Cust", Session["ID_Cust"].ToString(), 20, SqlDbType.Int, ParameterDirection.Input));
                                    SqlJacknife.SendCommand("Own_Cart", parms2);
                                }
                            }

                        }

                        parmsProd.Add(new SqlJacknife.ParmStruct("@ID_Prod", ID_Pr.Text, 4, SqlDbType.Char, ParameterDirection.Input));
                        parmsProd.Add(new SqlJacknife.ParmStruct("@HistoricalPrice", Convert.ToDecimal(price.Text.Substring(1)), 0, SqlDbType.Decimal, ParameterDirection.Input));
                        parmsProd.Add(new SqlJacknife.ParmStruct("@ID_Cart", cartID, 4, SqlDbType.Char, ParameterDirection.Input));
                        SqlJacknife.SendCommand("spAddProductToCart", parmsProd);
                        //Response.Cookies["ID_Cart"].Value = cartID.ToString();
                        master.setCartId(cartID);

                        
                        master.messageSuccess("Product added (ID:HERE)".Replace("HERE",cartID.ToString()));
                        Response.Redirect("CartPage.aspx", false);
                        objTrans.Commit();
                    }
                    catch (Exception ex)
                    {
                        master.messageLoggedError(ex.Message);
                        IdeaHeaderAndSide.logMessage("IdeaShop-Product: Add item to cart", ex.Message);
                        objTrans.Rollback();

                    }
                    
                }
            }
            catch (Exception x)
            {
                master.messageError(x.Message);
            }
        }
    }
}