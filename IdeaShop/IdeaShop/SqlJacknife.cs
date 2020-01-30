//David Schriver
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI.WebControls;

namespace IdeaShop
{
    class SqlJacknife
    {
        public static SqlCommand CreateCommand(string cmdText, List<ParmStruct> parms, CommandType cmdType = CommandType.StoredProcedure)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["cnn"].ConnectionString);

            SqlCommand toSend = new SqlCommand(cmdText, conn);
            toSend.CommandType = cmdType;

            for (int a = 0; a < parms.Count; a++)
            {
                SqlParameter PutMe = new SqlParameter(parms[a].Name, parms[a].DataType, parms[a].Size);
                PutMe.Value = parms[a].Value;

                PutMe.Direction = parms[a].Direction;

                toSend.Parameters.Add(PutMe);
            }

            return toSend;
        }

        public static DataSet GetDS(string cmdText, List<ParmStruct> parms, CommandType cmdType = CommandType.StoredProcedure)
        {
            SqlCommand cmd = CreateCommand(cmdText, parms, cmdType);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet toSend = new DataSet();
            da.Fill(toSend);
            return toSend;
        }

        public static DataTable GetDataTable(string cmdText, List<ParmStruct> parms, CommandType cmdType = CommandType.StoredProcedure)
        {
            SqlCommand cmd = CreateCommand(cmdText, parms, cmdType);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable toSend = new DataTable();
            da.Fill(toSend);
            return toSend;
        }

        public static SqlDataReader GetDR(string cmdText, List<ParmStruct> parms, CommandType cmdType = CommandType.StoredProcedure)
        {
            SqlCommand cmd = CreateCommand(cmdText, parms, cmdType);
            SqlDataReader toSend = default(SqlDataReader);
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["cnn"].ConnectionString);

            using (conn)
            {
                conn.Open();
                toSend = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
            }

                return toSend;
            
        }

        public static int SendCommand(string cmdText, List<ParmStruct> parms, CommandType cmdType = CommandType.StoredProcedure)
        {
            int toSend = -1;

            SqlCommand cmd = CreateCommand(cmdText, parms, cmdType);

            using (cmd.Connection)
            {
                cmd.Connection.Open();
                toSend = cmd.ExecuteNonQuery();

            }


            return toSend;
        }

        public static string SendCommandGetString(string cmdText, List<ParmStruct> parms, CommandType cmdType = CommandType.StoredProcedure)
        {
            String toSend = "";

            SqlCommand cmd = CreateCommand(cmdText, parms, cmdType);

            using (cmd.Connection)
            {
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

            }

            toSend = cmd.Parameters[0].Value.ToString();

            return toSend;
        }


        public struct ParmStruct
        {
            public string Name;
            public object Value;
            public int Size;
            public SqlDbType DataType;
            public ParameterDirection Direction;

            public ParmStruct(string name, object value, int size, SqlDbType datatype, ParameterDirection direction)
            {
                Name = name;
                Value = value;
                Size = size;
                DataType = datatype;
                Direction = direction;
            }

            public ParmStruct DispenseParm()
            {
                ParmStruct toSend = new ParmStruct();

                return toSend;
            }
        }

        /// <summary>
        /// Put your stored procedure and repeater in to bind the repeater.
        /// </summary>
        /// <param name="proc"></param>
        /// <param name="stapleMe"></param>
        /// <param name="lblOutput"></param>
        /// 
        public static void stapleRepeater(String proc, Repeater stapleMe, Label lblOutput = null)
        {
            SqlDataReader dr = default(SqlDataReader);
            SqlCommand cmd = default(SqlCommand);

            try
            {
                using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["cnn"].ConnectionString))
                {
                    cmd = new SqlCommand(proc, cnn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cnn.Open();
                    dr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);

                    if (dr.HasRows)
                    {
                        stapleMe.DataSource = dr;
                        stapleMe.DataBind();
                    }
                    else
                    {
                        if (lblOutput != null)
                        {
                            lblOutput.Visible = true;
                            lblOutput.Text = "No results :(";
                        }
                    }
                }



            }
            catch (Exception ex)
            {
                if (lblOutput != null)
                {
                    lblOutput.Visible = true;
                    lblOutput.Text = ex.Message;
                }
            }
            finally
            {
                dr.Close();
            }
        }




    }
}
