using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace _1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void btnAkceptuj_Click(object sender, EventArgs e)
        {
            string tmp = string.Format("{0}\n{1}\n{2}", txtNazwa.Text, txtAdres.Text, cmbCykl.Text);
            if (chkDzienne.Checked)
                tmp += string.Format("\n{0}", chkDzienne.Text);
            if (chkUzupelniajace.Checked)
                tmp += string.Format("\n{0}", chkUzupelniajace.Text);

            MessageBox.Show(tmp, "Uczelnia");
        }

        private void btnAnuluj_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }
    }
}
