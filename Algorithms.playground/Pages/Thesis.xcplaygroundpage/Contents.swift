import Foundation
//: [Previous](@previous)
/*:
 # Thesis
*/
/*:
 ## Number of possibility
 */
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
/*:
 ## Calculate angle between clock hands
 */
/*
 Write a function which takes two integer parameters for time in hours and miniutes and return the minimum angle between two.
 Assumption: Shoule accept hours in 24hr format.
 Input: 12, 45
 Output: 113 (rounded up to Int)
*/
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
// Test Cases:
//print(calculateAngle(hours: 12, mins: 45))
//print(calculateAngle(hours: 12, mins: 0))
//print(calculateAngle(hours: 18, mins: 30))
//print(calculateAngle(hours: 20, mins: 20))
//print(calculateAngle(hours: 23, mins: 10))
/*:
 ## Check if two NSRange intersect each other
 */
func hasIntersection(range1: NSRange, range2: NSRange) -> Bool{
    if range1.location >= range2.location && range1.location <= (range2.location + range2.length){
        return true
    }
    if range2.location >= range1.location && range2.location <= (range1.location + range1.length){
        return true
    }
    return false
}
// Test Caes:
// print(hasIntersection(range1: NSRange.init(location: 10, length: 250), range2: NSRange.init(location: 100, length: 500)))
/*:
 ## Matrix Rotation
 */
/*
 Rotate the image by 90 degree
 */
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
// Test Cases:
//print(performRotation(matrix: [[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]], size: 4))
/*:
 ## Matrix manipulation
 */
/*
 Set zeros: If an element is zero set its entire row and column to zero
 */
func setZeros( anArray: [[Int]]) -> [[Int]]{
    var anArray = anArray
    var rowArr: [Bool] = Array(repeating: false, count: anArray.count)
    var colArr: [Bool] = Array(repeating: false, count: anArray[0].count)
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
// Test Caes:
//print(setZeros(anArray: [[0,1,2],[3,4,5],[6,7,8]]))
/*:
 ## Employee/Manager Problem
 */
/*
 Calculate the salary of Worker based on type
 Input:
     If type = "Contractor" then salary = hourly rate
     If type = "FTE" then salary = salary
     If type = "Manager" then salary = worker id who reports to manager
 Output:
     Array of salary in ascending order
*/
struct Worker{
    var workerId: Int?
    var type = ""
    var name = ""
    var salary = ""
    var workHours: Int?
    var computedSalary = 0
}
func sortedListOfSalaries(workers: [[String]]) -> [Int] {
    var listOfSalaries = [Int]()
    var workersArray = [Worker]()
    for worker in workers{
        var workerObj = Worker()
        for index in 0..<worker.count{
            switch index{
            case 0: workerObj.workerId = Int(worker[index])
            case 1: workerObj.type = worker[index]
            case 2: workerObj.name = worker[index]
            case 3: workerObj.salary = worker[index]
            case 4: workerObj.workHours = Int(worker[index])
            default: break
            }
        }
        
        if workerObj.type == "Contractor"{
            if let hourlyRate = Int(workerObj.salary), let hours = workerObj.workHours{
                let salary = hourlyRate * hours * 52
                workerObj.computedSalary = salary
            }
        }else if workerObj.type == "FTE"{
            if let salary = Int(workerObj.salary){
                workerObj.computedSalary = salary
            }
        }
        workersArray.append(workerObj)
    }
    
    // Now let's iterate workers array to calculate managers salary
    for worker in workersArray{
        var wokkerO = worker
        if worker.type == "Manager"{
            let listOfWorkerIds = worker.salary.split(separator:",")
            for workerId in listOfWorkerIds{
                for innerWorker in workersArray{
                    if let innerWorkerId = innerWorker.workerId, String(innerWorkerId) == workerId{
                        wokkerO.computedSalary += innerWorker.computedSalary
                    }
                }
            }
        }
        listOfSalaries.append(wokkerO.computedSalary)
    }
    // Sort salaries array, default acending.
    return listOfSalaries.sorted()
}
// Test Cases:
//let workersArray = [["1","Contractor","Apple","50","12"],
//                    ["2","Manager","Apple","1,4,5","X"],
//                    ["3","Manager","Apple","1,4","X"],
//                    ["4","FTE","Apple","50000","X"],
//                    ["5","FTE","Apple","140000","X"]]
//print(sortedListOfSalaries(workers: workersArray))
// 1 -> 31,200
// 2 -> 221,200
// 3 -> 81,200
// 4 -> 50,000
// 5 -> 140,000
/*:
 ## Implement numeric addition of two Strings
 */
/*
 Input: "12345", "123"
 Output: "12468"
 */
func addTwoNumbers(string1: String, string2: String) -> String{
    var resultString = ""
    let smallerNum = (string1.count < string2.count) ? string1 : string2
    let biggerNum = (string1.count >= string2.count) ? string1 : string2
    var carryForward = 0
    // Sum
    for index in 1...biggerNum.count{
        var total = 0
        let biggerNumIndex = biggerNum.index(biggerNum.endIndex, offsetBy: -index)
        let biggerNumVal = Int(String(biggerNum[biggerNumIndex]))!
        var smallerNumVal = 0
        if index <= smallerNum.count{
            let smallerNumIndex = smallerNum.index(smallerNum.endIndex, offsetBy: -index)
            smallerNumVal = Int(String(smallerNum[smallerNumIndex]))!
        }
        total =  biggerNumVal + smallerNumVal + carryForward
        carryForward = 0
        if total > 9{
            carryForward = total / 10
            total = total % 10
        }
        resultString.append(String(total))
    }
    if carryForward > 0{
        resultString.append(String(carryForward))
    }
    return String(resultString.reversed())
}
//print(addTwoNumbers(string1: "12345", string2: "123"))
//print(addTwoNumbers(string1: "9999", string2: "99"))
//print(addTwoNumbers(string1: "99999", string2: "99999"))
//print(addTwoNumbers(string1: "10000", string2: "11"))
//print(addTwoNumbers(string1: "90", string2: "1000"))
//print(addTwoNumbers(string1: "101010", string2: "100000"))
/*:
 ## Implement numeric subtraction of two Strings
 */
/*
 Input: "12345", "123"
 Output: "12222"
 */
func subtractTwoNumbers(string1: String, string2: String){
    
}
/*:
 ## Convert Int into formatted String
 */
/*
 Input:
 Output:
 Input:
 Output:
 */
func intToString(number: Int, isLakhs: Bool=false) -> String{
    var outputString = ""
    let inputString = String(number)
    var commaIndex = 1
    var commaDiv = 3
    var modVal = 0
    for char in inputString.reversed(){
        if commaIndex >= commaDiv && commaIndex % commaDiv == modVal && commaIndex != inputString.count {
            outputString.append("\(char),")
        }else{
            outputString.append(char)
        }
        if isLakhs && commaIndex == commaDiv{
            commaDiv = 2
            modVal = 1
        }
        commaIndex += 1
    }
    return String(outputString.characters.reversed())
}
//print(intToString(number: 123456789, isLakhs: true))
//print(intToString(number: 123456789))
//print(intToString(number: 1))
//print(intToString(number: 12, isLakhs: true))
//print(intToString(number: 123456, isLakhs: true))
//print(intToString(number: 123456))

//: [Next](@next)
