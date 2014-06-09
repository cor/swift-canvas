//
//  Small and simple Emoji based drawing program
//  prints to the console
//  Only uses FP, no OOP
//
//  You can draw the following objects:
//      * single dots
//      * vertical & horizontal lines
//      * Empty rectangle (only shows border)
//      * Full rectangle
//



import Cocoa

//  Generates the canvas and returns a 2D array filled with strings
//
//  paramters:
//  width: Int                  The width of the canvas
//  height: Int                 The height of the canvas
func generateCanvas(width: Int, height: Int) -> String[][] {
    var canvasArray: String[][] = String[][](count: height, repeatedValue: String[]())
    
    for i in 0..height {
        canvasArray[i] = String[](count:width, repeatedValue: "◻️")
    }
    
    return canvasArray
}

//  Prints the canvas to the console
//
//  parameters:
//  canvas: String[][]          The canvas in question
func printCanvas(canvas: String[][]) {
    
    var rulerX = "\t"
    for i in 1...canvas[0].count {
        if i < 10 { rulerX += toString(i) + "  " }
        else { rulerX += toString(i) + " " }
    }
    println(rulerX)
    
    var rulerYcounter = 1
    
    for i in canvas {
        print(toString(rulerYcounter) + "\t")
        for j in i {
            print(j + " ")
        }
        println()

        rulerYcounter++
    }
}


//  Sets the field at a specific CGPoint
//
//  parameters:
//  field: CGPoint              The point to set
//  canvas: String[][]          The canvas in question
func setLevel(field: CGPoint, canvas: String[][] ) {
    canvas[(Int(field.y) - 1)][(Int(field.x) - 1)] = "◼️"
}


//  Draws a line from point a to point b
//  only supports horizontal and vertical lines, no diogonal.
//  
//  paramters:
//  pointA: CGPoint             point A
//  pointB: CGPoint             point B
//  canvas: String[][]          the canvas in question.
func drawLine(pointA: CGPoint, pointB: CGPoint, canvas: String[][] ) {
    if pointA.x == pointB.x {
        if pointA.y >= pointB.y {
            for i in pointB.y...pointA.y {
                setLevel(CGPointMake(pointA.x, i), canvas)
            }
        }
        else if pointB.y >= pointA.y {
            for i in pointA.y...pointB.y {
                setLevel(CGPointMake(pointA.x, i), canvas)
            }
        }
    }
        
    else if pointA.y == pointB.y {
        if pointA.x >= pointB.x {
            for i in pointB.x...pointA.x {
                setLevel(CGPointMake(i, pointA.y), canvas)
            }
        }
        else if pointB.x >= pointA.x {
            for i in pointA.x...pointB.x {
                setLevel(CGPointMake(i, pointA.y), canvas)
            }
        }
    }
}


//  Draws an empty rectangle (only shows the border)
//
//  parameters:
//  pointA: CGPoint             the top-left corner
//  pointB: CGPoint             the bottom-right corner
//  canvas: String[][]          the canvas in question
func drawRectEmpty(pointA: CGPoint, pointB: CGPoint, canvas: String[][] ) {
    drawLine(CGPointMake(pointA.x, pointA.y), CGPointMake(pointB.x, pointA.y), canvas)
    drawLine(CGPointMake(pointA.x, pointB.y), CGPointMake(pointB.x, pointB.y), canvas)
    drawLine(CGPointMake(pointA.x, pointA.y), CGPointMake(pointA.x, pointB.y), canvas)
    drawLine(CGPointMake(pointB.x, pointA.y), CGPointMake(pointB.x, pointB.y), canvas)
}


//  Draws a full (filled) rectangle
//
//  parameters:
//  pointA: CGPoint             the top-left corner
//  pointB: CGPoint             the bottom-right corner
//  canvas: String[][]          the canvas in question
func drawRectFull(pointA: CGPoint, pointB: CGPoint, canvas: String[][] ) {
    for i in pointA.y...pointB.y {
        drawLine(CGPointMake(pointA.x, i), CGPointMake(pointB.x, i), canvas)
    }
    
}

// example usage
var example = generateCanvas(20, 20)
drawRectFull    (CGPointMake(4, 6), CGPointMake(5, 8), example)
drawRectFull    (CGPointMake(16, 6), CGPointMake(17, 8), example)
drawLine        (CGPointMake(5, 15), CGPointMake(16, 15), example)
drawLine        (CGPointMake(5, 16), CGPointMake(16, 16), example)
drawRectEmpty   (CGPointMake(2, 2), CGPointMake(6,9), example)
drawRectEmpty   (CGPointMake(19, 2), CGPointMake(15, 9), example)
printCanvas     (example)