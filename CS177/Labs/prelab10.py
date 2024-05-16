# CS 177 – prelab10.py
# {Karim Muhammad El-Sharkawy}
# create 400x400 window filled with a circle with random x and y coordinates.

from graphics import *

def main():
    #creating the window
    win = GraphWin('Prelab10', 400, 400)
    win.setBackground("lightblue")

    # rc stands for red circle. This will be the "first" red circle
    rc = Circle(Point(200,200), 30)
    rc.setFill("Red")
    rc.draw(win)

    # this is a for loop that replaces the first rc with another one after it detects a mouse click
    for i in range(5):
        click = win.getMouse() #this is for detecting the mouse click
        rc.undraw()
        rc = Circle(click, 30)
        rc.setFill("Red")
        rc.draw(win)

    # creating the text object
    centertext = Text(Point(200,200), "Click again to exit")
    centertext.setSize(20)
    centertext.setFace("arial")
    centertext.setStyle("bold")
    centertext.draw(win)
    win.getMouse()
    win.close()
        
#Calling the main function.
if __name__ == "__main__":
    main()
