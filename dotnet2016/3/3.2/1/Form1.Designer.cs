namespace _1
{
  partial class Form1
  {
    /// <summary>
    /// Required designer variable.
    /// </summary>
    private System.ComponentModel.IContainer components = null;

    /// <summary>
    /// Clean up any resources being used.
    /// </summary>
    /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
    protected override void Dispose(bool disposing)
    {
      if (disposing && (components != null))
      {
        components.Dispose();
      }
      base.Dispose(disposing);
    }

    #region Windows Form Designer generated code

    /// <summary>
    /// Required method for Designer support - do not modify
    /// the contents of this method with the code editor.
    /// </summary>
    private void InitializeComponent()
    {
      this.groupBox1 = new System.Windows.Forms.GroupBox();
      this.label1 = new System.Windows.Forms.Label();
      this.label2 = new System.Windows.Forms.Label();
      this.groupBox2 = new System.Windows.Forms.GroupBox();
      this.label3 = new System.Windows.Forms.Label();
      this.txtNazwa = new System.Windows.Forms.TextBox();
      this.txtAdres = new System.Windows.Forms.TextBox();
      this.cmbCykl = new System.Windows.Forms.ComboBox();
      this.chkDzienne = new System.Windows.Forms.CheckBox();
      this.chkUzupelniajace = new System.Windows.Forms.CheckBox();
      this.btnAkceptuj = new System.Windows.Forms.Button();
      this.btnAnuluj = new System.Windows.Forms.Button();
      this.groupBox1.SuspendLayout();
      this.groupBox2.SuspendLayout();
      this.SuspendLayout();
      // 
      // groupBox1
      // 
      this.groupBox1.Controls.Add(this.txtAdres);
      this.groupBox1.Controls.Add(this.txtNazwa);
      this.groupBox1.Controls.Add(this.label2);
      this.groupBox1.Controls.Add(this.label1);
      this.groupBox1.Location = new System.Drawing.Point(12, 12);
      this.groupBox1.Name = "groupBox1";
      this.groupBox1.Size = new System.Drawing.Size(371, 70);
      this.groupBox1.TabIndex = 0;
      this.groupBox1.TabStop = false;
      this.groupBox1.Text = "Uczelnia";
      // 
      // label1
      // 
      this.label1.AutoSize = true;
      this.label1.Location = new System.Drawing.Point(7, 20);
      this.label1.Name = "label1";
      this.label1.Size = new System.Drawing.Size(46, 13);
      this.label1.TabIndex = 0;
      this.label1.Text = "Nazwa: ";
      // 
      // label2
      // 
      this.label2.AutoSize = true;
      this.label2.Location = new System.Drawing.Point(6, 46);
      this.label2.Name = "label2";
      this.label2.Size = new System.Drawing.Size(40, 13);
      this.label2.TabIndex = 1;
      this.label2.Text = "Adres: ";
      // 
      // groupBox2
      // 
      this.groupBox2.Controls.Add(this.chkUzupelniajace);
      this.groupBox2.Controls.Add(this.chkDzienne);
      this.groupBox2.Controls.Add(this.cmbCykl);
      this.groupBox2.Controls.Add(this.label3);
      this.groupBox2.Location = new System.Drawing.Point(12, 88);
      this.groupBox2.Name = "groupBox2";
      this.groupBox2.Size = new System.Drawing.Size(371, 74);
      this.groupBox2.TabIndex = 1;
      this.groupBox2.TabStop = false;
      this.groupBox2.Text = "Rodzaj studiów";
      // 
      // label3
      // 
      this.label3.AutoSize = true;
      this.label3.Location = new System.Drawing.Point(7, 20);
      this.label3.Name = "label3";
      this.label3.Size = new System.Drawing.Size(62, 13);
      this.label3.TabIndex = 0;
      this.label3.Text = "Cykl nauki: ";
      // 
      // txtNazwa
      // 
      this.txtNazwa.Location = new System.Drawing.Point(75, 17);
      this.txtNazwa.Name = "txtNazwa";
      this.txtNazwa.Size = new System.Drawing.Size(290, 20);
      this.txtNazwa.TabIndex = 2;
      // 
      // txtAdres
      // 
      this.txtAdres.Location = new System.Drawing.Point(75, 43);
      this.txtAdres.Name = "txtAdres";
      this.txtAdres.Size = new System.Drawing.Size(290, 20);
      this.txtAdres.TabIndex = 3;
      // 
      // cmbCykl
      // 
      this.cmbCykl.FormattingEnabled = true;
      this.cmbCykl.Items.AddRange(new object[] {
            "3-letnie",
            "3,5-letnie",
            "5-letnie"});
      this.cmbCykl.Location = new System.Drawing.Point(75, 17);
      this.cmbCykl.Name = "cmbCykl";
      this.cmbCykl.Size = new System.Drawing.Size(290, 21);
      this.cmbCykl.TabIndex = 1;
      // 
      // chkDzienne
      // 
      this.chkDzienne.AutoSize = true;
      this.chkDzienne.Location = new System.Drawing.Point(75, 51);
      this.chkDzienne.Name = "chkDzienne";
      this.chkDzienne.Size = new System.Drawing.Size(63, 17);
      this.chkDzienne.TabIndex = 2;
      this.chkDzienne.Text = "dzienne";
      this.chkDzienne.UseVisualStyleBackColor = true;
      // 
      // chkUzupelniajace
      // 
      this.chkUzupelniajace.AutoSize = true;
      this.chkUzupelniajace.Location = new System.Drawing.Point(144, 51);
      this.chkUzupelniajace.Name = "chkUzupelniajace";
      this.chkUzupelniajace.Size = new System.Drawing.Size(93, 17);
      this.chkUzupelniajace.TabIndex = 3;
      this.chkUzupelniajace.Text = "uzupełniające";
      this.chkUzupelniajace.UseVisualStyleBackColor = true;
      // 
      // btnAkceptuj
      // 
      this.btnAkceptuj.Location = new System.Drawing.Point(12, 168);
      this.btnAkceptuj.Name = "btnAkceptuj";
      this.btnAkceptuj.Size = new System.Drawing.Size(75, 23);
      this.btnAkceptuj.TabIndex = 2;
      this.btnAkceptuj.Text = "Akceptuj";
      this.btnAkceptuj.UseVisualStyleBackColor = true;
      this.btnAkceptuj.Click += new System.EventHandler(this.btnAkceptuj_Click);
      // 
      // btnAnuluj
      // 
      this.btnAnuluj.Location = new System.Drawing.Point(308, 168);
      this.btnAnuluj.Name = "btnAnuluj";
      this.btnAnuluj.Size = new System.Drawing.Size(75, 23);
      this.btnAnuluj.TabIndex = 3;
      this.btnAnuluj.Text = "Anuluj";
      this.btnAnuluj.UseVisualStyleBackColor = true;
      this.btnAnuluj.Click += new System.EventHandler(this.btnAnuluj_Click);
      // 
      // Form1
      // 
      this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
      this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
      this.ClientSize = new System.Drawing.Size(395, 200);
      this.Controls.Add(this.btnAnuluj);
      this.Controls.Add(this.btnAkceptuj);
      this.Controls.Add(this.groupBox2);
      this.Controls.Add(this.groupBox1);
      this.Name = "Form1";
      this.Text = "Wybór uczelni";
      this.groupBox1.ResumeLayout(false);
      this.groupBox1.PerformLayout();
      this.groupBox2.ResumeLayout(false);
      this.groupBox2.PerformLayout();
      this.ResumeLayout(false);

    }

    #endregion

    private System.Windows.Forms.GroupBox groupBox1;
    private System.Windows.Forms.TextBox txtAdres;
    private System.Windows.Forms.TextBox txtNazwa;
    private System.Windows.Forms.Label label2;
    private System.Windows.Forms.Label label1;
    private System.Windows.Forms.GroupBox groupBox2;
    private System.Windows.Forms.CheckBox chkUzupelniajace;
    private System.Windows.Forms.CheckBox chkDzienne;
    private System.Windows.Forms.ComboBox cmbCykl;
    private System.Windows.Forms.Label label3;
    private System.Windows.Forms.Button btnAkceptuj;
    private System.Windows.Forms.Button btnAnuluj;
  }
}

