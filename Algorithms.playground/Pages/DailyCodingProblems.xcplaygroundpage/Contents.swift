//: [Previous](@previous)
//: ## Daily Coding Problem
//: ---
import Foundation
struct CellIndex {
  var row: Int
  var column: Int
  init(_ row: Int, _ column: Int) {
    self.row = row
    self.column = column
  }
}
/*:
 ### Problem #1 [Easy, Google]
 ### Given a list of numbers and a number k, return whether any two numbers from the list add up to k.
    Input: [10, 15, 3, 7] and k = 17
    Output: true, since 10 + 7 is 17.
 */
//: ---
// Skipped.
/*:
 ### Problem #2 [Hard, Uber]
 ### Given an array of integers, return a new array such that each element at index i of the new array is the product of all the numbers in the original array except the one at i.
    Input: [1, 2, 3, 4, 5]
    Output: [120, 60, 40, 30, 24]
    Input: [3, 2, 1]
    Output: [2, 3, 6]
 Follow-up: what if you can't use division?
 */
// Skipped.
//: ---
/*:
 ### Problem #3 [Medium, Google]
 ### Given the root to a binary tree, implement serialize(root), which serializes the tree into a string, and deserialize(string), which deserializes the string back into the tree.
 node = Node('root', Node('left', Node('left.left')), Node('right'))
 assert deserialize(serialize(node)).left.left.val == 'left.left'
 */
class Node {
  var value: Int
  var left: Node?
  var right: Node?
  var parent: Node?
  var isLocked = false
  var lockedDescendantsCount = 0
  init(_ value: Int, left: Node? = nil, right: Node? = nil, parent: Node? = nil) {
    self.value = value
    self.left = left
    self.right = right
    self.parent = parent
  }
}
func serialize(root: Node?, serializedArray: inout [Int]) {
  guard let root = root else {
    serializedArray.append(-1)
    return
  }
  serializedArray.append(root.value)
  serialize(root: root.left, serializedArray: &serializedArray)
  serialize(root: root.right, serializedArray: &serializedArray)
}
func deserialize(root: Node, serializedArray: inout [Int], index: inout Int) -> Node? {
  if serializedArray[index] == -1 {
    index += 1
    return nil
  }
  let node = Node(serializedArray[index])
  index += 1
  node.left = deserialize(root: node, serializedArray: &serializedArray, index: &index)
  node.right = deserialize(root: node, serializedArray: &serializedArray, index: &index)
  return node
}
func testSerializeDeserialize() {
  var serializedArray = [Int]()
  serialize(root: Node(5, left: Node(10, left: Node(15)), right: Node(20)),
  serializedArray: &serializedArray)
  print(serializedArray)
  var index = 0
  let node = deserialize(root: Node(0), serializedArray: &serializedArray, index: &index)
  if let value = node?.left?.left?.value {
    assert(value == 15, "testSerializeDeserialize failed!!")
  } else {
    print("testSerializeDeserialize failed!!")
  }
}
//testSerializeDeserialize()
//: ---
/*:
 ### Problem #4 [Hard, Stripe]
 ### Given an array of integers, find the first missing positive integer in linear time and constant space.
 In other words, find the lowest positive integer that does not exist in the array. The array can contain duplicates and negative numbers as well.
    Input: [3, 4, -1, 1]
    Output: 2
    Input: [1, 2, 0]
    Output: 3
 */
func firstMissingPositiveInteger(array: [Int]) -> Int {
  var array = array
  for element in array {
    if element <= 0 || element > array.count {
      continue
    }
    var value = element
    while array[value-1] != value {
      let nextValue = array[value-1]
      array[value-1] = value
      value = nextValue
      if value <= 0 || value > array.count {
        break
      }
    }
  }
  for (index, value) in array.enumerated() {
    if  value != index + 1 {
      return index + 1
    }
  }
  return array.count + 1
}
//print(firstMissingPositiveInteger(array: [3, 4, -1, 1]))
//print(firstMissingPositiveInteger(array: [1, 2, 0]))
//print(firstMissingPositiveInteger(array: [9, 5, 7, 11]))
//: ---
/*:
 ### Problem #5 [Medium, Jane Street]
 Skipped.
 */
//: ---
/*:
 ### Problem #6 [Hard, Google]
 Skipped.
 */
//: ---
/*:
 ### Problem #7 [Medium, Facebook]
 ### Given the mapping a = 1, b = 2, ... z = 26, and an encoded message, count the number of ways it can be decoded.
    Input: 111
    Output: 3, 'aaa', 'ak', 'ka'
 */
// TODO.
//: ---
/*:
 ### Problem #8 [Easy, Google]
 ### Given the root to a binary tree, count the number of unival subtrees.
 A unival tree (which stands for "universal value") is a tree where all nodes under it have the same value.
 */
func countUnivalSubtrees(root: Node?) -> Int {
  guard let root = root else {
    return 0
  }
  if root.left == nil && root.right == nil {
    return 1
  }
  let subtreesUnivalCount = countUnivalSubtrees(root: root.left) +
                            countUnivalSubtrees(root: root.right)
  let isLeft = root.left == nil ? false : true
  let isRight = root.right == nil ? false : true
  if isLeft && isRight && root.value == root.left!.value && root.value == root.right!.value {
    return 1 + subtreesUnivalCount
  }
  if isLeft && !isRight && root.left!.value == root.value {
    return 1 + subtreesUnivalCount
  }
  if !isLeft && isRight && root.right!.value == root.value {
    return 1 + subtreesUnivalCount
  }
  return subtreesUnivalCount
}
//var root = Node(0,
//                left: Node(1),
//                right:Node(0,
//                           left:Node(1,
//                                     left: Node(1),
//                                     right: Node(1)),
//                           right: Node(0)))
//print(countUnivalSubtrees(root: root))
//// TODO: Failing.
//root = Node(5,
//            left: Node(5, left: Node(1), right: Node(2)),
//            right: Node(5, left: Node(1), right: Node(2)))
//print(countUnivalSubtrees(root: root))
//: ---
/*:
 ### Problem #9 [Hard, Airbnb]
 ### Given a list of integers, write a function that returns the largest sum of non-adjacent numbers. Numbers can be 0 or negative.
    Input: [2, 4, 6, 2, 5]
    Output: 13, [2, 6, 5]
    Input: [5, 1, 1, 5]
    Output: 10, [5, 5]
 */
// TODO.
//: ---
/*:
 ### Problem #10 [Medium, Apple]
 ### Implement a job scheduler which takes in a function f and an integer n, and calls f after n milliseconds.
 */
typealias Closure = () -> ()
func callTheFunction(closure: @escaping Closure, miliseconds: Int) {
  DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(miliseconds)) {
    // Call the function.
    closure()
  }
}
func helloWorld() {
  print("Hello World!")
}
//callTheFunction(closure: helloWorld, miliseconds: 1000)
//callTheFunction(closure: helloWorld, miliseconds: 5000)
//: ---
/*:
 ### Problem #11 [Medium, Twitter, Snap]
 ### Implement an autocomplete system. That is, given a query string s and a set of all possible query strings, return all strings in the set that have s as a prefix.
    Input: queryString: de, set of strings: [dog, deer, deal]
    Output: [deer, deal]
 Hint: Try preprocessing the dictionary into a more efficient data structure to speed up queries.
 */
// TODO.
//: ---
/*:
 ### Problem #12 [Hard, Amazon]
 ### There exists a staircase with N steps, and you can climb up either 1 or 2 steps at a time. Given N, write a function that returns the number of unique ways you can climb the staircase. The order of the steps matters.
    Input: N = 4
    Output: 5 unique ways, [1, 1, 1, 1], [2, 1, 1], [1, 2, 1], [1, 1, 2], [2, 2].
 What if, instead of being able to climb 1 or 2 steps at a time, you could climb any number from a set of positive integers X? For example, if X = {1, 3, 5}, you could climb 1, 3, or 5 steps at a time.
 */
// TODO.
//: ---
/*:
 ### Problem #13 [Hard, Amazon]
 ### Given an integer K and a string S, find the length of the longest substring that contains at most K distinct characters.
    Input: String - "abcba", K = 2
    Output: "bcb"
 */
// TODO.
//: ---
/*:
 ### Problem #14 [Medium, Google]
 ### The area of a circle is defined as πr^2. Estimate π to 3 decimal places using a Monte Carlo method.
 Hint: The basic equation of a circle is x2 + y2 = r2.
 */
struct Point {
  var x: Double
  var y: Double
}
// Simulate rain drop.
func rainDrop(lengthOfField: Int = 1) -> Point {
  return Point(x: (0.5 - Double.random(in: 0..<1)) * Double(lengthOfField),
               y: (0.5 - Double.random(in: 0..<1)) * Double(lengthOfField))
}
// Check if the drop point inscribed in circle.
func isPointInCircle(point: Point, lengthOfField: Int = 1) -> Bool {
  // x^2 + y^2 <= r^2
  return (point.x * point.x) + (point.y * point.y)
      <= (Double(lengthOfField) / 2.0) * (Double(lengthOfField) / 2.0)
}
func rain(noOfDrops: Int = 10000, lengthOfField: Int = 1) -> Double {
  var numberOfDropsInCircle = 0
  var piEstimate = 0.0
  for drop in 1...noOfDrops {
    let point = rainDrop(lengthOfField: lengthOfField)
    if isPointInCircle(point: point, lengthOfField: lengthOfField) {
      numberOfDropsInCircle += 1
    }
    piEstimate = Double(4 * numberOfDropsInCircle) / Double(drop)
  }
  return piEstimate
}
//print(rain(noOfDrops: 10000, lengthOfField: 10))
//: ---
/*:
 ### Problem #15 [Medium, Facebook]
 ### Given a stream of elements too large to store in memory, pick a random element from the stream with uniform probability.
 */
// Skipped.
//: ---
/*:
 ### Problem #16 [Easy, Twitter]
 ### You run an e-commerce website and want to record the last N order ids in a log. Implement a data structure to accomplish this, with the following API:
 record(order_id): adds the order_id to the log
 get_last(i): gets the ith last element from the log. i is guaranteed to be smaller than or equal to N.
 */
// Skipped.
//: ---
/*:
 ### Problem #17 [Hard, Google]
 ### Given a string representing the file system in the above format, return the length of the longest absolute path to a file in the abstracted file system. If there is no file in the system, return 0.
 The string "dir\n\tsubdir1\n\tsubdir2\n\t\tfile.ext" represents:
 dir
  subdir1
  subdir2
    file.ext
 */
struct Directory {
  var length: Int
  var level: Int
}
func longestAbsolutePath(path: String) -> Int {
  let dirs = path.split(separator: "\n").map(String.init)
  var stack = [Directory]()
  var max = 0
  for dir in dirs {
    var level = 0
    var index = 0
    var range =
        dir.index(dir.startIndex, offsetBy: index)...dir.index(dir.startIndex, offsetBy: index)
    while dir[range] == "\t" {
      index += 1
      level += 1
      range =
          dir.index(dir.startIndex, offsetBy: index)...dir.index(dir.startIndex, offsetBy: index)
    }
    while !stack.isEmpty && level <= stack.last!.level {
      stack.removeLast()
    }
    if dir.contains(".") {
      if stack.isEmpty {
        max = [max, dir.count - index].max()!
      } else {
        max = [max, stack.last!.length + dir.count - index].max()!
      }
    } else {
      if stack.isEmpty {
        stack.append(Directory(length: (dir.count - index + 1), level: level))
      } else {
        stack.append(Directory(length: (stack.last!.length + dir.count - index + 1), level: level))
      }
    }
  }
  return max
}
//print(longestAbsolutePath(path: "dir\n\tsubdir1\n\t\tfile1.ext\n\t\tsubsubdir1\n\tsubdir2\n\t\tsubsubdir2\n\t\t\tfile2.ext"))
//print(longestAbsolutePath(path: "dir\n\tsubdir1\n\tsubdir2\n\t\tfile.ext"))
//: ---
/*:
 ### Problem #18 [Hard, Google]
 ### Given an array of integers and a number k, where 1 <= k <= length of the array, compute the maximum values of each subarray of length k.
    Input:  [10, 5, 2, 7, 8, 7], k = 3
    Output: [10, 7, 8, 8] - max(10, 5, 2) = 10, max(5, 2, 7) = 7, max(2, 7, 8) = 8, max(7, 8, 7) = 8.
 Hint: You can modify the input array in-place.
 Runtime: O(n), Space: O(k) where k is the length of the subarray.
 */
func maxValuesOfEachSubarray(array: [Int], size: Int) -> [Int] {
  var result = [Int]()
  var deque = [Int]()
  for (index, _) in array.enumerated() {
    // Remove element out of window.
    if !deque.isEmpty && deque.first! == index-size {
      deque.removeFirst()
    }
    // Deque is in decending order.
    while !deque.isEmpty && array[deque.last!] < array[index] {
      deque.removeLast()
    }
    // Push the current element in the queue.
    deque.append(index)
    if index >= size - 1 {
      result.append(array[deque.first!])
    }
  }
  return result
}
//print(maxValuesOfEachSubarray(array: [10, 5, 2, 7, 8, 7], size: 3))
//print(maxValuesOfEachSubarray(array: [1, 3, -1, -3, 5, 3, 6, 7], size: 4))
//: ---
/*:
 ### Problem #19 [Medium, Facebook]
 ### A builder is looking to build a row of N houses that can be of K different colors. He has a goal of minimizing cost while ensuring that no two neighboring houses are of the same color.
 Given an N by K matrix where the nth row and kth column represents the cost to build the nth house with kth color, return the minimum cost which achieves this goal.
 */
func minimumCost(housesCost: [[Int]]) -> Int {
  var housesCost = housesCost
  for houseIndex in 1..<housesCost.count {
    for colorIndex in 0..<housesCost[houseIndex].count {
      var prevoiusRow = housesCost[houseIndex-1]
      prevoiusRow.remove(at: colorIndex)
      housesCost[houseIndex][colorIndex] += prevoiusRow.min()!
    }
  }
  return housesCost.last!.min()!
}
//print(minimumCost(housesCost: [[4, 0, 3], [8, 3, 8], [4, 5, 0], [3, 4, 4], [8, 8, 0]]))
//print(minimumCost(housesCost: [[7, 3, 8, 6, 1, 2], [5, 6, 7, 2, 4, 3], [10, 1, 4, 9, 7, 6]]))
//: ---
/*:
 ### Problem #20 [Easy, Google]
 ### Given two singly linked lists that intersect at some point, find the intersecting node. The lists are non-cyclical.
 */
// See LinkedList chapter, section iii, problem #1.
//: ---
/*:
 ### Problem #21 [Easy, Snap]
 ### Given an array of time intervals (start, end) for classroom lectures (possibly overlapping), find the minimum number of rooms required.
    Input:  [(30, 75), (0, 50), (60, 150)]
    Output: 2
 */
struct Time {
  var isStartTime: Bool
  var time: Int
}
func minimumNoOfRoomsRequired(intervals: [(Int, Int)]) -> Int {
  var timeArray = [Time]()
  for item in intervals {
    timeArray.append(Time(isStartTime: true, time: item.0))
    timeArray.append(Time(isStartTime: false, time: item.1))
  }
  timeArray.sort(by: { $0.time < $1.time })
  var minRoomsRequired = 0
  var runningSum = 0
  for element in timeArray {
    if element.isStartTime {
      runningSum += 1
    } else {
      runningSum -= 1
    }
    if runningSum > minRoomsRequired {
      minRoomsRequired = runningSum
    }
  }
  return minRoomsRequired
}
//print(minimumNoOfRoomsRequired(intervals: [(30, 75), (0, 50), (60, 150)]))
//print(minimumNoOfRoomsRequired(intervals:  [(1, 4), (1, 4), (8, 9), (2, 6)]))
//: ---
/*:
 ### Problem #22 [Medium, Microsoft]
 ### Given a dictionary of words and a string made up of those words (no spaces), return the original sentence in a list.
    Input: ['quick', 'brown', 'the', 'fox'], "thequickbrownfox"
    Output: ['the', 'quick', 'brown', 'fox']
 */
func sentenceList(words: Set<String>, sentence: String?, result: inout [String]) {
  guard let sentence = sentence, sentence.count > 0 else {
    return
  }
  for index in 1...sentence.count {
    if words.contains(String(sentence.prefix(index))) {
      result.append(String(sentence.prefix(index)))
      sentenceList(words: words,
                sentence: String(sentence.suffix(sentence.count-index)),
                  result: &result)
      break
    }
  }
}
var result = [String]()
//sentenceList(words: ["quick", "brown", "the", "fox"], sentence: "thequickbrownfox", result: &result)
//print(result)
//sentenceList(words: ["bed", "bath", "bedbath", "and", "beyond"],
//          sentence: "bedbathandbeyond",
//            result: &result)
//print(result)
//: ---
/*:
 ### Problem #23 [Easy, Google]
 ### You are given an M by N matrix consisting of booleans that represents a board. Each True boolean represents a wall. Each False boolean represents a tile you can walk on.
 ### Given this matrix, a start coordinate, and an end coordinate, return the minimum number of steps required to reach the end coordinate from the start. If there is no possible path, then return null. You can move up, left, down, and right. You cannot move through walls. You cannot wrap around the edges of the board.
    Input: [[f, f, f, f], [t, t, f, t], [f, f, f, f], [f, f, f, f]], start = 3, 0, end = 0, 0
    Output: 7
 */
struct Index {
  var row: Int
  var column: Int
}
func minimumStepsRequired(board: [[Bool]], start: Index, end: Index) -> Int {
  var resultMatrix = Array(repeating: Array(repeating: -1, count: board.count),
                               count: board[0].count)
  computeDistance(board: board,
                  start: Index(row: 3, column: 0),
                  result: &resultMatrix,
                  value: 0)
  print(resultMatrix)
  return resultMatrix[end.row][end.column]
}
func computeDistance(board: [[Bool]], start: Index, result: inout [[Int]], value: Int) {
  // Base case.
  if start.row < 0 ||
      start.row >= result.count ||
      start.column < 0 ||
      start.column >= result[0].count ||
      result[start.row][start.column] == Int.max {
    return
  }
  if board[start.row][start.column] {
    result[start.row][start.column] = Int.max
  } else if result[start.row][start.column] == -1 || result[start.row][start.column] > value {
    result[start.row][start.column] = value
    computeDistance(board: board,
                    start: Index(row: start.row+1, column: start.column),
                   result: &result, value: value+1)
    computeDistance(board: board,
                    start: Index(row: start.row-1, column: start.column),
                    result: &result, value: value+1)
    computeDistance(board: board,
                    start: Index(row: start.row, column: start.column+1),
                    result: &result, value: value+1)
    computeDistance(board: board,
                    start: Index(row: start.row, column: start.column-1),
                    result: &result, value: value+1)
  }
}
//print(minimumStepsRequired(board: [[false, false, false, false],
//                                   [true, true, false, true],
//                                   [false, false, false, false],
//                                   [false, false, false, false]],
//                           start: Index(row: 3, column: 0),
//                             end: Index(row: 0, column: 0)))
//: ---
/*:
 ### Problem #24 [Medium, Google]
 ### Implement locking in a binary tree. A binary tree node can be locked or unlocked only if all of its descendants or ancestors are not locked.
 is_locked, which returns whether the node is locked.
 lock, which attempts to lock the node. If it cannot be locked, then it should return false. Otherwise, it should lock it and return true.
 unlock, which unlocks the node. If it cannot be unlocked, then it should return false. Otherwise, it should unlock it and return true.
 */
extension Node {
  
  func canLockOrUnlock() -> Bool {
    if self.lockedDescendantsCount > 0 {
      return false
    }
    var runner = self.parent
    while runner != nil {
      if runner!.isLocked {
        return false
      }
      runner = runner?.parent
    }
    return true
  }
  
  func lock() -> Bool {
    if !self.canLockOrUnlock() {
      return false
    }
    self.isLocked = true
    var runner = self.parent
    while runner != nil {
      runner!.lockedDescendantsCount += 1
      runner = runner?.parent
    }
    return true
  }
  
  func unlock() -> Bool {
    if !self.canLockOrUnlock() {
      return false
    }
    self.isLocked = false
    var runner = self.parent
    while runner != nil {
      runner!.lockedDescendantsCount -= 1
      runner = runner?.parent
    }
    return true
  }
}
//: ---
/*:
 ### Problem #25 [Hard, Facebook]
 ### Implement regular expression matching with the following special characters:
 . (period) which matches any single character.
 * (asterisk) which matches zero or more of the preceding element.
 That is, implement a function that takes in a string and a valid regular expression and returns whether or not the string matches the regular expression.
 */
func doesItMatch(text: String, pattern: String) -> Bool {
  var text = Array(text)
  var pattern = Array(pattern)
  var dp = Array(repeating: Array(repeating: false, count: pattern.count+1),
                     count: text.count+1)
  dp[0][0] = true
  // Handle patterns like a* or a*b* or a*b*c*
  for index in 1..<dp[0].count {
    if pattern[index-1] == "*" {
      dp[0][index] = dp[0][index-2]
    }
  }
  // All other cases.
  for i in 1..<dp.count { // Text.
    for j in 1..<dp[0].count { // Pattern.
      if pattern[j-1] == text[i-1] ||
          pattern[j-1] == "." {
        dp[i][j] = dp[i-1][j-1]
      } else if pattern[j-1] == "*" {
        dp[i][j] = dp[i][j-2]
        if pattern[j-2] == "." || pattern[j-2] == text[i-1] {
          dp[i][j] = dp[i][j] || dp[i-1][j]
        }
      } else {
          dp[i][j] = false
      }
    }
  }
  return dp[text.count][pattern.count]
}
//print(doesItMatch(text: "aaabbbccc", pattern: "a*b*c*")) // true
//print(doesItMatch(text: "bcc", pattern: "a*b*c*")) // true
//print(doesItMatch(text: "aaxbbxcc", pattern: "a*b*c*")) // false
//print(doesItMatch(text: "ray", pattern: "ra.")) // true
//print(doesItMatch(text: "raymond", pattern: "ra.")) // false
//print(doesItMatch(text: "chat", pattern: ".*at")) // true
//print(doesItMatch(text: "chats", pattern: ".*at")) // false
//: ---
/*:
 ### Problem #26 [Medium, Google]
 ### Given a singly linked list and an integer k, remove the kth last element from the list. k is guaranteed to be smaller than the length of the list.
 Do this in constant space and in one pass.
 */
// See LinkedList chapter, section II, problem #2.
//: ---
/*:
 ### Problem #27 [Easy, Facebook]
 Given a string of round, curly, and square open and closing brackets, return whether the brackets are balanced (well-formed).
 Input: "([])[]({})"
 Ouput: true
 Input: "([)]"
 Output: false
 */
func isBalanced(string: String) -> Bool {
  var stack = [Character]()
  for character in string {
    switch character {
    case "(", "[", "{":
      stack.append(character)
    case ")":
      let top = stack.removeLast()
      if top != "(" {
        return false
      }
    case "]":
      let top = stack.removeLast()
      if top != "[" {
        return false
      }
    case "}":
      let top = stack.removeLast()
      if top != "{" {
        return false
      }
    default:
      // Invalid
      return false
    }
  }
  return true
}
//print(isBalanced(string: "([])[]({})"))
//print(isBalanced(string: "([)]"))
//: ---
/*:
 ### Problem #28 [Medium, Palantir]
 ### Write an algorithm to justify text. Given a sequence of words and an integer line length k, return a list of strings which represents each line, fully justified.
    Input: ["the", "quick", "brown", "fox", "jumps", "over", "the", "lazy", "dog"], lenght = 16
    Output: ["the  quick brown"], ["fox  jumps  over"], ["the   lazy   dog"]
 */
func justifyText(words: [String], lineLength: Int) -> [String] {
  var justifiedText = [String]()
  var runningLength = 0
  var wordsInLine = [String]()
  for word in words {
    if runningLength + word.count > lineLength {
      justifiedText.append(adjustWords(words: wordsInLine,
                                  lineLength: lineLength))
      wordsInLine.removeAll()
      runningLength = 0
    }
    runningLength += (word.count + 1)
    wordsInLine.append(word)
  }
  if runningLength > 0 {
    justifiedText.append(adjustWords(words: wordsInLine,
                                lineLength: lineLength))
  }
  return justifiedText
}
func adjustWords(words: [String], lineLength: Int) -> String {
  var resultString = ""
  let charCount = words.reduce(0, { return $0 + $1.count })
  precondition(charCount <= lineLength, "Line lenght must be greater or equal than total char count!")
  let extraLength = lineLength - charCount
  if words.count == 1 {
    resultString.append(words.first!)
    for _ in 0..<extraLength {
      resultString.append(" ")
    }
    return resultString
  }
  let evenSpace = extraLength / (words.count-1)
  var extraSpace = extraLength % (words.count-1)
  for (index, word) in words.enumerated() {
    resultString.append(word)
    if index == words.count-1 {
      break
    }
    for _ in 1...evenSpace {
      resultString.append(" ")
    }
    if extraSpace > 0 {
      resultString.append(" ")
      extraSpace -= 1
    }
  }
  return resultString
}
//print(justifyText(words: ["the", "quick", "brown", "fox", "jumps", "over", "the", "lazy", "dog"],
//             lineLength: 16))
//print(justifyText(words: ["the", "quick", "brown", "fox", "jumps", "over", "the", "lazy", "dog"],
//                  lineLength: 10))
//print(justifyText(words: ["the", "quick", "brown", "fox", "jumps", "over", "the", "lazy", "dog"],
//             lineLength: 5))
// Precondition failure.
//print(justifyText(words: ["the", "quick", "brown", "fox", "jumps", "over", "the", "lazy", "dog"],
//                  lineLength: 3))
//: ---
/*:
 ### Problem #29 [Easy, Amazon]
 ### String encoding.
    Input: "AAAABBBCCDAA"
    Output: "4A3B2C1D2A"
 */
// See problem #5 in String page.
//: ---
/*:
 ### Problem #30 [Medium, Facebook]
 
 */
//: ---
/*:
 ### Problem #31 [Easy, Google]
 ### Given two strings, compute the edit distance between them.
 The edit distance between two strings refers to the minimum number of character insertions, deletions, and substitutions required to change one string to the other.
    Input: "kitten", "sitting"
    Output: 3
 */
// See problem #3 in Dynamic programming.
//: ---
/*:
 ### Problem #32 [Easy, Google]
 
 */
//: ---
/*:
 ### Problem #33 [Easy, Microsoft]
 ### Compute the running median of a sequence of numbers.
 That is, given a stream of numbers, print out the median of the list so far on each new element.
    Input:  [2, 1, 5, 7, 2, 0, 5]
    Output: 2, 1.5, 2, 3.5, 2, 2, 2.
 */
class Sequence {
  // Keeps track of SMALL numbers.
  var maxHeap = [Int]() // 1, 2
  // Keep track of LARGE numbers.
  var minHeap = [Int]() // 5, 7
  
  func addNumber(number: Int) {
    if maxHeap.isEmpty {
      maxHeap.append(number)
    } else if maxHeap.count == minHeap.count {
      if number < minHeap.first! {
        maxHeap.append(number)
      } else {
        minHeap.append(number)
        maxHeap.append(minHeap.removeFirst())
      }
    } else if maxHeap.count > minHeap.count {
      if number > maxHeap.first! {
        minHeap.append(number)
      } else {
        maxHeap.append(number)
        minHeap.append(maxHeap.removeFirst())
      }
    }
    // maxHeap will never have fewer element than minHeap.
  }
  
  func getMedian() -> Double {
    guard maxHeap.count > 0 else {
      return 0.0
    }
    if maxHeap.count == minHeap.count {
      return Double(maxHeap.last! + minHeap.first!) / 2.0
    } else {
      return Double(maxHeap.last!)
    }
  }
  
  func testSequence(sequence: [Int]) -> [Double] {
    var result = [Double]()
    for element in sequence {
      addNumber(number: element)
      result.append(getMedian())
    }
    return result
  }
}
//let sequence = Sequence()
//print(sequence.testSequence(sequence: [2, 1, 5, 7, 2, 0, 5]))
// TODO: Fix it.
//: ---
/*:
 ### Problem #34 [Easy, Google]
 
 */
//: ---
/*:
 ### Problem #35 [Easy, Google]
 
 */
//: ---
/*:
 ### Problem #36 [Easy, Google]
 
 */
//: ---
/*:
 ### Problem #37 [Easy, Google]
 ### Write a function that, given a set, generates its power set.
 The power set of a set is the set of all its subsets.
 */
// See problem #12 in Arrays page.
//: ---
/*:
 ### Problem #38 [Easy, Google]
 
 */
//: ---
/*:
 ### Problem #39 [Easy, Google]
 
 */
//: ---
/*:
 ### Problem #40 [Easy, Google]
 
 */
//: ---
/*:
 ### Problem #41 [Easy, Google]
 
 */
//: ---
/*:
 ### Problem #42 [Easy, Google]
 
 */
//: ---
/*:
 ### Problem #43 [Easy, Google]
 
 */
//: ---
/*:
 ### Problem #44 [Easy, Google]
 
 */
//: ---
/*:
 ### Problem #45 [Easy, Google]
 
 */
//: ---
/*:
 ### Problem #46 [Easy, Google]
 
 */
//: ---
/*:
 ### Problem #47 [Easy, Facebook]
 ### Given a array of numbers representing the stock prices of a company in chronological order, write a function that calculates the maximum profit you could have made from buying and selling that stock once. You must buy before you can sell it.
 */
// See problem #10 in String & Arrays page.
//: ---
/*:
 ### Problem #48 [Easy, Google]
 
 */
//: ---
/*:
 ### Problem #49 [Medium, Amazon]
 ### Given an array of numbers, find the maximum sum of any contiguous subarray of the array.
 */
// See problem #10 in Arrays page.
//: ---
/*:
 ### Problem #50 [Easy, Google]
 
 */
//: ---
/*:
 ### Problem #51 [Easy, Google]
 
 */
//: ---
/*:
 ### Problem #52 [Easy, Google]
 
 */
//: ---
/*:
 ### Problem #53 [Medium, Apple]
 ### Implement a queue using two stacks.
 */
// See problem #3 in StackQueue page.
//: ---
/*:
 ### Problem #54 [Easy, Google]
 
 */
//: ---
/*:
 ### Problem #55 [Easy, Google]
 
 */
//: ---
/*:
 ### Problem #56 [Easy, Google]
 
 */
//: ---
/*:
 ### Problem #57 [Easy, Google]
 
 */
//: ---
/*:
 ### Problem #58 [Easy, Google]
 
 */
//: ---
/*:
 ### Problem #59 [Easy, Google]
 
 */
//: ---
/*:
 ### Problem #60 [Easy, Google]
 
 */
//: ---
/*:
 ### Problem #61 [Easy, Google]
 
 */
//: ---
/*:
 ### Problem #62 [Medium, Facebook]
 ### There is an N by M matrix of zeroes. Given N and M, write a function to count the number of ways of starting at the top-left corner and getting to the bottom-right corner. You can only move right or down.
 */
func numberOfWays(rows: Int, columns: Int) -> Int {
  var array = Array(repeating: Array(repeating: 0, count: rows),
                        count: columns)
  return updateCell(array: &array, rowIndex: 0, columnIndex: 0)
}

func updateCell(array: inout [[Int]], rowIndex: Int, columnIndex: Int) -> Int {
  if rowIndex >= array.count || columnIndex >= array[rowIndex].count {
    return 0
  }

  if (rowIndex == array.count - 1 && columnIndex == array[rowIndex].count - 1) {
    array[rowIndex][columnIndex] = 0
  } else if rowIndex == array.count - 1 || columnIndex == array[rowIndex].count - 1 {
    array[rowIndex][columnIndex] = 1
  } else if array[rowIndex][columnIndex] == 0 {
    array[rowIndex][columnIndex] =
        updateCell(array: &array, rowIndex: rowIndex, columnIndex: columnIndex+1) +
            updateCell(array: &array, rowIndex: rowIndex+1, columnIndex: columnIndex)
  }
  return array[rowIndex][columnIndex]
}
//print(numberOfWays(rows: 3, columns: 3)) // 6.
//print(numberOfWays(rows: 4, columns: 4)) // 20.
//print(numberOfWays(rows: 5, columns: 5)) // 70.
//: ---
/*:
 ### Problem #63 [Easy, Microsoft]
 ### Given a 2D matrix of characters and a target word, write a function that returns whether the word can be found in the matrix by going left-to-right, or up-to-down.
 */
func findWord(matrix: [[Character]], cellIndex: CellIndex, word: [Character], charIndex: Int) -> Bool {
  if cellIndex.row >= matrix.count || cellIndex.column >= matrix[cellIndex.row].count {
    return false
  }
  var charIndex = charIndex
  if matrix[cellIndex.row][cellIndex.column] == word[charIndex] {
    if charIndex == word.count - 1 {
      return true
    }
    charIndex += 1
  } else {
    charIndex = 0
  }
  var cellIndex1 = CellIndex(cellIndex.row + 1, cellIndex.column)
  var cellIndex2 = CellIndex(cellIndex.row, cellIndex.column + 1)
  return findWord(matrix: matrix, cellIndex: cellIndex1, word: word, charIndex: charIndex) ||
      findWord(matrix: matrix, cellIndex: cellIndex2, word: word, charIndex: charIndex)
}
//print(findWord(matrix: [["F", "A", "C", "I"],
//                        ["O", "B", "Q", "P"],
//                        ["A", "N", "O", "B"],
//                        ["M", "A", "S", "S"]],
//            cellIndex: CellIndex(0, 0),
//                 //word: ["F", "O", "A", "M"],
//                 //word: ["M", "A", "S", "S"],
//                 word: ["F", "O", "B", "N", "O", "S", "S", "T"],
//            charIndex: 0))
//: ---

//: [Next](@next)
