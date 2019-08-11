//: [Previous](@previous)
//: # Thesis
//: ---
/*:
 ## 1. Number of possibility
 Define f(0) = 1 and f(n) to be the number of different ways can be expressed as a sum of integer
 powers of 2 using each power no more than twice.\
 Formula: f(0) = 1 and f(2n+1) = f(n), f(2n) = f(n) + f(n-1)
 */
import Foundation
func numberOfPossibility(n: Int) -> Int {
    if n == 0 || n == 1 {
        return 1
    }
    if n % 2 == 0 {
        return numberOfPossibility(n: n / 2) + numberOfPossibility(n: n / 2 - 1)
    } else {
        return numberOfPossibility(n: (n - 1)/2)
    }
}
//print(numberOfPossibility(n: 8))
//: ---
/*:
 ## 2. Calculate angle between clock hands
 Write a function which takes two integer parameters for time in hours and miniutes and return the
 minimum angle between two.\
 Assumption: Shoule accept hours in 24hr format.

    Input: 12, 45
    Output: 113 (rounded up to Int)
*/
func calculateAngle(hours: Int, mins: Int) -> Int {
    // Constants
    let fullCircle = 360.0
    let halfCircle = 180.0
    
    // Angle for a min
    let minsHandAngleForAmin = fullCircle / 60  // Complete a full circle in 60 mins
    let hrsHandAngleForAmin = fullCircle / 720 // Complete a full circle in 720 mins
    
    // Handle 24hr time
    let hours = hours >= 12 ? hours - 12 : hours
    
    // Calculate angle from 12:00
    let minsHandAngle = minsHandAngleForAmin * Double(mins)
    let hrsHandAngle =
        (Double(hours) * 60 * hrsHandAngleForAmin) + (Double(mins) * hrsHandAngleForAmin)
    
    // Angle between hands
    let angleBtwHands = abs(hrsHandAngle - minsHandAngle)
    
    // Return minimum
    if angleBtwHands > halfCircle {
        return Int(round(fullCircle - angleBtwHands))
    } else {
        return Int(round(angleBtwHands))
    }
}
//print(calculateAngle(hours: 12, mins: 45))
//print(calculateAngle(hours: 12, mins: 0))
//print(calculateAngle(hours: 18, mins: 30))
//print(calculateAngle(hours: 20, mins: 20))
//print(calculateAngle(hours: 23, mins: 10))
//: ---
//: ## 3. Check if two NSRange intersect each other
func hasIntersection(range1: NSRange, range2: NSRange) -> Bool {
    if range1.location >= range2.location &&
        range1.location <= (range2.location + range2.length) {
      return true
    }
    if range2.location >= range1.location &&
        range2.location <= (range1.location + range1.length) {
      return true
    }
    return false
}
//print(hasIntersection(range1: NSRange.init(location: 10, length: 250),
//                      range2: NSRange.init(location: 100, length: 500)))
//: ---
//: ## 4. Matrix rotation
//: Rotate the image by 90 degree.
func performRotation( matrix: [[Int]], size: Int) -> [[Int]] {
    var matrix = matrix
    for layer in 0...size/2-1 {
        let first = layer
        let last = size - 1 - layer
        for i in first...last-1 {
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
//print(performRotation(matrix: [[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]],
//                        size: 4))
//: ---
//: ## 5. Matrix manipulation
//: Set zeros: If an element is zero set its entire row and column to zero.
func setZeros( anArray: [[Int]]) -> [[Int]] {
    var anArray = anArray
    var rowArr: [Bool] = Array(repeating: false, count: anArray.count)
    var colArr: [Bool] = Array(repeating: false, count: anArray[0].count)
    for rowIndex in 0...anArray.count-1 {
        for colIndex in 0...anArray[rowIndex].count-1 {
            if anArray[rowIndex][colIndex] == 0 {
                rowArr[rowIndex] = true
                colArr[colIndex] = true
            }
        }
    }
    for rowIndex in 0...anArray.count-1 {
        for colIndex in 0...anArray[rowIndex].count-1 {
            if rowArr[rowIndex] || colArr[colIndex] {
                anArray[rowIndex][colIndex] = 0
            }
        }
    }
    return anArray
}
//print(setZeros(anArray: [[0,1,2],[3,4,5],[6,7,8]]))
//: ---
/*:
 ## 6. Employee/Manager problem
 Calculate the salary of worker based on type.

    Input:
      If type = "Contractor" then salary = hourly rate
      If type = "FTE" then salary = salary
      If type = "Manager" then salary = worker id who reports to manager
    Output:
      Array of salary in ascending order
*/
struct Worker {
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
    // Prepare array of worker objects.
    for worker in workers {
        var workerObj = Worker()
        for index in 0..<worker.count {
            switch index {
            case 0: workerObj.workerId = Int(worker[index])
            case 1: workerObj.type = worker[index]
            case 2: workerObj.name = worker[index]
            case 3: workerObj.salary = worker[index]
            case 4: workerObj.workHours = Int(worker[index])
            default: break
            }
        }
        
        if workerObj.type == "Contractor" {
            if let hourlyRate = Int(workerObj.salary), let hours = workerObj.workHours {
                let salary = hourlyRate * hours * 52
                workerObj.computedSalary = salary
            }
        } else if workerObj.type == "FTE" {
            if let salary = Int(workerObj.salary) {
                workerObj.computedSalary = salary
            }
        }
        workersArray.append(workerObj)
    }
    // Now let's iterate workers array to calculate managers salary
    for worker in workersArray {
        var wokkerO = worker
        if worker.type == "Manager" {
            let listOfWorkerIds = worker.salary.split(separator:",")
            for workerId in listOfWorkerIds {
                for innerWorker in workersArray {
                    if let innerWorkerId = innerWorker.workerId,
                            String(innerWorkerId) == workerId {
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
//: ---
/*:
 ## 7. Implement numeric addition of two Strings
 
    Input: "12345", "123"
    Output: "12468"
 */
func addTwoNumbers(string1: String, string2: String) -> String {
    var resultString = ""
    let smallerNum = (string1.count < string2.count) ? string1 : string2
    let biggerNum = (string1.count >= string2.count) ? string1 : string2
    var carryForward = 0
    // Sum
    for index in 1...biggerNum.count {
        var total = 0
        let biggerNumIndex = biggerNum.index(biggerNum.endIndex, offsetBy: -index)
        let biggerNumVal = Int(String(biggerNum[biggerNumIndex]))!
        var smallerNumVal = 0
        if index <= smallerNum.count {
            let smallerNumIndex = smallerNum.index(smallerNum.endIndex, offsetBy: -index)
            smallerNumVal = Int(String(smallerNum[smallerNumIndex]))!
        }
        total =  biggerNumVal + smallerNumVal + carryForward
        carryForward = 0
        if total > 9 {
            carryForward = total / 10
            total = total % 10
        }
        resultString.append(String(total))
    }
    if carryForward > 0 {
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
//: ---
/*:
 ## 8. Implement numeric subtraction of two Strings
 
    Input: "12345", "123"
    Output: "12222"
 */
// TODO: Implement this.
func subtractTwoNumbers(string1: String, string2: String) {
    
}
//: ---
//: ## 9. Convert INT into formatted String
func intToString(number: Int, isLakhs: Bool=false) -> String {
    var outputString = ""
    let inputString = String(number)
    var commaIndex = 1
    var commaDiv = 3
    var modVal = 0
    for char in inputString.reversed() {
        if commaIndex >= commaDiv &&
              commaIndex % commaDiv == modVal &&
              commaIndex != inputString.count {
            outputString.append("\(char),")
        } else {
            outputString.append(char)
        }
        if isLakhs && commaIndex == commaDiv {
            commaDiv = 2
            modVal = 1
        }
        commaIndex += 1
    }
    return String(outputString.reversed())
}
//print(intToString(number: 123456789, isLakhs: true))
//print(intToString(number: 123456789))
//print(intToString(number: 1))
//print(intToString(number: 12, isLakhs: true))
//print(intToString(number: 123456, isLakhs: true))
//print(intToString(number: 123456))
//: ---
/*:
 ## 10. Popular colors
 1. Accept an array of Strings
 ex. ["Green", "Blue", "Red", "Green", "Green", "Red"]
 2. Return the color that appears most often
 3. If there is a tie, return the tied colors in an array
 - Example:
      Input: ["Green", "Blue", "Red", "Green", "Green", "Red", "Red"]\
      Output: ["Green", "Red"]
 */
func mostOftenColors(anArray: [String]) -> [String] {
    var aDict = Dictionary<String, Int>()
    for string in anArray {
        if let val = aDict[string] {
            aDict[string] = val + 1
        } else {
            aDict[string] = 1
        }
    }
    var outputArr = [String]()
    var maxCount = 1
    for (_, value) in aDict {
        if value > maxCount {
            maxCount = value
        }
    }
    for (key, value) in aDict {
        if value == maxCount {
            outputArr.append(key)
        }
    }
    return outputArr
}
//print(mostOftenColors(anArray: ["Green", "Blue", "Red", "Green", "Green", "Red", "Red"]))
//print(mostOftenColors(anArray: ["Green", "Blue", "Green", "Green", "Red", "Red"]))
//print(mostOftenColors(anArray: ["Green", "Blue"]))
//print(mostOftenColors(anArray: []))
//: ---
//: ## 11. Implement UIControl class
enum Event {
    case touchUpInside
    case touchDownInside
    case touchUpOutside
    case touchDownOutside
}
class MyAction: Equatable {
    var message = ""
    init(_ message: String) {
        self.message = message
    }
    func executeAction() {
        print(message)
    }
    // Overload '=='
    public static func ==(lhs: MyAction, rhs: MyAction) -> Bool {
        if lhs.message == rhs.message {
            return true
        }
        return false
    }
}
class MyControl {
    var eventsActions = Dictionary<Event,[MyAction]>()
    func addTarget(_ event: Event, action: MyAction) {
        if var actions = eventsActions[event] {
            actions.append(action)
            eventsActions[event] = actions
        } else {
            eventsActions[event] = [action]
        }
    }
    func removeTarget(_ action: MyAction) {
        for (evnt, actions) in eventsActions {
            var listOfActions = actions
            for (index, value) in actions.enumerated() {
                if value == action {
                    listOfActions.remove(at: index)
                }
            }
            eventsActions[evnt] = listOfActions
        }
    }
    func takeAction(_ event: Event) {
        for (evnt, actions) in eventsActions {
            if event == evnt {
                for action in actions {
                    action.executeAction()
                }
            }
        }
    }
}
//let action1 = MyAction("Action1")
//let action2 = MyAction("Action2")
//let control = MyControl()
//control.addTarget(.touchUpInside, action: action1)
//control.addTarget(.touchUpInside, action: action2)
//control.addTarget(.touchDownInside, action: action1)
//control.takeAction(.touchUpInside) // Action1, Action2
//control.takeAction(.touchDownInside) // Action1
//control.removeTarget(action1)
//control.takeAction(.touchUpInside) // Action2
//control.takeAction(.touchDownInside) // No action.
//: ---
/*:
 ## 12. Assign kids to teachers
 Inputs:
 - List of kids (Strings)
 - List of teachers (Strings)
 - Max class size (int)
 - Teacher prefereces: Map<String, List<String>>
 
 Output:
 - Assigments - Map<String, List<String>>
 - Account for any kids without a spot by assigning them to a "No Teacher" teacher
 
 Requirments:
 - Every teacher has the same number of kids (As close as possible).
 - Kids get a spot on a first come first served basis.
 - Assuming the intput already allow - respect the teacher preferences and all other requirements.
 
 - Example:
 11 kids and 3 teachers: two teachers have 4 kids and one teacher has 3 kids\
 ["BB": ["E", "F", "G", ], "CC": ["I", "H", "D"], "AA": ["A", "B", "C"],
    "No Teacher": [ "J", "K"]]\
 ["AA": ["A", "B", "D"], "No Teacher": ["J", "K"], "BB": ["A", "E", "F"],"CC": ["G", "H", "I"]]
 */
func assignKidsToTeachers(kids: [String],
                          teachers: [String],
                          maxClassSize: Int,
                          teacherPreference: Dictionary<String,[String]>
) -> Dictionary<String, [String]> {
    let kidsCount = kids.count
    let teachersCount = teachers.count
    
    var equalCount = kidsCount / teachersCount
    var unEqualCount = kidsCount % teachersCount
    if equalCount+1 > maxClassSize {
        equalCount = maxClassSize
        unEqualCount = 0
    }
    
    var outputDictionary = Dictionary<String, [String]>()
    var kidIndex = 0
    var aSet = Set<String>()
    for teacher in teachers {
        var kidsArr = [String]()
        let preferKids = teacherPreference[teacher]
        var offset = 0
        if let preferKids = preferKids {
            for kid in preferKids {
                kidsArr.append(kid)
                aSet.insert(kid)
                offset += 1
            }
        }
        if offset < equalCount {
            for _ in 1...equalCount-offset {
                while aSet.contains(kids[kidIndex]) {
                    kidIndex += 1
                }
                kidsArr.append(kids[kidIndex])
                kidIndex += 1
            }
        }
        if unEqualCount > 0 {
            while aSet.contains(kids[kidIndex]) {
                kidIndex += 1
            }
            kidsArr.append(kids[kidIndex])
            kidIndex += 1
            unEqualCount -= 1
        }
        outputDictionary[teacher] = kidsArr
    }
    
    if kidIndex < kids.count {
        var kidsArr = [String]()
        while kidIndex != kids.count {
            if !aSet.contains(kids[kidIndex]) {
                kidsArr.append(kids[kidIndex])
            }
            kidIndex += 1
        }
        outputDictionary["No Teacher"] = kidsArr
    }
    return outputDictionary
}
//print(assignKidsToTeachers(kids: ["A","B","C","D","E"],
//                       teachers: ["AA", "BB"],
//                   maxClassSize: 2,
//              teacherPreference: ["":[""]]))
//print(assignKidsToTeachers(kids: ["A","B","C","D","E"],
//                       teachers: ["AA"],
//                   maxClassSize: 4,
//              teacherPreference: ["":[""]]))
//print(assignKidsToTeachers(kids: ["A","B","C","D","E","F","G","H","I","J","K"],
//                       teachers: ["AA", "BB", "CC"],
//                   maxClassSize: 3,
//              teacherPreference: ["AA":["E"]]))
//: ---
//: ## 13. Print look and say sequence
func lookAndSaySequence(count: Int) {
  guard count > 0 else { return }
  var value  = "1"
  for _ in 1...count {
    print(value)
    value = computeNextLookAndSaySequence(input: value)
  }
}
func computeNextLookAndSaySequence(input: String) -> String {
  if input.count == 1 {
    return "1" + input
  }
  var nextVal = ""
  let charArr = Array(input)
  var current = charArr[0]
  var count = 1
  for index in 1...input.count {
    if index == input.count || current != charArr[index] {
      nextVal += String(count) + String(current)
      // Reset count, current char.
      count = 1
      if (index < input.count) {
        current = charArr[index]
      }
    } else {
      count += 1
    }
  }
  return nextVal
}
//print(computeNextLookAndSaySequence(input: "1")) // 11
//print(computeNextLookAndSaySequence(input: "11")) // 21
//print(computeNextLookAndSaySequence(input: "21")) // 1211
//print(computeNextLookAndSaySequence(input: "1211")) // 111221
//lookAndSaySequence(count: -10) //
//lookAndSaySequence(count: 0) //
//lookAndSaySequence(count: 1) // 1
//lookAndSaySequence(count: 10) // 1, 11, 21, 12211, ....
//: ---
//: ## 14. Sleep sort.
//TODO
//: ---
//: ## 15. Implement minesweeper.
//TODO
//: ---
//: ## 16. Implement calendar.
//TODO
//: ---
/*:
 ## 17. Handlings of bags
    > "Item1"
    > "Item2"
    > "Bag Of Holdings"
      >> "Item1"
      >> "Item2"
      >> "Item3"
    > "Bag Of Holdings"
      >> "Item5"
      >> "Item6"
      >> "Item7"
    > "Item4"
    > "Item5"
 */
// Data structure.
class BagItem {
  var name: String
  var count: Int
  init(_ name: String, _ count: Int) {
    self.name = name
    self.count = count
  }
}
class BagHolding: BagItem {
  var items: [BagItem]
  init(_ name: String, _ count: Int, _ items: [BagItem]) {
    self.items = items
    super.init(name, count)
  }
}
var data = [BagItem]()
data.append(BagItem("Item1", 1))
data.append(BagItem("Item2", 1))
data.append(BagHolding("Bag Of Holding",
                       1,
                       [BagItem("Item1", 1), BagItem("Item2", 1), BagItem("Item3", 1)]))
data.append(BagHolding("Bag Of Holding",
                       1,
                       [BagItem("Item5", 1), BagItem("Item6", 1), BagItem("Item7", 1)]))
data.append(BagItem("Item4", 1))
data.append(BagItem("Item5", 1))
// Function.
func bagHoldingDescription(_ holdings: [BagItem]) {
  var dictionary = Dictionary<String, Int>()
  for holding in holdings {
    if let holding = holding as? BagHolding {
      for item in holding.items {
        if let count = dictionary[item.name] {
          dictionary[item.name] = count + 1
        } else {
          dictionary[item.name] = 1
        }
      }
    } else {
      if let count = dictionary[holding.name] {
        dictionary[holding.name] = count + 1
      } else {
        dictionary[holding.name] = 1
      }
    }
  }
  print(dictionary)
}
//bagHoldingDescription(data)
//: ---
//: ## 18. Closest X destinations
func closestXdestinations(numDestinations: Int,
                          allLocations: [[Int]],
                          numDeliveries: Int) -> [[Int]] {
  var listOfElements = [[Int]]()
  // Return empty list if numDeliveries are more than numDestinations.
  if numDeliveries > numDestinations {
    return listOfElements
  }
  // Create an array to store sqrt of each locations and its index.
  var sqrtArray = [(Double, Int)]()
  var index = 0
  for element in allLocations {
    sqrtArray.append((sqrt(Double((element[0] * element[0]) + (element[1] * element[1]))),
                      index))
    index += 1
  }
  // Sort the sqrt array.
  sqrtArray.sort(by: {$0.0 < $1.0})
  // Now append the locations upto numDeliveries for the index stored in sqrt array.
  for count in 0..<numDeliveries {
    let index = sqrtArray[count].1
    listOfElements.append(allLocations[index])
  }
  return listOfElements
}
//print(closestXdestinations(numDestinations: 3,
//                              allLocations: [[1, 2],[3, 4],[1, -1]],
//                             numDeliveries: 2))
//
//print(closestXdestinations(numDestinations: 3,
//                              allLocations: [[1, 2],[1, -1],[1, -1]],
//                             numDeliveries: 1))
//: ---
//: ## 19. Optimal utilization
func optimalUtilization(deviceCapacity: Int,
                        foregroundAppList: [[Int]],
                        backgroundAppList: [[Int]]
) -> [[Int]] {
  var finalList = [[Int]]()
  var maxCapacity = 0
  for fgApp in foregroundAppList {
    for bgApp in backgroundAppList {
      // Calculate the capacity for the given fgApp and bgApp.
      let capacity = fgApp[1] + bgApp[1]
      if capacity <= deviceCapacity && capacity >= maxCapacity {
        if capacity == maxCapacity {
          // We've got the capacity matching with the current maximum.
          finalList.append([fgApp[0], bgApp[0]])
        } else {
          maxCapacity = capacity
          // We've got better capacity than the previous.
          // Remove all previous one/s and append new one.
          finalList.removeAll()
          finalList.append([fgApp[0], bgApp[0]])
        }
      }
    }
  }
  return finalList
}
//print(optimalUtilization(deviceCapacity: 10,
//                      foregroundAppList: [[1, 3], [2, 5], [3, 7], [4, 10]],
//                      backgroundAppList: [[1, 2], [2, 3], [3, 4], [4, 5]]))
//print(optimalUtilization(deviceCapacity: 7,
//                      foregroundAppList: [[1, 2], [2, 4], [3, 6]],
//                      backgroundAppList: [[1, 2]]))
//: ---
/*:
 ## 20. Find the year with the hightes population
 Given a list of people with their birth and death year, find the year with the hightest
 population.
 */
struct Person {
  var birthYear: Int
  var deathYear: Int
}
func getPeakPopulationYear(people: [Person]) -> Int {
  let firstBirth = people.min(by: { $0.birthYear < $1.birthYear })!.birthYear
  let lastBirth = people.max(by: { $0.birthYear < $1.birthYear })!.birthYear
  var population = Array(repeating: 0, count: lastBirth - firstBirth + 1)
  for person in people {
    population[person.birthYear-firstBirth] += 1
    if person.deathYear >= firstBirth && person.deathYear <= lastBirth {
      population[person.deathYear-firstBirth] -= 1
    }
  }
  var peakPopulation = 0
  var runningPopulation = 0
  var peakPopulationYear = firstBirth
  for index in 0..<population.count {
    runningPopulation += population[index]
    if runningPopulation > peakPopulation {
      peakPopulation = runningPopulation
      peakPopulationYear = firstBirth + index
    }
  }
  return peakPopulationYear
}
//print(getPeakPopulationYear(people: [Person(birthYear: 2000, deathYear: 2010),
//                                     Person(birthYear: 1975, deathYear: 2005),
//                                     Person(birthYear: 1975, deathYear: 2003),
//                                     Person(birthYear: 1803, deathYear: 1809),
//                                     Person(birthYear: 1750, deathYear: 1869),
//                                     Person(birthYear: 1842, deathYear: 1935),
//                                     Person(birthYear: 1803, deathYear: 1921),
//                                     Person(birthYear: 1894, deathYear: 1921)]))
//: ---

struct Item {
  var title: String
  var description: String
  var category: String
}

let items = [
  Item(title: "A", description: "Aaa", category: "Alphabet"),
  Item(title: "$", description: "$#@", category: "Special"),
  Item(title: "X", description: "Xxx", category: "Alphabet"),
  Item(title: "B", description: "Bbb", category: "Alphabet"),
  Item(title: "Z", description: "Zzz", category: "Alphabet"),
  Item(title: "1", description: "100", category: "Number"),
]

// Array of dictionary
var dataSource = Dictionary<String, [Item]>()

for item in items {
  if let _ = dataSource[item.category] {
    dataSource[item.category]?.append(item)
  } else {
    dataSource[item.category] = [item]
  }
}

let categories = dataSource.keys.sorted(by: >)

//print(dataSource)
//print(categories)

//: [Next](@next)
