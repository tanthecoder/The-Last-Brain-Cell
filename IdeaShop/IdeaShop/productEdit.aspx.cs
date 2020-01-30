using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IdeaShop
{
    public partial class productEdit : System.Web.UI.Page
    {
        private string cnnString = ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;
        private IdeaHeaderAndSide master;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (master == null)
            {
                master = (IdeaHeaderAndSide)this.Master;
            }

            master.userIsAdmin("default.aspx");

            if (!IsPostBack)
            {
                setupTop();
                Label lblMasterMessage = this.Page.Master.FindControl("lblMessage") as Label;
                lblMasterMessage.Text = "";
                getCategories();
                getStatus();
                string Prod_Id = Request.QueryString["productID"];
                if (!string.IsNullOrEmpty(Prod_Id))
                {

                    GetProductDetails(Prod_Id);
                    btnAddtoDB.Visible = false;
                    btnUpdate.Visible = true;
                    btnDelete.Visible = true;
                    ID_Pr.Text = Prod_Id;
                }
                else
                {
                    this.ID_Pr.Visible = false;
                    btnDelete.Visible = false;
                    btnAddtoDB.Visible = true;
                    btnUpdate.Visible = false;
                    ID_Pr.Text = "";
                }

                btnUpdate.Visible = !string.IsNullOrEmpty(Prod_Id);
                //btnAdd.Visible = string.IsNullOrEmpty(Prod_Id);
            }

        }
        private void getCategories()
        {
            SqlCommand cmd = new SqlCommand("Categ_Get_All", new SqlConnection(cnnString));
            cmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            try
            {
                if (dt.Rows.Count != 0)
                {
                    ddlCategoriesEdit.DataSource = dt;
                    ddlCategoriesEdit.DataTextField = "cat_name";
                    ddlCategoriesEdit.DataValueField = "ID_Cat";
                    ddlCategoriesEdit.DataBind();
                    ddlCategoriesEdit.SelectedValue = Request.QueryString["categoryId"];
                }
                else
                {
                    master.messageError("Categories not found!");
                }

            }
            catch (Exception ex)
            {
                master.messageError(ex.Message);

            }

        }

        private void getStatus()
        {
            SqlCommand cmd = new SqlCommand("Status_Get_All", new SqlConnection(cnnString));
            cmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            try
            {


                if (dt.Rows.Count != 0)
                {
                    str_statDdl.DataSource = dt;
                    str_statDdl.DataTextField = "description";
                    str_statDdl.DataValueField = "status";
                    str_statDdl.DataBind();
                }
                else
                {
                    master.messageError("What happend to the statuses?!");
                }

            }
            catch (Exception ex)
            {
                master.messageError(ex.Message);
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
                        pro_nameTxt.Text = dr["pro_name"].ToString();
                        ID_Pr.Text = dr["ID_Pr"].ToString();
                        ddlCategoriesEdit.SelectedValue = dr["Id_Cat"].ToString();
                        str_statDdl.SelectedValue = dr["status"].ToString();
                        Double groundedPrice = Convert.ToDouble(dr["price"]);
                        priceTxt.Text = groundedPrice.ToString("n2");
                        descriptionFullTxt.Text = dr["descriptionFull"].ToString();
                        pic.ImageUrl = "~/images/" + dr["pic"].ToString();
                        picTxt.Text = dr["pic"].ToString();
                        descriptionBriefTxt.Text = dr["descriptionBrief"].ToString();
                        isFeaturedChk.Checked = Convert.ToBoolean(dr["isFeatured"]);
                    }
                    else
                    {
                        master.messageError("Product not found!");
                    }
                }
            }
            catch (Exception ex)
            {
                master.messageError(ex.Message);

            }
            finally
            {
                dr.Close();
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            btnDeleteCancel.Visible = true;
            btnDeleteConfirm.Visible = true;
            btnDelete.Visible = false;
        }

        protected void btnDeleteCancel_Click(object sender, EventArgs e)
        {
            btnDeleteCancel.Visible = false;
            btnDeleteConfirm.Visible = false;
            btnDelete.Visible = true;
        }

        protected void btnDeleteConfirm_Click(object sender, EventArgs e)
        {
            List<SqlJacknife.ParmStruct> parms = new List<SqlJacknife.ParmStruct>();
            parms.Add(new SqlJacknife.ParmStruct("@id_pr", Request.QueryString["productID"], 4, SqlDbType.Char, ParameterDirection.Input));
            SqlJacknife.SendCommand("Prods_Delete", parms, CommandType.StoredProcedure);
            Response.Redirect("default.aspx?messageSuccess=Product+Deleted!&categoryID="+ddlCategoriesEdit.SelectedValue.ToString()+ "&categoryName="+ddlCategoriesEdit.SelectedItem);
        }

        protected void btnAddtoDB_Click(object sender, EventArgs e)
        {
            String isFeatured = (isFeaturedChk.Checked) ? "1" : "0";
            try
            {
                List<SqlJacknife.ParmStruct> parms = new List<SqlJacknife.ParmStruct>();

                parms.Add(new SqlJacknife.ParmStruct("@newID", "", 4, SqlDbType.Char, ParameterDirection.Output));
                parms.Add(new SqlJacknife.ParmStruct("@pro_name", pro_nameTxt.Text, 30, SqlDbType.Char, ParameterDirection.Input));
                parms.Add(new SqlJacknife.ParmStruct("@descriptionBrief", descriptionBriefTxt.Text, 200, SqlDbType.Char, ParameterDirection.Input));
                parms.Add(new SqlJacknife.ParmStruct("@descriptionFull", descriptionFullTxt.Text, 1000, SqlDbType.NText, ParameterDirection.Input));
                parms.Add(new SqlJacknife.ParmStruct("@price", Convert.ToDouble(priceTxt.Text), 1000, SqlDbType.Float, ParameterDirection.Input));
                parms.Add(new SqlJacknife.ParmStruct("@ID_Cat", ddlCategoriesEdit.SelectedValue, 4, SqlDbType.Char, ParameterDirection.Input));
                parms.Add(new SqlJacknife.ParmStruct("@isFeatured", isFeatured, 1, SqlDbType.Char, ParameterDirection.Input));
                parms.Add(new SqlJacknife.ParmStruct("@status", str_statDdl.SelectedValue, 1, SqlDbType.Char, ParameterDirection.Input));
                parms.Add(new SqlJacknife.ParmStruct("@pic", picTxt.Text, 25, SqlDbType.VarChar, ParameterDirection.Input));
                String newID = SqlJacknife.SendCommandGetString("Prods_Add", parms, CommandType.StoredProcedure);
                //Can't seem to get output parameters to work.
                //Response.Redirect("product.aspx?productID=" + newID);
                Response.Redirect("default.aspx?categoryID=" + ddlCategoriesEdit.SelectedValue + "&messageSuccess=Product+Added!");
            }
            catch (Exception ex)
            {
                master.messageError(ex.Message);
            }


        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                String isFeatured = (isFeaturedChk.Checked) ? "1" : "0";
                List<SqlJacknife.ParmStruct> parms = new List<SqlJacknife.ParmStruct>();
                parms.Add(new SqlJacknife.ParmStruct("@Id_pr", Request.QueryString["productID"], 4, SqlDbType.Char, ParameterDirection.Input));
                parms.Add(new SqlJacknife.ParmStruct("@pro_name", pro_nameTxt.Text, 30, SqlDbType.Char, ParameterDirection.Input));
                parms.Add(new SqlJacknife.ParmStruct("@descriptionBrief", descriptionBriefTxt.Text, 200, SqlDbType.Char, ParameterDirection.Input));
                parms.Add(new SqlJacknife.ParmStruct("@descriptionFull", descriptionFullTxt.Text, 1000, SqlDbType.NText, ParameterDirection.Input));
                parms.Add(new SqlJacknife.ParmStruct("@price", Convert.ToDouble(priceTxt.Text), 1000, SqlDbType.Float, ParameterDirection.Input));
                parms.Add(new SqlJacknife.ParmStruct("@ID_Cat", ddlCategoriesEdit.SelectedValue, 4, SqlDbType.Char, ParameterDirection.Input));
                parms.Add(new SqlJacknife.ParmStruct("@isFeatured", isFeatured, 1, SqlDbType.Char, ParameterDirection.Input));
                parms.Add(new SqlJacknife.ParmStruct("@status", str_statDdl.SelectedValue, 1, SqlDbType.Char, ParameterDirection.Input));
                parms.Add(new SqlJacknife.ParmStruct("@pic", picTxt.Text, 25, SqlDbType.VarChar, ParameterDirection.Input));
                SqlJacknife.SendCommand("Prods_Update", parms, CommandType.StoredProcedure);

                master.messageSuccess("Product Updated");
            }
            catch (Exception ex)
            {
                master.messageError(ex.Message);
            }

        }

        protected void btnImgtry_Click(object sender, EventArgs e)
        {
            pic.ImageUrl = "~\\images\\" + picTxt.Text;


        }

        #region Editor Navigation functions
        /// <summary>
        /// Sets up the ddls for category and product
        /// </summary>
        private void setupTop()
        {
            btnLoadProduct.Visible = ddlProductChoose.Visible = lblProduct.Visible = false;
            try
            {
                //Setup category
                DataTable dtCategory = SqlJacknife.GetDS("Categ_Get_All", new List<SqlJacknife.ParmStruct>(), CommandType.StoredProcedure).Tables[0];
                dtCategory.Columns["ID_Cat"].AllowDBNull = true;
                DataRow mtRow = dtCategory.NewRow();
                mtRow["ID_Cat"] = DBNull.Value;
                mtRow["cat_name"] = "Select A Category";
                dtCategory.Rows.InsertAt(mtRow, 0);

                ddlCategoryChoose.DataSource = dtCategory;
                ddlCategoryChoose.DataTextField = "cat_name";
                ddlCategoryChoose.DataValueField = "ID_Cat";
                ddlCategoryChoose.DataBind();

                if (!string.IsNullOrEmpty(Request.QueryString["categoryId"]))
                {
                    ddlCategoryChoose.SelectedValue = Request.QueryString["categoryId"];
                }
            }
            catch (Exception ex)
            {
                master.messageError(ex.Message);
            }
        }

        protected void btnNewProduct_Click(object sender, EventArgs e)
        {
            String leId = ddlCategoryChoose.SelectedValue;//Once the list box is set up this should be the selected value.

            if (!string.IsNullOrEmpty(leId))
            {
                Response.Redirect("productEdit.aspx?categoryID=" + leId);
            }
            else
            {

                master.messageError("Please click a category first!");
            }
        }

        protected void LoadProducts(object sender, EventArgs e)
        {
            String leId = ddlCategoryChoose.SelectedValue;

            if (!string.IsNullOrEmpty(leId))
            {
                List<SqlJacknife.ParmStruct> parms = new List<SqlJacknife.ParmStruct>();
                parms.Add(new SqlJacknife.ParmStruct("@ID_Cat", leId, 4, SqlDbType.Char, ParameterDirection.Input));
                parms.Add(new SqlJacknife.ParmStruct("@allowDiscontinued", 1, 1, SqlDbType.Bit, ParameterDirection.Input));

                DataTable dtProducts = SqlJacknife.GetDS("Prods_byCategory", parms).Tables[0];

                if (dtProducts.Rows.Count == 0)
                {
                    master.messageNormal("No products for this category!");
                }
                else
                {
                    btnLoadProduct.Visible = ddlProductChoose.Visible = lblProduct.Visible = true;
                    dtProducts.Columns["ID_Pr"].AllowDBNull = true;
                    dtProducts.Columns["ID_Pr"].AllowDBNull = true;
                    DataRow mtRow = dtProducts.NewRow();
                    mtRow["ID_Pr"] = DBNull.Value;
                    mtRow["pro_name"] = "Select A Product";
                    dtProducts.Rows.InsertAt(mtRow, 0);

                    ddlProductChoose.DataSource = dtProducts;
                    ddlProductChoose.DataTextField = "pro_name";
                    ddlProductChoose.DataValueField = "ID_Pr";
                    ddlProductChoose.DataBind();
                }

            }
            else
            {

                master.messageError("Please click a category first!");
            }
        }

        protected void loadSelectedProduct(object sender, EventArgs e)
        {
            String ddlProductToPut = ddlProductChoose.SelectedValue;
            if (!string.IsNullOrEmpty(ddlProductToPut))
            {
                Response.Redirect("productEdit.aspx?productID=" + ddlProductChoose.SelectedValue);
            }
            else
            {
                master.messageNormal("Please select a product");
            }

        }

        #endregion

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("product.aspx?IDPR=" + this.ID_Pr.Text);

        }
    }
}