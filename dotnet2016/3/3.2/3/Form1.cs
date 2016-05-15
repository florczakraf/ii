using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace _3
{
    public partial class Form1 : Form
    {
        Timer t;
        Point mid;


        public Form1()
        {
            InitializeComponent();

            ClientSize = new Size(400, 400);
            mid = new Point(ClientSize.Width / 2, ClientSize.Height / 2);

            t = new Timer();
            t.Tick += new EventHandler(OnTick);
            t.Interval = 1000;
            t.Start();

            SetStyle(ControlStyles.UserPaint, true);
            SetStyle(ControlStyles.AllPaintingInWmPaint, true);
            SetStyle(ControlStyles.OptimizedDoubleBuffer, true);

        }

        void OnTick(object sender, EventArgs e)
        {
            Graphics g = Graphics.FromHwnd(Handle);
            g.Clear(Color.White);
            g.DrawEllipse(Pens.Black, 10, 10, ClientSize.Width - 20, ClientSize.Height - 20);
            

            DrawHour(g);
            DrawMinute(g);
            DrawSecond(g);

            g.Dispose();
        }

        void DrawHour(Graphics g)
        {
            Point h = AnalogClock.GetHour(mid, ClientSize.Width / 4.0d);
            g.DrawLine(new Pen(Color.Black, 3), mid, h);
        }

        void DrawMinute(Graphics g)
        {
            Point h = AnalogClock.GetMinute(mid, ClientSize.Width / 3.0d);
            g.DrawLine(new Pen(Color.Black, 2), mid, h);
        }

        void DrawSecond(Graphics g)
        {
            Point h = AnalogClock.GetSecond(mid, ClientSize.Width / 2.5d);
            g.DrawLine(new Pen(Color.Black, 1), mid, h);
        }

        private void Form1_Resize(object sender, EventArgs e)
        {
            mid.X = ClientSize.Width / 2;
            mid.Y = ClientSize.Height / 2;
        }
    }

    static class AnalogClock
    {
        const double MStep = 2 * Math.PI / 60.0d;
        const double HStep = 2 * Math.PI / 12.0d;

        static public Point GetHour(Point mid, double len)
        {
            DateTime dt = DateTime.Now;
            double hourProgress = dt.Minute / 60.0d;
            double angle = -90 * Math.PI / 180.0d + (HStep * (dt.Hour % 12)) + (hourProgress * HStep);

            return new Point(mid.X + Convert.ToInt32(len * Math.Cos(angle)), mid.Y + Convert.ToInt32(len * Math.Sin(angle)));
        }

        static public Point GetMinute(Point mid, double len)
        {
            DateTime dt = DateTime.Now;
            double angle = -90 * Math.PI / 180.0d + (dt.Minute * MStep);

            return new Point(mid.X + Convert.ToInt32(len * Math.Cos(angle)), mid.Y + Convert.ToInt32(len * Math.Sin(angle)));
        }

        static public Point GetSecond(Point mid, double len)
        {
            DateTime dt = DateTime.Now;
            double angle = -90 * Math.PI / 180.0d + (dt.Second * MStep);

            return new Point(mid.X + Convert.ToInt32(len * Math.Cos(angle)), mid.Y + Convert.ToInt32(len * Math.Sin(angle)));
        }
    }
}
