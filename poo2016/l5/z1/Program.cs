using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Net.Mime;
using System.Text;
using System.Threading.Tasks;

namespace z1
{
  class Program
  {
    static void Main(string[] args)
    {

    }

    class SmtpFacade
    {
      public void Send(string From, string To, string Subject, 
        string Body, Stream Attachment, string AttachmentMimeType)
      {
        MailMessage mail = new MailMessage(From, To);
        mail.Subject = Subject;
        mail.Attachments.Add(new Attachment(Attachment, new ContentType(AttachmentMimeType)));

        SmtpClient smtpClient = new SmtpClient(); // jakaś konfiguracja by się przydała
        smtpClient.Send(mail);
      }
    }
  }
}
