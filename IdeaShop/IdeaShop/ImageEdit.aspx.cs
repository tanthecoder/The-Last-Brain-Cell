using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IdeaShop
{
    public partial class ImageEdit : System.Web.UI.Page
    {
        IdeaHeaderAndSide master;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (master == null)
            {
                master = (IdeaHeaderAndSide)this.Master;
            }
            if (!IsPostBack)
            {
                LoadImages();
                btnDontDelete.Visible = false;
                btnRealDelete.Visible = false;
            }

            master.userIsAdmin("default.aspx");
        }

        protected void LoadImages()
        {
            ImageAccess imgDB = new ImageAccess();
            DataTable images = imgDB.Load_Verified();
            ddlImages.DataSource = images;
            ddlImages.DataTextField = "fileName";
            ddlImages.DataValueField = "ID_Img";
            ddlImages.DataBind();
        }

        protected void DeleteClick(object sender, EventArgs e)
        {
            try
            {
                String myFace = ((Button)sender).Text;

                if (myFace.IndexOf("Confirm") != -1)
                {
                    //Put delete method here.
                    ImageAccess db = new ImageAccess();
                    db.Delete_Image(Convert.ToInt32(ViewState["ID_Img"]));

                    txtAltText.Text = "";
                    txtName.Text = "";
                    lblFileName.Text = "";
                    LoadImages();
                    btnDelete.Visible = true;
                    btnDontDelete.Visible = btnRealDelete.Visible = false;
                }
                else if (myFace.IndexOf("Cancel") != -1)
                {
                    master.messageNormal("Delete Canceled");
                    btnDelete.Visible = true;
                    btnDontDelete.Visible = btnRealDelete.Visible = false;
                }
                else
                {
                    btnDelete.Visible = false;
                    btnDontDelete.Visible = btnRealDelete.Visible = true;
                }
            }catch(Exception x)
            {
                master.messageError(x.Message);
            }


        }


        protected void btnImage_Click(object sender, EventArgs e)
        {
            ImageAccess db = new ImageAccess();
            DataTable image = new DataTable();

            image = db.Load_Image(Convert.ToInt32(ddlImages.SelectedValue));
            imgPreview.ImageUrl = image.Rows[0]["locus"].ToString();
            string fileName = image.Rows[0]["fileName"].ToString();
            string altText = image.Rows[0]["altText"].ToString();
            bool active = Convert.ToBoolean(image.Rows[0]["active"]);
            ViewState["ID_Img"] = Convert.ToInt32(image.Rows[0]["ID_Img"]);

            lblFileName.Text = fileName;
            txtName.Text = fileName;
            txtAltText.Text = altText;
            chkActive.Checked = active;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                ImageAccess db = new ImageAccess();
                if (db.Update_Image(Convert.ToInt32(ViewState["ID_Img"]), txtName.Text, txtAltText.Text,imgPreview.ImageUrl, chkActive.Checked))
                {
                    master.messageSuccess("Image Info Updated!");
                }
            }catch(Exception x)
            {
                master.messageError(x.Message);
            }
            
        }
    }
}