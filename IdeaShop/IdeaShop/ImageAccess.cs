using System.Collections.Generic;
using System.Data;

namespace IdeaShop
{
    public class ImageAccess
    {
        /// <summary>
        /// For saving a fresh image to the database
        /// </summary>
        /// <param name="filename"></param>
        /// <param name="alttext"></param>
        /// <param name="locus"></param>
        /// <param name="ID_Adm"></param>
        /// <returns>True if the save was successful</returns>
        public bool Save_Image(string filename, string alttext, string locus, int ID_Adm)
        {
            List<SqlJacknife.ParmStruct> parms = new List<SqlJacknife.ParmStruct>();
            parms.Add(new SqlJacknife.ParmStruct("@fileName", filename, 50, SqlDbType.NVarChar, ParameterDirection.Input));
            parms.Add(new SqlJacknife.ParmStruct("@altText", alttext, 50, SqlDbType.NVarChar, ParameterDirection.Input));
            parms.Add(new SqlJacknife.ParmStruct("@locus", locus, 150, SqlDbType.NVarChar, ParameterDirection.Input));
            parms.Add(new SqlJacknife.ParmStruct("@ID_Adm", ID_Adm, 0, SqlDbType.Int, ParameterDirection.Input));

            if (SqlJacknife.SendCommand("Save_Image", parms) != 0)
            {
                return true;
            }
            return false;
        }

        /// <summary>
        /// Returns the unverified images that the current admin can verify
        /// </summary>
        /// <param name="ID_Adm"></param>
        /// <returns>A datatable images</returns>
        public DataTable Load_Unverified(int ID_Adm)
        {
            DataTable unverifiedImages = new DataTable();
            List<SqlJacknife.ParmStruct> parms = new List<SqlJacknife.ParmStruct>();
            parms.Add(new SqlJacknife.ParmStruct("@ID_Adm", ID_Adm, 0, SqlDbType.Int, ParameterDirection.Input));

            unverifiedImages = SqlJacknife.GetDataTable("Load_Unverified", parms);
            return unverifiedImages;
        }

            /// <summary>
            /// Verify a single image. Throws an exception if the verifier and uploader are the same
            /// </summary>
            /// <param name="ID_Img"></param>
            /// <param name="ID_Adm"></param>
            /// <returns>True if the save was succesful</returns>
            public bool VerifyImage(int ID_Img, int ID_Adm, string newLocus)
            {
                List<SqlJacknife.ParmStruct> parms = new List<SqlJacknife.ParmStruct>();
                parms.Add(new SqlJacknife.ParmStruct("@ID_Adm", ID_Adm, 0, SqlDbType.Int, ParameterDirection.Input));
                parms.Add(new SqlJacknife.ParmStruct("@ID_Img", ID_Img, 0, SqlDbType.Int, ParameterDirection.Input));
                parms.Add(new SqlJacknife.ParmStruct("@newLocus", newLocus, 150, SqlDbType.NVarChar, ParameterDirection.Input));

                if (SqlJacknife.SendCommand("VerifyImage", parms) != 0)
                {
                    return true;
                }
                return false;

            }

            /// <summary>
            /// Loads all verified images
            /// </summary>
            /// <returns></returns>
            public DataTable Load_Verified()
            {
                return SqlJacknife.GetDataTable("Load_Verified", new List<SqlJacknife.ParmStruct>());
            }

            /// <summary>
            /// Loads a single image
            /// </summary>
            /// <param name="ID_Img"></param>
            /// <returns>A (hopefully) one-row DataTable</returns>
            public DataTable Load_Image(int ID_Img)
            {
                List<SqlJacknife.ParmStruct> parms = new List<SqlJacknife.ParmStruct>();
                parms.Add(new SqlJacknife.ParmStruct("@ID_Img", ID_Img, 0, SqlDbType.Int, ParameterDirection.Input));

                return SqlJacknife.GetDataTable("Load_Image", parms);
            }

        /// <summary>
        /// Updates an image
        /// </summary>
        /// <param name="ID_Img"></param>
        /// <param name="fileName"></param>
        /// <param name="alttext"></param>
        /// <param name="locus"></param>
        /// <param name="active"></param>
        /// <returns></returns>
        public bool Update_Image(int ID_Img, string fileName, string alttext, string locus, bool active)
        {
            List<SqlJacknife.ParmStruct> parms = new List<SqlJacknife.ParmStruct>();
            parms.Add(new SqlJacknife.ParmStruct("@ID_Img", ID_Img, 0, SqlDbType.Int, ParameterDirection.Input));
            parms.Add(new SqlJacknife.ParmStruct("@fileName", fileName, 50, SqlDbType.NVarChar, ParameterDirection.Input));
            parms.Add(new SqlJacknife.ParmStruct("@altText", alttext, 50, SqlDbType.NVarChar, ParameterDirection.Input));
            parms.Add(new SqlJacknife.ParmStruct("@locus", locus, 150, SqlDbType.NVarChar, ParameterDirection.Input));
            parms.Add(new SqlJacknife.ParmStruct("@active", active, 0, SqlDbType.Bit, ParameterDirection.Input));

            if (SqlJacknife.SendCommand("Update_Image", parms) != 0)
            {
                return true;
            }
            return false;
        }

        /// <summary>
        /// Deletes an image
        /// </summary>
        /// <param name="ID_Img"></param>
        /// <returns></returns>
        public bool Delete_Image(int ID_Img)
        {
            List<SqlJacknife.ParmStruct> parms = new List<SqlJacknife.ParmStruct>();
            parms.Add(new SqlJacknife.ParmStruct("@ID_Img", ID_Img, 0, SqlDbType.Int, ParameterDirection.Input));

            if (SqlJacknife.SendCommand("Delete_Image", parms) != 0)
            {
                return true;
            }
            return false;
        }


    }
}