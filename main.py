from tkinter import *
from tkinter import ttk
import clips

def readResources(resourceList):
    with open('./src/resources/DrinkResources.properties', 'r') as file:
        lines = file.readlines()
        for line in lines:
            title, value = line.replace('\n', '').split('=')
            resourceList[title] = value

def getID():
    evalStr = '(find-all-facts ((?f state-list)) TRUE)'
    currentID = str(environment.eval(evalStr)[0]['current'])
    return currentID

def getUIstate():
    currentID = getID()
    evalStr = '(find-all-facts ((?f UI-state)) ' + '(eq ?f:id ' + currentID + '))'
    UIstate = environment.eval(evalStr)[0]
    return UIstate



def updateQuestions(start=False):
    UIstate = getUIstate()
    validAnswers = UIstate['valid-answers']
    answersSize = len(validAnswers)
    answerButtons = 0

    for id, text in enumerate(allButtonText):
        if id + 1 <= answersSize:
            text.set(resources[str(validAnswers[id])])
            if not start:
                allButtons[id].grid(row=id + 1, column=1, pady=10)
                allButtons[id].deselect()
                answerButtons += 1
        else:
            text.set('')
            if not start:
                allButtons[id].grid_remove()


    state = str(UIstate['state'])

    if state == 'initial':
        nextText.set('Start')
    elif state == 'final':
        nextText.set('Restart')
        previousButton.grid_forget()
    else:
        selectedOption.set('0')
        nextText.set('Next')
        previousText.set('Previous')

    titleText.set(resources[UIstate['display']])

    if not start:
        if state == 'final':
            titleLabel.configure(padx=10, pady=10, bd=3)
        else:
            titleLabel.configure(textvariable=titleText, padx=1, pady=7, bd=1)

    if not start:
        previousButton.grid(row=answersSize + 3, column=1, pady=(10, 20), padx=(20, 10))
        nextButton.grid(row=answersSize + 3, column=2, pady=(10, 20), padx=(10, 20))

def handlePrevious():
    UIstate = getUIstate()
    state = str(UIstate['state'])
    id = getID()

    if state == 'middle':
        environment._facts.assert_string('(prev ' + id + ')')
        environment._agenda.run()

    updateQuestions()

def handleNext():
    UIstate = getUIstate()
    state = str(UIstate['state'])
    id = getID()
    validAnswers = UIstate['valid-answers']
    if state != 'initial' and state != 'final':
        radioID = int(selectedOption.get())
        answer = validAnswers[radioID]

    if state == 'final':
        environment.reset()
        environment._agenda.run()
        updateQuestions(start=True)
        return
    elif state == 'initial':
        environment._facts.assert_string('(next ' + id + ')')
        environment._agenda.run()
    else:
        environment._facts.assert_string('(next ' + id + ' ' + answer + ')')
        environment._agenda.run()

    updateQuestions()

resources = {}
readResources(resources)

environment = clips.Environment()
environment.load('drinks.CLP')
environment.reset()
environment._agenda.run()

root = Tk()
root.title('What should I drink?')
root.geometry('800x500')
frm = ttk.Frame(root, padding=15)
frm.grid()

titleText = StringVar()
answer1Text = StringVar()
answer2Text = StringVar()
answer3Text = StringVar()
answer4Text = StringVar()
previousText = StringVar()
nextText = StringVar()

allButtonText = (answer1Text, answer2Text, answer3Text, answer4Text)

updateQuestions(start=True)

selectedOption = StringVar()

titleLabel = Label(root, textvariable=titleText)
answer1 = Radiobutton(root, textvariable=answer1Text, variable=selectedOption, value=str(0))
answer2 = Radiobutton(root, textvariable=answer2Text, variable=selectedOption, value=str(1))
answer3 = Radiobutton(root, textvariable=answer3Text, variable=selectedOption, value=str(2))
answer4 = Radiobutton(root, textvariable=answer4Text, variable=selectedOption, value=str(3))
allButtons = (answer1, answer2, answer3, answer4)

titleLabel.grid(row=0, column=0, columnspan=3, pady=(20, 10), padx=(20, 10))

previousButton = Button(root, textvariable=previousText)
nextButton = Button(root, textvariable=nextText)
previousButton.configure(command=handlePrevious)
nextButton.configure(command=handleNext)
nextButton.grid(row=1, column=0, columnspan=2, pady=(10, 20))


root.mainloop()