from tkinter import *
from PIL import ImageTk, Image
import os
import sys
sys.path.insert(1, 'sourceCode')
from generatewheelfunction import *
from pythonrender import renderimage

#import numpy as np 

def doNothing():
    print('Generating STL geometry...')
    
def generate():
    size1 = int(entry_1.get())
    size2 = int(entry_2.get())
    size3 = int(entry_3.get())
    #LG1 = entry_1_LG.get()
    LG1 = LGtypevar.get()
    LG2 = LGnumvar.get()
    LG3 = entry_3_LG.get()
    LG4 = entry_4_LG.get()
    LG5 = entry_5_LG.get()
    #QG1 = entry_1_QG.get()
    QG1 = QGtypevar.get()
    QG2 = entry_2_QG.get()
    QG3 = entry_3_QG.get()
    QG4 = entry_4_QG.get()
    QG5 = entry_5_QG.get()
    render = c_render_var.get()
    MRF = c_MRF_var.get()
    if MRF:
        QG2 = int(QG2)
        QG3 = int(QG3)
        QG4 = int(QG4)
        QG5 = int(QG5)

    size = [size1,size2,size3]
    LG = [LG1,LG2,LG3,LG4,LG5]
    QG = [QG1,QG2,QG3,QG4,QG5]

    print('Generating the following geometry:')
    print('Tire: ' + str(size1) + '/' + str(size2) + ' R' + str(size3))
    print('LG  : ' + str(LG1) + '_' + str(LG2) + '_' + str(LG3) + '_' + str(LG4) + '_' + str(LG5))
    print('QG  : ' + str(QG1) + '_' + str(QG2) + '_' + str(QG3) + '_' + str(QG4) + '_' + str(QG5))

    filename = generatewheelfunction(size,LG,QG,MRF)

    

    if render:
        options = []
        if size == [245,45,18]:
            options = 'full'
        
        renderimage(filename,options)

        img1 = ImageTk.PhotoImage(Image.open('render/render.png'))
        panel.configure(image=img1)
        root.mainloop()
    
    else:
        root.destroy()



def closeALL():
    root.destroy()


def changeFig():
    img1 = ImageTk.PhotoImage(Image.open('4CT_Slick.png'))
    #img1 = ImageTk.PhotoImage(Image.open('render.png'))
    panel.configure(image=img1)
    
    root.mainloop()

def deleteEntries():
        #CLEAR ENTRIES
    entry_1.delete(0,END)
    entry_2.delete(0,END)
    entry_3.delete(0,END)
    #entry_2_LG.delete(0,END)
    entry_3_LG.delete(0,END)
    entry_4_LG.delete(0,END)
    entry_5_LG.delete(0,END)
    entry_2_QG.delete(0,END)
    entry_3_QG.delete(0,END)
    entry_4_QG.delete(0,END)
    entry_5_QG.delete(0,END)
    QGtypevar.set('')      

def shownomenclature():
    deleteEntries()
    #PRINT NOMENCLATURE
    entry_1.insert(0, "Width [mm]")
    entry_2.insert(0, "Aspect Ratio")
    entry_3.insert(0, "Radius [in]")   
    #entry_2_LG.insert(0, "Number of Grooves")
    entry_3_LG.insert(0, "Grooves: ⊥Area")
    entry_4_LG.insert(0, "Shape Mod")
    entry_5_LG.insert(0, "Gap Mod")
    entry_2_QG.insert(0, "Inclination")
    entry_3_QG.insert(0, "Groove Number")
    entry_4_QG.insert(0, "Groove Length")
    entry_5_QG.insert(0, "Groove Width")

    entry_3_LG.after(5000,deleteEntries)

    #entry_1.delete(0,END)
    #entry_2.delete(0,END)
    #entry_3.delete(0,END)
    #entry_3_LG.delete(0,END)
    #entry_4_LG.delete(0,END)
    #entry_5_LG.delete(0,END)
    #entry_2_QG.delete(0,END)
    #entry_3_QG.delete(0,END)
    #entry_4_QG.delete(0,END)
    #entry_5_QG.delete(0,END)
    
def relaunch():
    root.destroy()
    import wheel

def doslick():
    deleteEntries()
    #PRINT NOMENCLATURE
    entry_1.insert(0, "245")
    entry_2.insert(0, "45")
    entry_3.insert(0, "18")  
    LGtypevar.set('Slick')
    LGnumvar.set('') 
    QGtypevar.set('')
    #entry_2_LG.insert(0, "Number of Grooves")
    entry_3_LG.insert(0, "")
    entry_4_LG.insert(0, "")
    entry_5_LG.insert(0, "")
    entry_2_QG.insert(0, "")
    entry_3_QG.insert(0, "")
    entry_4_QG.insert(0, "")
    entry_5_QG.insert(0, "")
    c_render.select()
def do3far():
    deleteEntries()
    #PRINT NOMENCLATURE
    entry_1.insert(0, "245")
    entry_2.insert(0, "45")
    entry_3.insert(0, "18")   
    LGnumvar.set('3')
    LGtypevar.set('Far') 
    QGtypevar.set('')    
    #entry_2_LG.insert(0, "Number of Grooves")
    entry_3_LG.insert(0, "")
    entry_4_LG.insert(0, "")
    entry_5_LG.insert(0, "")
    entry_2_QG.insert(0, "")
    entry_3_QG.insert(0, "")
    entry_4_QG.insert(0, "")
    entry_5_QG.insert(0, "")   
    c_render.select()
def do4far():
    deleteEntries()
    #PRINT NOMENCLATURE
    entry_1.insert(0, "245")
    entry_2.insert(0, "45")
    entry_3.insert(0, "18") 
    LGnumvar.set('4')  
    LGtypevar.set('Far') 
    QGtypevar.set('')    
    #entry_2_LG.insert(0, "Number of Grooves")
    entry_3_LG.insert(0, "")
    entry_4_LG.insert(0, "")
    entry_5_LG.insert(0, "")
    entry_2_QG.insert(0, "")
    entry_3_QG.insert(0, "")
    entry_4_QG.insert(0, "")
    entry_5_QG.insert(0, "")
    c_render.select()
def do20804530():
    deleteEntries()
    #PRINT NOMENCLATURE
    entry_1.insert(0, "245")
    entry_2.insert(0, "45")
    entry_3.insert(0, "18")   
    LGnumvar.set('4')
    LGtypevar.set('Far') 
    QGtypevar.set('2')    
    #entry_2_LG.insert(0, "Number of Grooves")
    entry_3_LG.insert(0, "")
    entry_4_LG.insert(0, "")
    entry_5_LG.insert(0, "")
    entry_2_QG.insert(0, "0")
    entry_3_QG.insert(0, "80")
    entry_4_QG.insert(0, "45")
    entry_5_QG.insert(0, "30")
    c_render.select()
    c_MRF.select()



root = Tk()
root.bind('<Escape>', lambda e: root.destroy())
label_1 = Label(root, text='  Tire                    ')
label_2 = Label(root, text='  Longitudinal Grooves    ')
label_3 = Label(root, text='  Lateral Grooves         ')

entry_1 = Entry(root,justify='center',width=15)
entry_2 = Entry(root,justify='center',width=15)
entry_3 = Entry(root,justify='center',width=15)
#entry_1_LG = Entry(root,justify='center',width=15)
entry_2_LG = Entry(root,justify='center',width=15)
entry_3_LG = Entry(root,justify='center',width=15)
entry_4_LG = Entry(root,justify='center',width=15)
entry_5_LG = Entry(root,justify='center',width=15)
#entry_1_QG = Entry(root,justify='center',width=15)
entry_2_QG = Entry(root,justify='center',width=15)
entry_3_QG = Entry(root,justify='center',width=15)
entry_4_QG = Entry(root,justify='center',width=15)
entry_5_QG = Entry(root,justify='center',width=15)

LGtypevar = StringVar(root)
choices_LGtype = ['Central','Far','Left','Right','Slick']
LGtypevar.set('Slick')

LGnumvar = StringVar(root)
choices_LGnum = ['1','2','3','4','5','']
LGnumvar.set('')


popupMenu_LGtype = OptionMenu(root,LGtypevar,*choices_LGtype)
popupMenu_LGtype.grid(row=2,column=1,sticky=EW)

popupMenu_LGnum = OptionMenu(root,LGnumvar,*choices_LGnum)
popupMenu_LGnum.grid(row=2,column=2,sticky=EW)
#entry_1.config(width = 30)

QGtypevar = StringVar(root)
choices_QGtype = ['2','External','Internal','']
QGtypevar.set('')

popupMenu_QGtype = OptionMenu(root,QGtypevar,*choices_QGtype)
popupMenu_QGtype.grid(row=3,column=1,sticky=EW)

label_1.grid(row = 1,sticky=W) #E N S W east north sud west
label_2.grid(row = 2,sticky=W)
label_3.grid(row = 3,sticky=W)

entry_1.grid(row=1, column = 1)
entry_2.grid(row=1, column = 2)
entry_3.grid(row=1, column = 3)

#entry_1_LG.grid(row=2, column = 1)
entry_2_LG.grid(row=2, column = 2)
entry_3_LG.grid(row=2, column = 3)
entry_4_LG.grid(row=2, column = 4)
entry_5_LG.grid(row=2, column = 5)
#entry_1_QG.grid(row=3, column = 1)
entry_2_QG.grid(row=3, column = 2)
entry_3_QG.grid(row=3, column = 3)
entry_4_QG.grid(row=3, column = 4)
entry_5_QG.grid(row=3, column = 5)

button_generate = Button(root,text='Generate!',command = generate)
button_generate.grid(row=6,column = 6)

button_generate = Button(root,text='Clear',command = deleteEntries)
button_generate.grid(row=6,column = 5)

#button_change = Button(root,text='Change',command=changeFig)
#button_change.grid(row=6,column = 2)


img = ImageTk.PhotoImage(Image.open('render/wheel.png'))
panel = Label(root, image = img)
panel.grid(row = 0, column = 1,columnspan = 5)
#root.mainloop()

menu = Menu(root)
root.config(menu=menu)

subMenu = Menu(menu)
menu.add_cascade(label='File',menu=subMenu)
subMenu.add_command(label='New',command=relaunch)
subMenu.add_separator()
subMenu.add_command(label='Exit',command=closeALL)

editMenu = Menu(menu)
menu.add_cascade(label='Edit',menu=editMenu)
editMenu.add_command(label='Redo',command=doNothing)

exampleMenu = Menu(menu)
menu.add_cascade(label='Examples',menu=exampleMenu)
exampleMenu.add_command(label='Slick',command=doslick)
exampleMenu.add_command(label='3_far',command=do3far)
exampleMenu.add_command(label='4_far',command=do4far)
exampleMenu.add_command(label='2_0_80_45_30',command=do20804530)

howMenu = Menu(menu)
menu.add_cascade(label='Help',menu=howMenu)
howMenu.add_command(label='Show Nomenclature',command=shownomenclature)

#toolbar = Frame(root, bg='blue')
#insertButt = Button(toolbar, text='Insert Image', command=doNothing)
#insertButt.pack(side=LEFT, padx=2, pady=2)
#printButt = Button(toolbar, text='Print', command=doNothing)
#printButt.pack(side=LEFT, padx=2, pady=2)

#toolbar.pack(side=TOP,fill=X)

c_render_var = IntVar()
c_render = Checkbutton(root, text='Render',variable=c_render_var)
c_render.grid(row = 5, column = 6)
c_MRF_var = IntVar()
c_MRF = Checkbutton(root, text='MRF Volumes',variable=c_MRF_var)
c_MRF.grid(row = 4, column = 0)

root.title('Tread Generator 1.0')
root.mainloop()
