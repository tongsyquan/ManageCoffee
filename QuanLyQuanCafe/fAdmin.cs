using QuanLyQuanCafe.DAO;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QuanLyQuanCafe
{
    public partial class fAdmin : Form
    {
        public fAdmin()
        {
            InitializeComponent();


            LoadAccountList();
        }

        void LoadFood()
        {

            string query = "select * from Food";
            dtgvFood.DataSource = DataProvider.Instance.ExcuteQuery(query);
        }

        void LoadAccountList()
        {
            
            string query = "Exec dbo.USP_GetAccountByUserName @Username";
            dtgvAccount.DataSource = DataProvider.Instance.ExcuteQuery(query, new object[]{"staff"});
        }
    }
}
