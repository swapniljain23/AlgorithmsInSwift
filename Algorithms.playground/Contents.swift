import Foundation


// MARK:- Arrays and Strings
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

class Employee {
    var firstName = "Swapnil"
    var lastName = "Jain"
    var passion = "Car, Bike"
}

class Organization {
    var employees = [Employee]()
}

func buildHashMap(employees: [Employee]){
    var hashMap: Dictionary<String, Employee> = Dictionary()
    for employee in employees{
        hashMap[employee.firstName] = employee
    }
}

func addEmployee(organization: Organization, employee: Employee){
    organization.employees.append(employee)
}

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
/* Check if String has all Unique characters */
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

// Approach I: ASCII (limit 256)
func hasAllUniqueChars(string: String) -> Bool{
    if string.characters.count>256{
        return false
    }

    var arr = [Bool](repeating: false, count: 256)
    
    for char in string.characters {
        let scalar = String(char).unicodeScalars
        if arr[Int(scalar[scalar.startIndex].value)]{
            return false
        }
        arr[Int(scalar[scalar.startIndex].value)] = true
    }
    return true
}
//print(hasAllUniqueChars(string: "Arihant"))

func hasAllUniqueCharacters(string: NSString) -> Bool{
    if string.length>256{
        return false
    }
    
    var arr = [Bool](repeating: false, count: 256)
    
    for index in 0...string.length-1{
        if arr[Int(string.character(at: index))]{
            return false
        }
        arr[Int(string.character(at: index))] = true
    }
    return true
}
//print(hasAllUniqueCharacters(string: "Arihant"))

// Approach II:
// Use bit vector

// Approach III:
// Sort the string (n log n) and then check linearly

// Approach IV:
// Check every char of the string with every other char O(n^2)

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
/* Check if two NSRange intersect each other */
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

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

//=-=-=-=-=-=-=-=-=-=-=-=-=-
// Print a String in reverse
//=-=-=-=-=-=-=-=-=-=-=-=-=-

// NSString
func reverseNSString(string: NSString){
    if string.length == 0{
        return
    }
    
    let char = string.character(at: string.length-1)
    print(Character(UnicodeScalar(char)!))
    
    let subString: NSString = string.substring(to: string.length-1) as NSString
    reverseNSString(string: subString)
}
//reverseNSString(string: "Swapnil")

// using reversed()
func reverseString(string: String) -> String{
//    return String(string.characters.reversed())
    return String(Array(string.characters).reversed())
}

// Swap in place, using char array
func reverseStringInPlace(string: String) -> String{
    guard string.characters.count > 1 else{
        return string
    }
    
    var newString = Array(string.characters)
    let maxIndex = newString.count - 1
    
    for index in 0...maxIndex{
        if index > maxIndex - index{
            break
        }
        (newString[index],newString[maxIndex-index]) = (newString[maxIndex-index],newString[index])
    }
    return String(newString)
}
//print(reverseString(string: "AppleelppA Apple Apple"))

func reverseStringUsingIndex(string: String) -> String{
    var reverseString = String()
    for character in string.characters{
        reverseString.insert(character, at: reverseString.startIndex)
    }
    return reverseString
}
//print(reverseStringUsingIndex(string: "Apple"))

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
/* Check if String One is Permutation of Other String */
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

// Approach I: Sort the strings
func permutationIstAppr(string1: String, string2: String) -> Bool{
    if string1.characters.count != string2.characters.count{
        return false
    }
    
    let charArray1 = string1.characters.sorted()
    let charArray2 = string2.characters.sorted()
    
    if charArray1.elementsEqual(charArray2){
        return true
    }else{
        return false
    }
}
//print(permutationIstAppr(string1: "Swapnil", string2: "nilSwap"))

// Approach II: Check if two strings have identical count for each unique char
func permutationIIndAppr(string1: String, string2: String) -> Bool{
    if string1.characters.count != string2.characters.count{
        return false
    }
    
    var charCountArr = [Int](repeating: 0, count: 256)
    
    for char in string1.characters{
        let scalar = String(char).unicodeScalars
        charCountArr[Int(scalar[scalar.startIndex].value)] += 1
    }
    
    for char in string2.characters{
        let scalar = String(char).unicodeScalars
        if (charCountArr[Int(scalar[scalar.startIndex].value)]) - 1 < 0{
            return false
        }
    }
    
    return true
}
//print(permutationIIndAppr(string1: "Swapnil", string2: "nilswap"))
// TODO:- Bug >> print(permutationIIndAppr(string1: "Swapnilxxxyy", string2: "nilSwapxxyyy"))

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
/* Replace all spaces in String with %20 */
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

func replaceSpace( charArr: [Character], length: Int){
    
    var charArr = charArr
    var spaceCount = 0
    for index in 0...length-1{
        if charArr[index] == " "{
            spaceCount += 1
        }
    }
    
    var newLength = length + (2 * spaceCount)
    
    var index = length - 1
    while index>=0 {
        if charArr[index] ==  " "{
            charArr[newLength-1] = "0"
            charArr[newLength-2] = "2"
            charArr[newLength-3] = "%"
            newLength -= 3
        }else{
            charArr[newLength-1] = charArr[index]
            newLength -= 1
        }
        index -= 1
    }
    print(charArr)
}

//replaceSpace(charArr: [" ","W"," ","P","N","I"," "," "," "," "," "," "," "," "," "], length: 7)

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
/* Basic String Compression */
// SSJJSJ -> S2J2S1J1
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

func countCompress(str: NSString) -> Int{
    if str.length <= 1{
        return str.length
    }
    
    var compressedStringSize = 0
    var count = 1
    var lastChar = str.character(at: 0)
    
    for index in 1...str.length-1{
        let char = str.character(at: index)
        if char == lastChar{
            count += 1
        }else{
            compressedStringSize += 1 + String(count).characters.count
            lastChar = char
            count = 1
        }
    }
    compressedStringSize += 1 + String(count).characters.count
    return compressedStringSize
}

//print(countCompress(str: "SSSSJJJJSSSSJJJ"))
//print(countCompress(str: "SJSJ"))
//print(countCompress(str: "JJJJJJJJJJ"))

func compressedString(str: NSString) -> NSString{
    if str.length <= 1 || str.length <= countCompress(str: str){
        return str
    }
    
    var count = 1
    var lastChar = str.character(at: 0)
    let compressedStr = NSMutableString.init(string: String(Character(UnicodeScalar(lastChar)!)))
    
    for index in 1...str.length-1{
        let char =  str.character(at: index)
        if char == lastChar{
            count += 1
        }else{
            compressedStr.append(String(count) + String(Character(UnicodeScalar(char)!)))
            count = 1
            lastChar = char
        }
    }
    compressedStr.append(String(count))
    return compressedStr
}

//print(compressedString(str: "SSSSJJJJSSSSJJJJ"))
//print(compressedString(str: "SJSJSJSJSJSJSJSJ"))
//print(compressedString(str: "SJ"))

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
/* Rotate the image by 90 degree */
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

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

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
/* Set zeros: If an element is zero set its entire row and column to zero */
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

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

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
/* If s2 is a rotatin of s1 */
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

func isRotation(s1: String, s2: String) -> Bool{
    if s1.characters.count == s2.characters.count && s1.characters.count > 0{
        let s1s1 = s1 + s1
        if isSubstring(s1: s1s1 as NSString, s2: s2 as NSString){
            return true
        }
    }
    return false
}

func isSubstring(s1: NSString, s2: NSString) -> Bool{
    if s1.length == 0 || s2.length == 0 || s1.length < s2.length{
        return false
    }
    
    var matchCount = 0
    for index in 0...s1.length-1{
        if s1.character(at: index) == s2.character(at: matchCount){
            matchCount += 1
            if matchCount == s2.length{
                return true
            }
        }else{
            matchCount = 0
        }
    }
    return false
}

//print(isSubstring(s1: "SwapnilJain", s2: "jain"))
//print(isRotation(s1: "SwapnilJain", s2: "JainSwapnil"))

// MARK:- Linked List
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

class Node{
    var next: Node?
    var data: Int
    
    init(value: Int){
        data = value
    }
}

/* Creating Linked List */

class LinkedList {
    
    var head: Node?
    
    func appendToTail(value: Int){
        let node = Node(value: value)
        // Incase head is nil, append as head node
        guard let head = head else{
            self.head = node
            return
        }
        
        // Append as normal node at the end of linked list
        var this = head
        while this.next != nil{
            this = this.next!
        }
        this.next = node
    }
    
    func traverseLinkedList(){
        // Incase head is nil, print nothing
        guard let head = head else{
            return
        }
        
        // Incase linked list has some node
        var this = head
        while this.next != nil{
            print("\(this.data) => ", separator: "", terminator: "")
            this = this.next!
        }
        print(this.data, separator: "", terminator: "")
    }
    
    func deleteNode(value: Int){
        
        // Incase head is nil, delete nothing
        guard let head = head else{
            return
        }
        var this = head
        
        // Incase head is the node to delete
        if this.data == value{
            self.head = head.next
            return
        }
        
        // Traverse linked list to find and delete required node in the linked list (except head)
        while this.next != nil{
            if this.next?.data == value{
                this.next = this.next?.next
                return
            }
            this = this.next!
        }
        return
    }
}

var linkedList: LinkedList = LinkedList()
linkedList.appendToTail(value: 5)
linkedList.appendToTail(value: 5)
linkedList.appendToTail(value: 5)
linkedList.appendToTail(value: 10)
linkedList.appendToTail(value: 15)
linkedList.appendToTail(value: 5)
linkedList.appendToTail(value: 10)
linkedList.appendToTail(value: 15)
linkedList.appendToTail(value: 20)
linkedList.appendToTail(value: 20)
linkedList.appendToTail(value: 25)
linkedList.appendToTail(value: 30)
//print(linkedList.traverseLinkedList())

//linkedList.deleteNode(value: 5)
//print(linkedList.traverseLinkedList())
//linkedList.deleteNode(value: 30)
//print(linkedList.traverseLinkedList())
//linkedList.deleteNode(value: 15)
//print(linkedList.traverseLinkedList())

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
/* Remove duplicates from unsorted linked list */
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

// Approach I: With temporary buffer
func removeDuplicates(linkedList: LinkedList) -> LinkedList{
    // Incase head is nil, return
    guard let head = linkedList.head else{
        return linkedList
    }
    // Incase linked list has some node
    var dictionary = Dictionary<Int, Bool>()
    
    var this = head
    dictionary[this.data] = true
    while this.next != nil{
        if let _ = dictionary[this.next!.data]{
            this.next = this.next?.next
        }else{
            dictionary[this.next!.data] = true
            this = this.next!
        }
    }
    return linkedList
}

//removeDuplicates(linkedList: linkedList).traverseLinkedList()

// Approach II: Without temporary buffer
func removeDuplicates_(linkedList: LinkedList) -> LinkedList{
    // Incase head is nil, return
    guard let head = linkedList.head else{
        return linkedList
    }
    var current = head
    var previous = head
    
    while current.next != nil{
        var runner = head
        while runner !== current{
            if current.data == runner.data{
                previous.next = current.next
                current = current.next!
                break
            }
            runner = runner.next!
        }
        if runner === current{
            previous = current
            current = current.next!
        }
    }
    return linkedList
}

//removeDuplicates_(linkedList: linkedList).traverseLinkedList()

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
/* Implement an algorithm to find the nth to last element of a singly linked list */
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

func nThToLast(linkedList: LinkedList, n: Int) -> Node?{
    // Incase head is nil, return
    guard let head = linkedList.head else{
        return nil
    }
    if n<1 { return nil }
    
    var p1 = head
    var p2 = head
    for _ in 1...n{
        if p2.next != nil{
            p2 = p2.next!
        }else{
            return nil
        }
    }
    while p2.next != nil{
        p1 = p1.next!
        p2 = p2.next!
    }
    return p1.next
}

//print(linkedList.traverseLinkedList())
//print(nThToLast(linkedList: linkedList, n: 1)?.data ?? "Invalid Input")

// MARK:- Stacks and Queues
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

class Stack {
    var top: Node?
    
    func push(value: Int){
        let node = Node(value: value)
        
        guard let top = top else{
            self.top = node
            return
        }
        node.next = top
        self.top = node
    }
    
    func pop(){
        guard let top = top else{
            return
        }
        self.top = top.next
    }
    
    func traverseStack(){

        guard let top = top else{
            return
        }
        var this = top
        while this.next != nil{
            print("\(this.data) => ", separator: "", terminator: "")
            this = this.next!
        }
        print(this.data, separator: "", terminator: "")
    }
}

let stack = Stack()
//print(stack.traverseStack())

stack.pop()
//print(stack.traverseStack())

stack.push(value: 5)
stack.push(value: 10)
stack.push(value: 15)
stack.push(value: 20)
//print(stack.traverseStack())

stack.pop()
stack.pop()
//print(stack.traverseStack())

class Queue {
    var first, last: Node?
    
    func enQueue(item: Int){
        let node = Node(value: item)
        guard let _ = first else{
            self.first = node
            self.last = self.first
            return
        }
        self.last?.next = node
        self.last = node
    }
    
    func deQueue(){
        guard let first = first else{
            return
        }
        self.first = first.next
    }
    
    func traverseQueue(){
        guard let first = first else{
            return
        }
        var this = first
        while this.next != nil{
            print("\(this.data) => ", separator: "", terminator: "")
            this = this.next!
        }
        print("\(this.data) => ", separator: "", terminator: "")
    }
}

let queue = Queue()

queue.deQueue()
//print(queue.traverseQueue())

queue.enQueue(item: 5)
queue.enQueue(item: 15)
queue.enQueue(item: 25)
queue.enQueue(item: 35)
queue.enQueue(item: 45)
//print(queue.traverseQueue())

queue.deQueue()
queue.deQueue()
//print(queue.traverseQueue())

// MARK:- Trees and Graphs
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


// MARK:- Thesis
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

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

func getSubstringFromString(sourceString: String, beforeString str: String) -> String{
    if let range = sourceString.range(of: str){
        return String(sourceString[..<range.lowerBound])
    }
    return ""
}

func getSubstringAfterString(sourceString: String, afterString str: String) -> String{
    if let range = sourceString.range(of: str){
        return String(sourceString[range.upperBound...sourceString.index(before: sourceString.endIndex)])
    }
    return ""
}

//print(getSubstringFromString(sourceString: "Swapnil:Jain", beforeString: "Jain"))
//print(getSubstringAfterString(sourceString: "Swapnil:Jain", afterString: "Ja"))

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

