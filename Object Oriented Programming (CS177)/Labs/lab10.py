# CS 177 – lab10.py
# {Karim Muhammad El-Sharkawy}
# create 400x400 window filled with 10 circles with random x and y coordinates. When clicked on, the circles disappear. There'll be a counter that counts the number of circles left.

# Import the Graphics library and two random functions
from graphics import *
from random import randint, choice


# The clicked() function accepts a mouse click Point and a Circle 
#   and returns True if the click is inside the Circle. If the
#   click is not inside the Circle it returns False
def clicked(click, circle):
    # if no mouse click was detected return False
    if not click:
        return False
    # get the x,y coordinates of the center Point of the Circle
    center = circle.getCenter()
    cx,cy = center.getX(), center.getY()
    # get the x,y coordinates of the mouse click
    x,y = click.getX(), click.getY()
    radius = circle.getRadius()
    # use Pythagorean's equation to calculate distance between
    #   mouse click and center of Circle
    distance = ((x-cx)**2 + (y-cy)**2)**.5
    # was the mouse click inside the Circle?
    if distance < radius:
        return True
    else:
        return False

# The make() function creates a List of 10 Circles using randomly selected
#   coordinates, a random radius and fill color. 
def make(win):
    # List of colors to choose from for the Circles
    colors = ['red','blue','yellow','green','grey','black']
    # Create empty List that will be used to store the Circles
    circles = []
    # Loop 10 times to create 10 Circles
    for i in range(10):
        # Choose a random x,y coordinate and random radius
        x = randint(20,380)
        y = randint(20,380)
        radius = randint(10,20)
        # Create a Circle using the random coordinates and radius
        c = Circle(Point(x,y),radius)
        # Randomly choose a fill color from the List of colors
        c.setFill(choice(colors))
        c.draw(win)
        # append the new Circle to the List of Circles
        circles.append(c)
    # return the completed List of Circles
    return circles

def main():
    # Part 1
    #creating the window
    win = GraphWin('Click me', 400, 400)
    # creating the first text object
    centertext1 = Text(Point(200,200), "Click the circles!")
    centertext1.setSize(20)
    centertext1.setFace("arial")
    centertext1.setStyle("bold")
    centertext1.draw(win)
    # creating the second text object
    centertext2 = Text(Point(200,20), "Circles remaining: 10")
    centertext2.setSize(12)
    centertext2.setFace("arial")
    centertext2.setStyle("bold")
    centertext2.draw(win)

    circles = make(win)

    # part 2
    # defining a while loop
    
    while len(circles) > 0:
        click = win.getMouse()
        for circle in circles:
            if clicked(click, circle) == True:
                circle.undraw()
                circles.remove(circle)
            centertext2.setText("Circles remaining:"+str(len(circles)))
        # creating the new text object
    centertext1.setText("Click the window again to close")
    win.getMouse()
    win.close()
    
    
#Calling the main function.
if __name__ == "__main__":
    main()
