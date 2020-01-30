using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IdeaShop
{
    public partial class ImageUpload : System.Web.UI.Page
    {
        IdeaHeaderAndSide master;
        private string cnnString = ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (master == null)
            {
                master = (IdeaHeaderAndSide)this.Master;
            }

            if (!IsPostBack)
            {
                DeleteAllInTrueTemp();
                    
            }


            master.userIsAdmin("default.aspx");

        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            try
            {
                DeleteAllInTrueTemp();
                int intSizeLimit = 1048576;
                //1 mb
                // does the file upload control have a file ?
                if (imgUploader.HasFile)
                {
                    //the postedFile object represnets the file that was posted
                    //you can use its contentLength property to determine
                    //the size of the posted file
                    if (imgUploader.PostedFile.ContentLength <= intSizeLimit)
                    {
                        //file size is ok, lets continue
                        //server.mappath returns an absolute path from the relative path provided..
                        string strPath = Server.MapPath("~/imagesTrueTemp") + "\\" + imgUploader.FileName;
                        ViewState["extension"] = strPath.Substring(strPath.Length - 4);

                        // we can use contentType to help figure out what type of file this is if needed
                        string strgContentType = imgUploader.PostedFile.ContentType;
                        // creates an image from the specified data stream
                        System.Drawing.Image img = System.Drawing.Image.FromStream(imgUploader.PostedFile.InputStream);

                        bool imgSaved = false;

                        if (ImageFormat.Jpeg.Equals(img.RawFormat))
                        {
                            //then it is a jpg
                            imgSaved = SaveToTrueTempForPreview(strPath);
                        }
                        else if (ImageFormat.Bmp.Equals(img.RawFormat))
                        {
                            //then its a bmp
                            imgSaved = SaveToTrueTempForPreview(strPath);
                        }
                        else if (ImageFormat.Png.Equals(img.RawFormat))
                        {
                            //then its a png
                            imgSaved = SaveToTrueTempForPreview(strPath);
                        }
                        else if (ImageFormat.Tiff.Equals(img.RawFormat))
                        {
                            //then its a tiff
                            imgSaved = SaveToTrueTempForPreview(strPath);
                        }
                        else
                        {
                            master.messageError("NOT A VALID IMAGE");
                        }

                    }
                    else
                    {
                        master.messageError("File is too big - please try again");
                    }
                }

            }
            catch (Exception x)
            {
                if (x.Message.ToLower() == "parameter is not valid.")
                {
                    master.messageError("That is not a valid image");
                }
                else
                {
                    master.messageError(x.Message);
                }
            }
        }


        private bool SaveToTrueTempForPreview(string strPath)
        {
            if (File.Exists(strPath))
            {
                master.messageNormal("File Already Exists... try again!");
                imgPreview.Visible = false;
                return false;
            }
            else
            {
                imgUploader.SaveAs(strPath);
                imgPreview.Visible = false;
                imgPreview.ImageUrl = "~/imagesTrueTemp\\" + imgUploader.FileName;
                txtName.Text =  Path.GetFileNameWithoutExtension(strPath).Length>15 ? Path.GetFileNameWithoutExtension(strPath).Substring(0,15) : Path.GetFileNameWithoutExtension(strPath);
                imgPreview.Visible = true;
                master.messageClear();
            }
            return true;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            ImageAccess imgDB = new ImageAccess();
            if(File.Exists(Server.MapPath("~/imagesTemp") + "\\" + txtName.Text + ViewState["extension"]))
            {
                master.messageError("File Already Exists... try again");
            }
            else
            {
                File.Move(Server.MapPath(imgPreview.ImageUrl), Server.MapPath("~/imagesTemp") + "\\" + txtName.Text + ViewState["extension"]);
                if (imgDB.Save_Image(txtName.Text, txtAltText.Text, "~/imagesTemp/" + txtName.Text + ViewState["extension"], Convert.ToInt32(Session["ID_Adm"])))
                {
                    master.messageSuccess("Images has successfully been uploaded");
                }
                imgPreview.Visible = false;
            }

        }

        protected void DeleteAllInTrueTemp()
        {
            DirectoryInfo dir = new DirectoryInfo(Server.MapPath("~/imagesTrueTemp"));
            foreach(FileInfo file in dir.GetFiles())
            {
                file.Delete();
            }

        }
    }


}