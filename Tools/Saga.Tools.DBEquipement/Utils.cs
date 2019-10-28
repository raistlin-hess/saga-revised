using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Saga.Tools.DBEquipement
{
    public static class Utils
    {
        public static MySqlConnection getDatabaseConnection()
        {
            MySqlConnectionStringBuilder cb = new MySqlConnectionStringBuilder();
            cb.UserID = Properties.Settings.Default.db_username;
            cb.Password = Properties.Settings.Default.db_password;
            cb.Port = Properties.Settings.Default.db_port;
            cb.Server = Properties.Settings.Default.db_host;
            cb.Database = Properties.Settings.Default.db_name;

            return new MySqlConnection(cb.ConnectionString);
        }
    }
}
