using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace TKFTaskDemo.BLL
{
    public class ConnectionManager
    {
        private static string _ConnectionString = ConfigurationManager.ConnectionStrings["ConString"].ConnectionString;

        public static string ConnectionString
        {
            get
            {
                return _ConnectionString;
            }
        }
    }
}