import gtk
import gobject

class Timer:
  def __init__(self):
    self.window = gtk.Window()
    self.window.connect("destroy", self.destroy)
    self.window.connect("delete_event", self.delete_event)
    self.window.set_border_width(10)
    self.window.set_title("Timer")

    vbox = gtk.VBox()
    self.window.add(vbox)

    self.label = gtk.Label("What do we cook today?")
    vbox.pack_start(self.label)

    hbox = gtk.HBox()
    vbox.pack_start(hbox)

    label = gtk.Label("Time (s): ")
    hbox.pack_start(label)

    self.input_entry = gtk.Entry()
    hbox.pack_start(self.input_entry)

    button_start = gtk.Button("Start")
    button_start.connect("clicked", self.start_clicked)
    hbox.pack_start(button_start)

    vbox.pack_start(gtk.Label("PRESETS"))

    hbox = gtk.HBox()
    vbox.pack_start(hbox)

    button_eggs = gtk.Button("Eggs")
    button_eggs.connect("clicked", self.eggs_clicked)
    hbox.pack_start(button_eggs)

    button_rice = gtk.Button("Rice")
    button_rice.connect("clicked", self.rice_clicked)
    hbox.pack_start(button_rice)

    self.window.show_all()

  def delete_event(widget, event, data = None):
    print "delete event occurred"
    return False

  def destroy(widget, data = None):
    print "destroy"
    gtk.main_quit()

  def start_clicked(self, sender):
    self.counter = int(self.input_entry.get_text()) - 1
    gobject.timeout_add(1000, self.countdown)

  def eggs_clicked(self, sender):
    self.counter = 179
    gobject.timeout_add(1000, self.countdown)

  def rice_clicked(self,sender):
    self.counter = 599
    gobject.timeout_add(1000,self.countdown)

  def countdown(self):
    if self.counter > 0:
      self.label.set_text("Remaining time: " + str(self.counter) + "s")
      self.counter -= 1
      return True
    else:
      self.label.set_text("DONE!")
      return False

if __name__ == "__main__":
  app = Timer()
  gtk.main()
