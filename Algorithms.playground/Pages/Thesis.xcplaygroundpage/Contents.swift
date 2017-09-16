//: [Previous](@previous)

import Foundation

// Define f(0)=1 and f(n)  to be the number of different ways  can be expressed as a sum of integer powers of 2 using each power no more than twice.
// Formula: f(0)=1 and f(2n+1) = f(n), f(2n) = f(n) + f(n-1)
func numberOfPossibility(num: Int) -> Int{
    if num == 0 || num == 1{
        return 1
    }
    if num % 2 == 0{
        return numberOfPossibility(num: num / 2) + numberOfPossibility(num: num / 2 - 1)
    }else{
        return numberOfPossibility(num: (num - 1)/2)
    }
}
//print(numberOfPossibility(num: 8))

// Write a function which takes two integer parameters for time in hours and miniutes and return the minimum angle between two.
// Assumption: Shoule accept hours in 24hr format.
// Input: 12, 45
// Output: 113 (rounded up to Int)
func calculateAngle(hours: Int, mins: Int) -> Int{
    // Constants
    let fullCircle = 360.0
    let halfCircle = 180.0
    
    // Angle for a min
    let minsHandAngleForAmin = fullCircle / 60  // Complete a full circle in 60 mins
    let hrsHandAngleForAmin = fullCircle / 720 // Complete a full circle in 720 mins
    
    // Handle 24hr time
    let hours = (hours >= 12) ? hours - 12 : hours
    
    // Calculate angle from 12:00
    let minsHandAngle = minsHandAngleForAmin * Double(mins)
    let hrsHandAngle = (Double(hours) * 60 * hrsHandAngleForAmin) + (Double(mins) * hrsHandAngleForAmin)
    
    // Angle between hands
    var angleBtwHands = 0.0
    if (hrsHandAngle > minsHandAngle){
        angleBtwHands = hrsHandAngle - minsHandAngle
    }else{
        angleBtwHands = minsHandAngle - hrsHandAngle
    }
    
    // Return minimum
    if angleBtwHands > halfCircle{
        return Int(round(fullCircle - angleBtwHands))
    }else{
        return Int(round(angleBtwHands))
    }
}
//print(calculateAngle(hours: 12, mins: 45))
//print(calculateAngle(hours: 12, mins: 0))
//print(calculateAngle(hours: 18, mins: 30))
//print(calculateAngle(hours: 20, mins: 20))
//print(calculateAngle(hours: 23, mins: 10))

/* Check if two NSRange intersect each other */
func hasIntersection(range1: NSRange, range2: NSRange) -> Bool{
    if range1.location >= range2.location && range1.location <= (range2.location + range2.length){
        return true
    }
    if range2.location >= range1.location && range2.location <= (range1.location + range1.length){
        return true
    }
    return false
}
//print(hasIntersection(range1: NSRange.init(location: 10, length: 250), range2: NSRange.init(location: 100, length: 500)))

/* Rotate the image by 90 degree */
func performRotation( matrix: [[Int]], size: Int) -> [[Int]]{
    var matrix = matrix
    for layer in 0...size/2-1{
        let first = layer
        let last = size - 1 - layer
        for i in first...last-1{
            let offset = i - first
            
            // Save top
            let temp = matrix[first][i]
            
            // left -> top
            matrix[first][i] = matrix[last - offset][first]
            
            // bottom -> left
            matrix[last - offset][first] = matrix[last][last-offset]
            
            // right -> bottom
            matrix[last][last-offset] = matrix[i][last]
            
            // top -> right
            matrix[i][last] = temp
        }
    }
    return matrix
}
//print(performRotation(matrix: [[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]], size: 4))

/* Set zeros: If an element is zero set its entire row and column to zero */
func setZeros( anArray: [[Int]]) -> [[Int]]{
    var anArray = anArray
    var rowArr: [Bool] = Array.init(repeating: false, count: anArray.count)
    var colArr: [Bool] = Array.init(repeating: false, count: anArray[0].count)
    for rowIndex in 0...anArray.count-1{
        for colIndex in 0...anArray[rowIndex].count-1{
            if anArray[rowIndex][colIndex] == 0{
                rowArr[rowIndex] = true
                colArr[colIndex] = true
            }
        }
    }
    for rowIndex in 0...anArray.count-1{
        for colIndex in 0...anArray[rowIndex].count-1{
            if rowArr[rowIndex] || colArr[colIndex]{
                anArray[rowIndex][colIndex] = 0
            }
        }
    }
    return anArray
}
//print(setZeros(anArray: [[0,1,2],[3,4,5],[6,7,8]]))

//: [Next](@next)
