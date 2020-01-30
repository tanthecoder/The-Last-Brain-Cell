using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IdeaShop
{
    public partial class ImageValidate : System.Web.UI.Page
    {
        IdeaHeaderAndSide master;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (master == null)
            {
                master = (IdeaHeaderAndSide)this.Master;
            }

            master.userIsAdmin("default.aspx");
            if (!IsPostBack)
            {
                LoadImages();
            }

        }

        protected void LoadImages()
        {
            try
            {
                ImageAccess imgDB = new ImageAccess();
                DataTable images = new DataTable();

                images = imgDB.Load_Unverified(Convert.ToInt32(Session["ID_Adm"]));
                if (images.Rows.Count != 0)
                {
                    rptItems.DataSource = images;
                    rptItems.DataBind();
                }
                else
                {
                    rptItems.DataSource = null;
                    rptItems.DataBind();
                    master.messageNormal("There is no images for you to validate");
                }
            }
            catch (Exception ex)
            {
                master.messageError(ex.Message);

            }

        }
        

        protected void rptItems_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument.ToString());
            if (e.CommandName == "Accept")
            {
                ImageAccess db = new ImageAccess();
                DataTable image = new DataTable();
                
                image = db.Load_Image(id);
                string locus = image.Rows[0]["locus"].ToString();
                string extension = locus.Substring(locus.Length - 4);
                string fileName = image.Rows[0]["fileName"].ToString();
                string newLocus = locus.Replace("imagesTemp", "images");

                
                if (File.Exists(Server.MapPath("~/images") + "\\" + fileName + extension))
                {
                    master.messageError("File Already Exists... try again");
                }
                else
                {
                    db.VerifyImage(Convert.ToInt32(image.Rows[0]["ID_Img"]), Convert.ToInt32(Session["ID_Adm"]), newLocus);
                    File.Move(Server.MapPath(locus), Server.MapPath(newLocus));
                    LoadImages();
                }
            }
            else if (e.CommandName == "Reject")
            {
                ImageAccess db = new ImageAccess();
                DataTable image = new DataTable();
                image = db.Load_Image(id);
                db.Delete_Image(Convert.ToInt32(id));
                File.Delete(Server.MapPath(image.Rows[0]["locus"].ToString()));
                LoadImages();
            }
        }
    }
}