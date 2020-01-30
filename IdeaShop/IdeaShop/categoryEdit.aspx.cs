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
    public partial class categoryEdit : System.Web.UI.Page
    {
        private string cnnString = ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;
        private IdeaHeaderAndSide master;
        Dictionary<String, String> descriptions;//This doesn't work :(
        protected void Page_Load(object sender, EventArgs e)
        {
            if (descriptions == null)
            {
                descriptions = new Dictionary<string, string>();
            }

            if (master == null)
            {
                master = (IdeaHeaderAndSide)this.Master;
            }

            master.userIsAdmin("default.aspx");

            if (!IsPostBack)
            {
                getCategories();
            }


        }

        private DataRow getCategory(string id)
        {
            List<SqlJacknife.ParmStruct> parms = new List<SqlJacknife.ParmStruct>();
            parms.Add(new SqlJacknife.ParmStruct("@ID_Cat", id, 4, SqlDbType.Char, ParameterDirection.Input));
            DataSet toSend = SqlJacknife.GetDS("Categ_Get_One", parms);
            return toSend.Tables[0].Rows[0];
        }

        private void getCategories()
        {
            Label lblMsg = this.Page.Master.FindControl("lblMessage") as Label;

            SqlCommand cmd = new SqlCommand("Categ_Get_All", new SqlConnection(cnnString));
            cmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            try
            {


                if (dt.Rows.Count != 0)
                {
                    ddlCategories.DataSource = dt;
                    ddlCategories.DataTextField = "cat_name";
                    ddlCategories.DataValueField = "ID_Cat";
                    ddlCategories.DataBind();
                    ddlCategories.SelectedValue = Request.QueryString["categoryId"];


                    for (int a = 0; a < dt.Rows.Count; a++)
                    {
                        String key = dt.Rows[a]["ID_Cat"].ToString();
                        String value = dt.Rows[a]["description"].ToString();
                        descriptions[key] = value;
                    }

                    ddlCategories_TextChanged(null, null);

                }
                else
                {
                    master.messageError("No Categories Found!");
                }

            }
            catch (Exception ex)
            {
                master.messageError(ex.Message);

            }



        }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            ddlCategories.Visible = false;
            btnDelete.Visible = false;
            btnConfirm.Visible = false;
            btnCancel.Visible = true;
            btnNew.Visible = false;
            cat_name.Focus();
            cat_name.Text = description.Text = ID_Cat.Text = "";
        }

        /// <summary>
        /// Saves or updates the category
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnSave_Click(object sender, EventArgs e)
        {
            // Check if the name is null or empty
            if (string.IsNullOrEmpty(cat_name.Text.Trim()))
            {
                IdeaHeaderAndSide leMaster = (IdeaHeaderAndSide)this.Master;
                leMaster.messageError("Please enter a title!");
            }

            Label lblMasterMessage = this.Page.Master.FindControl("lblMessage") as Label;
            String idOutput = "";
            if (ddlCategories.Visible == false)
            {
                List<SqlJacknife.ParmStruct> parms = new List<SqlJacknife.ParmStruct>();
                parms.Add(new SqlJacknife.ParmStruct("@ID_Cat", idOutput, 4, SqlDbType.Char, ParameterDirection.Output));
                parms.Add(new SqlJacknife.ParmStruct("@cat_name", cat_name.Text, 30, SqlDbType.VarChar, ParameterDirection.Input));
                parms.Add(new SqlJacknife.ParmStruct("@description", description.Text, 200, SqlDbType.VarChar, ParameterDirection.Input));
                SqlJacknife.SendCommand("Categ_Add", parms, CommandType.StoredProcedure);
                this.master.messageSuccess("Category Added");
            }
            else if (ddlCategories.Visible == true)
            {
                List<SqlJacknife.ParmStruct> parms = new List<SqlJacknife.ParmStruct>();
                parms.Add(new SqlJacknife.ParmStruct("@ID_Cat", ddlCategories.SelectedValue, 30, SqlDbType.Int, ParameterDirection.Input));
                parms.Add(new SqlJacknife.ParmStruct("@cat_name", cat_name.Text, 30, SqlDbType.VarChar, ParameterDirection.Input));
                parms.Add(new SqlJacknife.ParmStruct("@description", description.Text, 200, SqlDbType.VarChar, ParameterDirection.Input));
                SqlJacknife.SendCommand("Categ_Update", parms, CommandType.StoredProcedure);

                this.master.messageSuccess("Category Updated");
            }
            getCategories();
            //IdeaHeaderAndSide master = (IdeaHeaderAndSide)this.Master;
            master.getCategories();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {

            btnCancel.Visible = false;
            btnConfirm.Visible = false;
            btnNew.Visible = true;
            btnSave.Visible = true;
            btnDelete.Visible = true;
            ddlCategories.Visible = true;
            Label lblMasterMessage = this.Page.Master.FindControl("lblMessage") as Label;
            master.messageNormal("Modify Category Canceled");
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            btnCancel.Visible = true;
            btnConfirm.Visible = true;
            btnNew.Visible = false;
            btnSave.Visible = false;
        }
        /// <summary>
        /// This finally deletes the selected category
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            try
            {
                List<SqlJacknife.ParmStruct> parms = new List<SqlJacknife.ParmStruct>();
                parms.Add(new SqlJacknife.ParmStruct("@ID_Cat", ddlCategories.SelectedValue, 4, SqlDbType.Char, ParameterDirection.Input));
                SqlJacknife.SendCommand("Categ_Delete", parms, CommandType.StoredProcedure);
                Label lblMasterMessage = this.Page.Master.FindControl("lblMessage") as Label;
                lblMasterMessage.Text = "Category Deleted";
                getCategories();
                IdeaHeaderAndSide master = (IdeaHeaderAndSide)this.Master;
                master.getCategories();
                btnCancel.Visible = false;
                btnConfirm.Visible = false;
                btnNew.Visible = true;
                btnSave.Visible = true;
                btnDelete.Visible = true;
                master.messageSuccess("Category deleted");
                //Response.Redirect("default.aspx?messageSuccess=Category+Deleted!");
            }
            catch
            {
                master.messageError("Cannot delete Categories containing products");
            }
        }

        protected void ddlCategories_TextChanged(object sender, EventArgs e)
        {
            if (ddlCategories.Visible == false || ddlCategories.SelectedIndex == -1) { return; }
            DataRow rowCategory = getCategory(ddlCategories.SelectedValue.ToString());
            description.Text = rowCategory["description"].ToString().Trim();
            cat_name.Text = rowCategory["cat_name"].ToString().Trim();
            ID_Cat.Text = rowCategory["ID_Cat"].ToString().Trim();

            

            //cat_name.Text = ddlCategories.SelectedItem.ToString();
            //description.Text = descriptions.Keys.Count.ToString();

        }
    }



}