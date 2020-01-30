using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace IdeaShop.App_Code
{
    public class ConnectionStrings
    {

        public ConnectionStrings()
        {

        }

        public static string GetCnnString(string keyName)
        {
            string cnnString = string.Empty;
            switch (keyName)
            {
                case "acnn":
                    cnnString = ConfigurationManager.ConnectionStrings["acnn"].ConnectionString;
                    break;
                case "cnn":
                    cnnString = ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;
                    break;
                case "scnn":
                    cnnString = ConfigurationManager.ConnectionStrings["scnn"].ConnectionString;
                    break;
                default:
                    throw new Exception("No database found with key name: " + keyName);
            }
            return cnnString;
        }
    }
}