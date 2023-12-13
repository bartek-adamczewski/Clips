from tkinter import *
from tkinter import ttk
import clips

def readResources(resourceList):
    with open('./src/resources/DrinkResources.properties', 'r') as file:
        lines = file.readlines()
        for line in lines:
            print(line)
            title, value = line.replace('\n', '').split('=')
            resourceList[title] = value




resources = {}
readResources(resources)

print(resources)

environment = clips.Environment()
#environment.load('')
#environment.reset()
#environment._agenda.run()

root = Tk()
root.title('What should I drink?')
root.geometry('800x500')
frm = ttk.Frame(root, padding=15)
frm.grid()
ttk.Label(frm, text="What should I drink?").grid(row=0)

titleLabel = Label()
answer1 = Button()
answer2 = Button()
answer3 = Button()
answer4 = Button()
previousButton = Button()
nextButton = Button()



root.mainloop()