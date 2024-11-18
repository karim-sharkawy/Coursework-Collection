# CS 177 – lab09.py
# {Karim Muhammad El-Sharkawy}

# import from the graphics.py file
# make sure your graphics.py is under the same folder as your lab09.py
from graphics import *

def drawSpaceship():
    # use the graphics library imported to create windows and draw objects
    window = GraphWin('Apo', 500, 500)

    # create objects on the window
    # check the graphics.py file for creating various objects, like
    # lines, rectangles, polygons, etc.

    # creating the big red circle
    red_circle = Circle(Point(250, 200), 100)
    red_circle.setFill("red")
    red_circle.draw(window) # draws the circle to the window

    # creating the smaller blue circle
    blue_circle = Circle(Point(300, 150),12.5)
    blue_circle.setFill("blue")
    blue_circle.draw(window)

    # creating the stupid trapazoid
    yellow_trapazoid = Polygon(Point(75,300),Point(150,200),Point(350,200),Point(425,300))
    yellow_trapazoid.setFill("yellow")
    yellow_trapazoid.draw(window)

    # creating a rectangle
    green_rectangle1 = Rectangle(Point(150, 230),Point(225, 265))
    green_rectangle1.setFill("light green")
    green_rectangle1.draw(window)

    # creating the second rectangle
    green_rectangle2 = Rectangle(Point(350, 230),Point(275, 265))
    green_rectangle2.setFill("light green")
    green_rectangle2.draw(window)

    # creating the lines
    line1 = Polygon(Point(350,300),Point(360,300),Point(460,375),Point(450,375))
    line1.setFill("purple")
    line1.draw(window)

    line2 = Polygon(Point(250,300),Point(260,300),Point(260,400),Point(250,400))
    line2.setFill("purple")
    line2.draw(window)
    
    line3 = Polygon(Point(50,375),Point(60,375),Point(160,300), Point(150,300))
    line3.setFill("purple")
    line3.draw(window)
    
    return window

def main():
    window = drawSpaceship()
#Calling the main function.
if __name__ == "__main__":
    main()
