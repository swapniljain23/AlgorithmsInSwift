//: [Previous](@previous)
//: # LeetCode Challenges
//: ---
//: ## Data structure
import Foundation
class ListNode {
  var val: Int
  var next: ListNode?
  init(_ val: Int) {
    self.val = val
  }
  func traverse() {
    var runner: ListNode?
    runner = self
    while runner != nil {
      print(runner!.val)
      runner = runner!.next
    }
  }
}
let l1 = ListNode(1)
let l2 = ListNode(2)
let l3 = ListNode(3)
let l4 = ListNode(4)
let l5 = ListNode(5)
let l6 = ListNode(6)
let l7 = ListNode(7)
let l8 = ListNode(8)
l1.next = l2
l2.next = l3
l3.next = l4
l4.next = l5
l5.next = l6
l6.next = l7
l7.next = l8
//: ---
//: ## Difficulty: Easy
//: ---
//: ## 1. Sum of two
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    for (index, value) in nums.enumerated() {
        let valueTobeSearched = target - value
        for innerIndex in index+1..<nums.count {
            if valueTobeSearched == nums[innerIndex] {
                return [index, innerIndex]
            }
        }
    }
    return []
}
//print(twoSum([2, 7, 11, 15], 9))
//: ---
//: ## 2. Find out if the number is Palindrome
func isPalindrome(_ number: Int) -> Bool {
    if number < 0 || (number != 0 && number % 10 == 0) {
        return false
    }
    var firstHalf = number
    var secondHalf = 0
    while firstHalf > secondHalf {
        secondHalf = secondHalf * 10 + firstHalf % 10
        firstHalf = firstHalf / 10
    }
    return firstHalf == secondHalf || firstHalf == secondHalf/10
}
// Test Cases:
//print(isPalindrome(-9))
//print(isPalindrome(0))
//print(isPalindrome(9))
//print(isPalindrome(10))
//print(isPalindrome(99))
//print(isPalindrome(121))
//print(isPalindrome(1221))
//print(isPalindrome(1225221))
//: ---
//: ## 3. Reverse an integer
func reverse(_ number: Int) -> Int {
    var number = Int32(number)
    var reverseNo = Int32(0)
    let ten = Int32(10)
    while number != 0 {
        if reverseNo > Int32.max/ten ||
          (reverseNo == Int32.max/ten && number%ten > Int32.max%ten) ||
          reverseNo < Int32.min/ten ||
          (reverseNo == Int32.min/ten && number%ten < Int32.min%ten) {
            return 0
        }
        reverseNo = (reverseNo * ten) + (number % ten)
        number = number/ten
    }
    return Int(reverseNo)
}
// Test Cases:
//print(reverse(-654321))
//print(reverse(0))
//print(reverse(2147483647))
//print(reverse(-2147483648))
//print(reverse(100900))
//: ---
/*:
 ## 4. String Compression - Array Of Characters
 * Given an array of characters, compress it in-place.
 * The length after compression must always be smaller than or equal to the original array.
 * Every element of the array should be a character (not int) of length 1.
 * After you are done modifying the input array in-place, return the new length of the array.
 
 
         Input:
         ["a","a","b","b","c","c","c"]
         Output:
         Return 6, and the first 6 characters of the input array should be: ["a","2","b","2","c","3"]
         Explanation:
         "aa" is replaced by "a2". "bb" is replaced by "b2". "ccc" is replaced by "c3".
 */
func compress(_ chars: inout [Character]) -> Int {
    var write = 0, anchor = 0
    for read in stride(from: 0, to: chars.count, by: 1) {
        if read + 1 == chars.count || chars[read] != chars[read+1] {
            chars[write] = chars[anchor]
            write += 1
            if read > anchor {
                for char in String(read - anchor + 1) {
                    chars[write] = char
                    write += 1
                }
            }
            anchor = read + 1
        }
    }
    return write
}
//var charArr: [Character] = ["a", "b", "c", "c", "c", "c", "d", "d", "d", "e"]
//var charArr: [Character] = ["a","a","b","b","c","c","c"]
//var charArr: [Character] = ["a"]
//var charArr: [Character] = ["a","b","b","b","b","b","b","b","b","b","b","b","b"]
//var charArr: [Character] = ["a","b","c","d","e","f","g"]
//var charArr: [Character] = ["a","b","c","d","e","e","e","e","f","g"]
//print(compress(&charArr))
//print(charArr)
//: ---
/*:
 ## 5. Roman to Int
 * Given a roman numeral, convert it to an integer.
 * Input is guaranteed to be within the range from 1 to 3999.
 */
func getDigit(char: Character) -> Int {
  switch char {
    case "I":
      return 1
    case "V":
      return 5
    case "X":
      return 10
    case "L":
      return 50
    case "C":
      return 100
    case "D":
      return 500
    case "M":
      return 1000
    default:
      return 0
  }
}
func romanToInt(_ roman: String) -> Int {
    if roman.isEmpty {
        return 0
    }
    var total = 0
    var previousDigit = 1000
    for char in roman {
        let digit = getDigit(char: char)
        if digit > previousDigit {
            total += digit - 2 * previousDigit
        } else {
            total += digit
        }
        previousDigit = digit
    }
    return total
}
//print(romanToInt("CXIV"))
//: ---
/*:
 ## 6. Longest common prefix
 Write a function to find the longest common prefix string amongst an array of strings.
 */
func longestCommonPrefix(_ strs: [String]) -> String {
    var resultString = ""
    if strs.isEmpty {
        return resultString
    }
    for index in 0..<strs[0].count {
        let charAtIndex = Array(strs[0])[index]
        for string in strs {
            if index == string.count || charAtIndex != Array(string)[index] {
                return resultString
            }
        }
        resultString.append(charAtIndex)
    }
    return resultString
}
//print(longestCommonPrefix(["LettApp", "L", "LeeTDO"]))
//: ---
/*:
 ## 7. Valid parentheses
 * Given a string containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.
 * The brackets must close in the correct order, "()" and "()[]{}" are all valid but "(]" and "([)]" are not.
 */
func isValid(_ s: String) -> Bool {
    if s.isEmpty {
        return false
    }
    var stack = [Character]()
    for char in s {
        if char == "(" || char == "{" || char == "[" {
            stack.append(char)
            continue
        }
        if stack.isEmpty {
            return false
        }
        let lastChar = stack.removeLast()
        if (char == ")" && lastChar == "(") ||
            (char == "}" && lastChar == "{") ||
            (char == "]" && lastChar == "["){
            continue
        }else{
            return false
        }
    }
    return stack.isEmpty ? true : false
}
//print(isValid("()"))
//print(isValid("()[]{}"))
//print(isValid("(]"))
//print(isValid("([)]"))
//: ---
/*:
 ## 8. Merge two sorted list
 * Merge two sorted linked lists and return it as a new list. The new list should be made by splicing together the nodes of the first two lists.
 */
func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    guard let _ = l1, let _ = l2 else {
        return l1 == nil ? l2 : l1
    }
    var l1 = l1, l2 = l2
    var root: ListNode?
    if l1!.val < l2!.val {
        root = l1
        l1 = l1!.next
    } else {
        root = l2
        l2 = l2!.next
    }
    var runner = root
    while l1 != nil && l2 != nil {
        if l1!.val < l2!.val {
            runner?.next = l1
            l1 = l1!.next
        } else {
            runner?.next = l2
            l2 = l2!.next
        }
        runner = runner?.next
    }
    l1 != nil ? (runner?.next = l1) : (runner?.next = l2)
    return root
}
//: ---
/*:
 ## 9. Remove duplicates from sorted array
 * Given a sorted array, remove the duplicates in-place such that each element appear only once and return the new length.
 * Do not allocate extra space for another array, you must do this by modifying the input array in-place with O(1) extra memory.
 */
func removeDuplicates(_ nums: inout [Int]) -> Int {
    var write = 0, anchor = 0
    for read in stride(from: 0, to: nums.count, by: 1) {
        if read + 1 == nums.count || nums[read] != nums[read+1] {
            nums[write] = nums[anchor]
            write += 1
            anchor = read + 1
        }
    }
    return write
}
//var anArr = [1, 1, 2]
//print(removeDuplicates(&anArr))
//print(anArr)
//: ---
/*:
 ## 10. Sqrt(x)
 * Implement int sqrt(int x).
 * Compute and return the square root of x.
 * x is guaranteed to be a non-negative integer.
 */
func mySqrt(_ x: Int) -> Int {
    var r = x
    while r*r > x {
        r = (r + x/r) / 2
    }
    return r
}
//print(mySqrt(25))
//print(mySqrt(2))
//print(mySqrt(18))
// Square root with binary search
func mySqrtWithBSearch(_ x: Int) -> Int {
    if x == 0 {
        return 0
    }
    var left = 1, right = x
    while true {
        let mid = Int(left + (right-left)/2)
        if mid > x/mid {
            right = mid - 1
        } else {
            if mid + 1 > x/(mid + 1) {
                return mid
            }
            left = mid + 1
        }
    }
}
//print(mySqrtWithBSearch(25))
//print(mySqrtWithBSearch(2))
//print(mySqrtWithBSearch(8))
//: ---
//: ## Difficulty: Medium
//: ---
/*:
 ## 1. Maximum length of repeated subarray
 * Given two integer arrays A and B, return the maximum length of an subarray that appears in both arrays.
 
        Input:
        A: [1,2,3,2,1]
        B: [3,2,1,4,7]
        Output: 3
        Explanation:
        The repeated subarray with maximum length is [3, 2, 1].
 */
func findLength(_ A: [Int], _ B: [Int]) -> Int {
    var maxLength = 0
    var newArr = Array(repeating: Array(repeating: 0, count:B.count+1),
                       count: A.count+1)
    for indexA in stride(from: A.count-1, through: 0, by: -1) {
        for indexB in stride(from: B.count-1, through: 0, by: -1) {
            if A[indexA] == B[indexB] {
                newArr[indexA][indexB] = newArr[indexA+1][indexB+1] + 1
                if maxLength < newArr[indexA][indexB] {
                    maxLength = newArr[indexA][indexB]
                }
            }
        }
    }
    return maxLength
}
//print(findLength([1,2,3,2,1], [3,2,1,4,7]))
//print(findLength([3,2,1,4,7], [1,2,3,2,1]))
//print(findLength([0,0,0,0,1], [1,0,0,0,0]))
//: ---
/*:
 ## 2. Add two numbers
 * You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.
 * You may assume the two numbers do not contain any leading zero, except the number 0 itself.
 
         Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)
         Output: 7 -> 0 -> 8
 */
func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    var l1 = l1, l2 = l2
    let list = ListNode(0)
    var runner = list
    var sum = 0
    while l1 != nil || l2 != nil {
        sum /= 10
        if l1 != nil {
            sum += l1!.val
            l1 = l1?.next
        }
        if l2 != nil {
            sum += l2!.val
            l2 = l2?.next
        }
        runner.next = ListNode(sum % 10)
        runner = runner.next!
    }
    
    if sum / 10 == 1 {
        runner.next = ListNode(1)
    }
    return list.next
}
//var result = addTwoNumbers(l1, l4)
//print(result!.traverse())
//var resultNew = addTwoNumbers(l7, l8)
//print(resultNew!.traverse())
//: ---
//: ## 3. String to Int
extension Character {
    var asciiValue: UInt32? {
        return String(self).unicodeScalars.filter{ $0.isASCII }.first?.value
    }
}

func stringToInt(_ string: String) -> Int {
    if string.count == 0 {
        return 0
    }
    var total = Int32(0), sign = Int32(1), index = 0
    let anArray = Array(string)
    // Remove spaces
    while anArray[index] == " " && index < anArray.count {
        index += 1
    }
    // Handle signs
    if anArray[index] == "+" || anArray[index] == "-" {
        sign = anArray[index] == "+" ? 1 : -1
        index += 1
    }
    // Convert number and avoid overflow
    while index < anArray.count {
        let digit = anArray[index]
        if let ascii = digit.asciiValue, ascii >= 48, ascii <= 57,
          let value = Int32(String(digit)) {
            // Check for overflow
            if Int32.max / 10 < total || (Int32.max / 10 == total && Int32.max % 10 < value) {
                return sign == 1 ? Int(Int32.max) : Int(Int32.min)
            }
            total = total * Int32(10) + value
        } else {
            break
        }
        index += 1
    }
    return Int(total * sign)
}
//print(stringToInt(""))
//print(stringToInt("+-2"))
//print(stringToInt("21474836472147483647"))
//print(stringToInt("    -123456789"))
//print(stringToInt("2147483648"))
//: ---
//: ## 4. Implement pow(x, n)
func myPow(_ x: Double, _ n: Int) -> Double {
    if n == 0 {
        return 1
    }
    var n = n, x = x
    if n < 0 {
        n = -n
        x = 1/x
    }
    return n == 2 ? x * x : (n % 2 == 0 ? myPow(myPow(x, n/2), 2) : x * myPow(myPow(x, n/2), 2))
}
//print(myPow(2, -3))
//print(myPow(2, 4))
//print(myPow(2, 0))
//print(myPow(0, 2))
//print(myPow(-2, 3))
//print(myPow(-2, 2))
//print(myPow(-2, -3))
//print(myPow(1.00001, 123456))
//: ---
//: ## 5. Remove nTh node from end of the list
func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
    if n < 1 { return nil }
    var runner = head
    var nTh = head
    var n_1th: ListNode?
    for _ in 1..<n {
        if runner != nil {
            runner = runner!.next
        }
    }
    while runner?.next != nil {
        n_1th = nTh
        runner = runner?.next
        nTh = nTh?.next
    }
    // Remove nTh node
    if n_1th != nil {
        n_1th?.next = nTh?.next
    } else {
        return head?.next
    }
    return head
}
// Test Cases:
//print(removeNthFromEnd(l1, 1)!.traverse())
//print(removeNthFromEnd(l1, 8)!.traverse())
//: ---
//: ## 6.
/**
 * On an NxN chessboard, a knight starts at the r-th row and c-th column and attempts to make exactly K moves. The rows and columns are 0 indexed, so the top-left square is (0, 0), and the bottom-right square is (N-1, N-1).
 * A chess knight has 8 possible moves it can make, as illustrated below. Each move is two squares in a cardinal direction, then one square in an orthogonal direction.
 * Each time the knight is to move, it chooses one of eight possible moves uniformly at random (even if the piece would go off the chessboard) and moves there.
 * The knight continues moving until it has made exactly K moves or has moved off the chessboard. Return the probability that the knight remains on the board after it has stopped moving.
 */
// TODO:
func knightProbability(_ N: Int, _ K: Int, _ r: Int, _ c: Int) -> Double {
  if K <= 0 {
    return 1.0
  }
  var newPossibleMoves = possibleMoves(row: r, column: c)
  let number = numberOfValidAndIvalidMoves(moves: newPossibleMoves, N: N)
  var probability = Double(number.0) / Double(number.0 + number.1)
  newPossibleMoves = newPossibleMoves.filter {
    return !($0.0 < 0 || $0.0 >= N || $0.1 < 0 || $0.1 >= N)
  }
  if K > 1 && !newPossibleMoves.isEmpty {
    for _ in 2...K {
      var toAppend = [(Int, Int)]()
      for moves in newPossibleMoves {
        toAppend.append(contentsOf: possibleMoves(row: moves.0, column: moves.1))
      }
      let number = numberOfValidAndIvalidMoves(moves: toAppend, N: N)
      probability = probability * (Double(number.0) / Double(number.0 + number.1))
      let filtered = toAppend.filter {
        return !($0.0 < 0 || $0.0 >= N || $0.1 < 0 || $0.1 >= N)
      }
      newPossibleMoves.append(contentsOf: filtered)
    }
  }
  return probability
}

func possibleMoves(row: Int, column: Int) -> [(Int, Int)] {
  var array = [(Int, Int)]()
  array.append((row-2, column-1))
  array.append((row-2, column+1))
  array.append((row+2, column-1))
  array.append((row+2, column+1))
  array.append((row+1, column-2))
  array.append((row+1, column+2))
  array.append((row-1, column+2))
  array.append((row-1, column-2))
  return array
}

func numberOfValidAndIvalidMoves(moves: [(Int, Int)], N: Int) -> (Int, Int) {
  var validMoves = 0
  var invalidMoves = 0
  for move in moves {
    if move.0 < 0 || move.0 >= N || move.1 < 0 || move.1 >= N {
      invalidMoves += 1
    } else {
      validMoves += 1
    }
  }
  return (validMoves, invalidMoves)
}

//print(knightProbability(3, 2, 0, 0))
//print(knightProbability(1, 0, 0, 0))
//print(knightProbability(3, 2, 1, 1))
//: ## 7.
/**
 * Given the root of a binary tree, each node in the tree has a distinct value.
 * After deleting all nodes with a value in to_delete, we are left with a forest (a disjoint union of trees).
 * Return the roots of the trees in the remaining forest.  You may return the result in any order.
 *
 * Input: root = [1,2,3,4,5,6,7], to_delete = [3,5]
 * Output: [[1,2,null,4],[6],[7]]
 */
func delNodes(_ root: TreeNode?, _ to_delete: [Int]) -> [TreeNode?] {
  var queue = [TreeNode]()
  var treeNodes = [TreeNode?]()
  guard let node = root else {
    return treeNodes
  }
  queue.append(node)
  treeNodes.append(node)
  while !queue.isEmpty {
    let node = queue.removeFirst()
    if to_delete.contains(node.val) {
      treeNodes.removeAll(where: { $0?.val == node.val })
      if let left = node.left {
        treeNodes.append(left)
      }
      if let right = node.right {
        treeNodes.append(right)
      }
    }
    if let left = node.left {
      queue.append(left)
      if to_delete.contains(left.val) {
        node.left = nil
      }
    }
    if let right = node.right {
      queue.append(right)
      if to_delete.contains(right.val) {
        node.right = nil
      }
    }
  }
  return treeNodes
}
public class TreeNode {
  public var val: Int
  public var left: TreeNode?
  public var right: TreeNode?
  
  public init(_ val: Int) {
    self.val = val
    self.left = nil
    self.right = nil
  }
}
// Preorder - Root, Left, Right
func preorderTraversal(_ root: TreeNode?) {
  guard let root = root else {
    return
  }
  print(root.val, separator: "", terminator: " ")
  preorderTraversal(root.left)
  preorderTraversal(root.right)
  print("")
}

let one = TreeNode(1)
let two = TreeNode(2)
let thr = TreeNode(3)
let fou = TreeNode(4)
let fiv = TreeNode(5)
let six = TreeNode(6)
let sev = TreeNode(7)

one.left = two
one.right = thr
two.left = fou
two.right = fiv
thr.left = six
thr.right = sev

let nodes = delNodes(one, [1, 3, 5])
for node in nodes {
  preorderTraversal(node)
}
//: ## Difficulty: Hard
//: ---
//: ## 1. Median of two sorted array
//func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
//
//}
//: [Next](@next)


