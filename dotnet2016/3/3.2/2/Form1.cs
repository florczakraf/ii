using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace _2
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            listView1.Columns.Add("Time", 100);
            listView1.Columns.Add("Value", 100);
        }

        private void progressBar1_Click(object sender, EventArgs e)
        {
            Random rnd = new Random();
            progressBar1.Value = rnd.Next(0, 101);

            string[] arr = new string[2];
            arr[0] = DateTime.Now.ToLongTimeString();
            arr[1] = progressBar1.Value.ToString();

            ListViewItem item = new ListViewItem(arr);

            listView1.Items.Insert(0, item);

            toolStripStatusLabel1.Text = progressBar1.Value.ToString();

        }
    }
}
