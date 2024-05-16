# CS 177 – project4.py
# {Karim Muhammad El-Sharkawy}
# we're basically taking an integral

from graphics import *

# task 1 starts here
def createWindow(windowWidth, windowHeight):
    window = GraphWin('Area Approximation', windowWidth, windowHeight)
    return window

# task 2 starts here
def getXCoordinates(interval, rectangleWidth):
    resultList = []
    newN = interval[0]
    while newN < interval[1]:
        resultList.append(newN)
        newN = newN + rectangleWidth
    return resultList
    

# task 3 starts here
def f(x):
    return (0.001)*(x**2)

# task 4 starts here
def getYCoordinates(x_coordinates):
    y_coordinates = []
    for a in x_coordinates:
        
        y_coordinates.append(f(a))
        
    return y_coordinates
    
    

# task 5 starts here
def getRectanglesList(x_coordinates, y_coordinates, windowHeight):
    rectanglesList = []
    for i in range(len(x_coordinates) - 1):
        PointA = Point(x_coordinates[i], windowHeight - y_coordinates[i])
        PointB = Point(x_coordinates[i + 1], windowHeight)
        rectanglesList.append(Rectangle(PointA, PointB))
    return rectanglesList

# task 6 starts here
def plotRectangles(rectanglesList, window):
    for i in range(len(rectanglesList)):
        red_rectangle = rectanglesList[i]
        red_rectangle.setFill("red")
        red_rectangle.draw(window)
    


# task 7 starts here
def getApproxArea(x_coordinates, y_coordinates):
    area = 0
    for i in range(len(x_coordinates) - 1):
        x = x_coordinates[i + 1] - x_coordinates[i]
        y = y_coordinates [i]
        area = area + (x * y)
    return area


# task 8 starts here
def displayArea(area, win):
    toPrint = "Area of Rectangles = {}".format(area)
    areaText = Text(Point(150,15), toPrint)
    areaText.draw(win)
    areaText.setSize(10)
    areaText.setStyle("bold")
def main():
    windowWidth = 350
    windowHeight = 350
    window = createWindow(windowWidth, windowHeight)
    interval = [1, 350]
    rectangleWidth = 4
    x_coordinates = getXCoordinates(interval, rectangleWidth)
    y_coordinates = getYCoordinates(x_coordinates)
    rectangles = getRectanglesList(x_coordinates, y_coordinates, windowHeight)
    plotRectangles(rectangles, window)
    area = getApproxArea(x_coordinates, y_coordinates)
    displayArea(area, window)
    window.getMouse()
    window.close()


#Calling the main function.
if __name__ == "__main__":
    main()

