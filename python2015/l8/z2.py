import Tkinter
import shelve

class DB:
  def __init__(self):
    self.database = shelve.open('data.db')

  def add_cd(self, title, author, songs, borrowed):
    self.database[title] = [author, songs, borrowed]

  def delete_cd(self, key):
    del self.database[key]

  def find_cd(self, key):
    for k in self.database:
      if k == key:
        return self.database[key]
    return None
 
  def edit_cd(self, old_title, title, author, songs, borrowed):
    self.delete_cd(old_title)
    self.add_cd(title, author, songs, borrowed)

class App:
  def __init__(self):
    self.database = DB()

    self.window = Tkinter.Tk()
    self.window.geometry("500x300")
    self.window.title("CDs manager")
    self.frame = Tkinter.Frame(self.window)
    self.frame.pack(fill = Tkinter.BOTH, expand = 1)

    Tkinter.Label (self.frame, text = "INFO").grid(row = 0, column = 1, columnspan = 2)

    Tkinter.Label (self.frame, text = "Title:").grid(row = 1, column = 1)
    self.str_title = Tkinter.StringVar()
    self.entry_title = Tkinter.Entry(self.frame, textvariable = self.str_title).grid(row = 1, column = 2)

    Tkinter.Label (self.frame, text = "Author:").grid(row = 2, column = 1)
    self.str_author = Tkinter.StringVar()
    self.entry_author = Tkinter.Entry(self.frame, textvariable = self.str_author).grid(row = 2, column = 2)

    Tkinter.Label (self.frame, text = "Songs:").grid(row = 3, column = 1)
    self.str_songs = Tkinter.StringVar()
    self.entry_songs = Tkinter.Entry(self.frame, textvariable = self.str_songs).grid(row = 3, column = 2)

    Tkinter.Label (self.frame, text = "Borrowed:").grid(row = 4, column = 1)
    self.str_borrowed = Tkinter.StringVar()
    self.entry_borrowed = Tkinter.Entry(self.frame, textvariable = self.str_borrowed).grid(row = 4, column = 2)

    self.button_add = Tkinter.Button(self.frame, text = "Add", command = self.add_cd).grid(row = 5, column = 2)

    #list of cds
    Tkinter.Label(self.frame, text = "CDs List").grid(row = 0, column = 0)
    self.listbox = Tkinter.Listbox(self.frame)
    
    for i in self.database.database:
      self.listbox.insert(Tkinter.END, i)

    self.listbox.bind("<<ListboxSelect>>", self.listbox_select)
    self.listbox.grid(row = 1, rowspan = 4)

    #searching
    Tkinter.Label(self.frame, text = "Search:").grid(row = 5)
    self.str_search = Tkinter.StringVar()
    self.entry_search = Tkinter.Entry(self.frame, textvariable = self.str_search).grid(row = 6, column = 0)
    self.button_search = Tkinter.Button(self.frame, text = "Search", command = self.search_cd).grid(row = 7, column = 0)

  def listbox_select(self, val):
    sender = val.widget
    idk = sender.curselection()
    key = sender.get(idk)

    self.str_title.set(key)
    self.str_author.set(self.database.database[key][0])
    self.str_songs.set(self.database.database[key][1])
    self.str_borrowed.set(self.database.database[key][2])
    Tkinter.Button(self.frame, text="Delete", command = lambda: self.delete_cd(key)).grid(row = 5, column = 1)
    Tkinter.Button(self.frame, text="Save", command = lambda:self.edit_cd(key)).grid(row = 6, column = 1)

  def search_cd(self):
    key = self.str_search.get()
    found = self.database.find_cd(key)
    if (found):
      self.str_title.set(key)
      self.str_author.set(found[0])
      self.str_songs.set(found[1])
      self.str_borrowed.set(found[2])
      Tkinter.Button(self.frame,text="Delete", command = lambda: self.delete_cd(key)).grid(row = 5, column = 1)
      Tkinter.Button(self.frame, text="Save", command = lambda: self.edit_cd(key)).grid(row = 6, column = 1)

  def add_cd(self):
    self.database.add_cd(self.str_title.get(), self.str_author.get(), self.str_songs.get(), self.str_borrowed.get())
    self.listbox.insert(Tkinter.END, self.str_title.get())

  def delete_cd(self, title):
    self.database.delete_cd(title)
    self.listbox.delete(self.listbox.curselection())
    self.str_title.set("")
    self.str_author.set("")
    self.str_songs.set("")
    self.str_borrowed.set("")

  def edit_cd(self, old_title):
    self.database.edit_cd(old_title, self.str_title.get(), self.str_author.get(), self.str_songs.get(), self.str_borrowed.get())
    self.listbox.delete(self.listbox.curselection())
    self.listbox.insert(Tkinter.END, self.str_title.get())


app = App()
app.window.mainloop()
