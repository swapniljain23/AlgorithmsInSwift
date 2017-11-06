import Foundation

class ListNode {
    var val: Int
    var next: ListNode?
    init(_ val: Int) {
        self.val = val
    }
    func traverse(){
        var runner: ListNode?
        runner = self
        while runner != nil{
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

//: [Previous](@previous)
/*:
 # LeetCode Challenges
 */
/*:
 ## Difficulty: Easy
 */
/*:
 ### Sum of two
 */
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    for (index, value) in nums.enumerated(){
        let valueTobeSearched = target - value
        for innerIndex in index+1..<nums.count{
            if valueTobeSearched == nums[innerIndex]{
                return [index, innerIndex]
            }
        }
    }
    return []
}
//print(twoSum([2, 7, 11, 15], 9))
/*:
 ### Find out if the number is Palindrome
 */
func isPalindrome(_ number: Int) -> Bool {
    if number < 0 || (number != 0 && number % 10 == 0){
        return false
    }
    var firstHalf = number
    var secondHalf = 0
    while firstHalf > secondHalf{
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
/*:
 ### Reverse Integer
 */
func reverse(_ number: Int) -> Int {
    var number = Int32(number)
    var reverseNo = Int32(0)
    let ten = Int32(10)
    while number != 0{
        if reverseNo > Int32.max/ten || (reverseNo == Int32.max/ten && number%ten > Int32.max%ten) || reverseNo < Int32.min/ten || (reverseNo == Int32.min/ten && number%ten < Int32.min%ten){
            return 0
        }
        reverseNo = reverseNo*ten + number%ten
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
/*:
 ### String Compression - Array Of Characters
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
    for read in stride(from: 0, to: chars.count, by: 1){
        if read + 1 == chars.count || chars[read] != chars[read+1]{
            chars[write] = chars[anchor]
            write += 1
            if read > anchor{
                for char in String(read - anchor + 1).characters{
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
/*:
 ### Roman to Int
 Given a roman numeral, convert it to an integer.
 Input is guaranteed to be within the range from 1 to 3999.
 */
func getDigit(char: Character) -> Int{
    if char == "I"{
        return 1
    }else if char == "V"{
        return 5
    }else if char == "X"{
        return 10
    }else if char == "L"{
        return 50
    }else if char == "C"{
        return 100
    }else if char == "D"{
        return 500
    }else if char == "M"{
        return 1000
    }
    return 0
}
func romanToInt(_ roman: String) -> Int{
    if roman.isEmpty{
        return 0
    }
    var total = 0
    var previousDigit = 1000
    for char in roman{
        let digit = getDigit(char: char)
        if digit > previousDigit{
            total += digit - 2*previousDigit
        }else{
            total += digit
        }
        previousDigit = digit
    }
    return total
}
// Test Cases:
//print(romanToInt("CXIV"))
/*:
 ### Longest Common Prefix
 * Write a function to find the longest common prefix string amongst an array of strings.
 */
func longestCommonPrefix(_ strs: [String]) -> String {
    var resultString = ""
    if strs.isEmpty{
        return resultString
    }
    for index in 0..<strs[0].count{
        let charAtIndex = Array(strs[0].characters)[index]
        for string in strs{
            if index == string.count || charAtIndex != Array(string.characters)[index]{
                return resultString
            }
        }
        resultString.append(charAtIndex)
    }
    return resultString
}
//print(longestCommonPrefix(["LettApp", "L", "LeeTDO"]))
/*:
 ### Valid Parentheses
 * Given a string containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.
 
 * The brackets must close in the correct order, "()" and "()[]{}" are all valid but "(]" and "([)]" are not.
 */
func isValid(_ s: String) -> Bool {
    if s.isEmpty{
        return false
    }
    var stack = [Character]()
    for char in s{
        if char == "(" || char == "{" || char == "["{
            stack.append(char)
            continue
        }
        if stack.isEmpty{
            return false
        }
        let lastChar = stack.removeLast()
        if (char == ")" && lastChar == "(") ||
            (char == "}" && lastChar == "{") ||
            (char == "]" && lastChar == "["){
            // do nothing
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
/*:
 ### Merge two sorted list
 * Merge two sorted linked lists and return it as a new list. The new list should be made by splicing together the nodes of the first two lists.
 */
func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    guard let l11 = l1, let l22 = l2 else{
        return l1 == nil ? l2 : l1
    }
    var l1 = l1, l2 = l2
    var root: ListNode?
    if l1!.val < l2!.val{
        root = l1
        l1 = l1!.next
    }else{
        root = l2
        l2 = l2!.next
    }
    var runner = root
    while l1 != nil && l2 != nil{
        if l1!.val < l2!.val{
            runner?.next = l1
            l1 = l1!.next
        }else{
            runner?.next = l2
            l2 = l2!.next
        }
        runner = runner?.next
    }
    l1 != nil ? (runner?.next = l1) : (runner?.next = l2)
    return root
}
// Test Cases:
/*:
 ### Remove Duplicates from Sorted Array
 * Given a sorted array, remove the duplicates in-place such that each element appear only once and return the new length.
 * Do not allocate extra space for another array, you must do this by modifying the input array in-place with O(1) extra memory.
 */
func removeDuplicates(_ nums: inout [Int]) -> Int {
    var write = 0, anchor = 0
    for read in stride(from: 0, to: nums.count, by: 1){
        if read + 1 == nums.count || nums[read] != nums[read+1]{
            nums[write] = nums[anchor]
            write += 1
            anchor = read + 1
        }
    }
    return write
}
// Test Cases:
//var anArr = [1, 1, 2]
//print(removeDuplicates(&anArr))
//print(anArr)
/*:
 ### Sqrt(x)
 * Implement int sqrt(int x).
 * Compute and return the square root of x.
 * x is guaranteed to be a non-negative integer.
 */
func mySqrt(_ x: Int) -> Int {
    var r = x
    while r*r > x{
        r = (r + x/r) / 2
    }
    return r
}
//print(mySqrt(25))
//print(mySqrt(2))
//print(mySqrt(8))
func mySqrtWithBSearch(_ x: Int) -> Int {
    if x == 0{
        return 0
    }
    var left = 1, right = x
    while true{
        var mid = Int(left + (right-left)/2)
        if mid > x/mid{
            right = mid - 1
        }else{
            if mid + 1 > x/(mid + 1){
                return mid
            }
            left = mid + 1
        }
    }
}
//print(mySqrtWithBSearch(25))
//print(mySqrtWithBSearch(2))
//print(mySqrtWithBSearch(8))
/*:
 ## Difficulty: Medium
 */
/*:
 ### Maximum Length of Repeated Subarray
 *Given two integer arrays A and B, return the maximum length of an subarray that appears in both arrays.
 
     Input:
     A: [1,2,3,2,1]
     B: [3,2,1,4,7]
     Output: 3
     Explanation:
     The repeated subarray with maximum length is [3, 2, 1].
 */
func findLength(_ A: [Int], _ B: [Int]) -> Int {
    var maxLength = 0
    var newArr = Array(repeating: Array(repeating: 0, count:B.count+1) , count: A.count+1)
    for indexA in stride(from: A.count-1, through: 0, by: -1){
        for indexB in stride(from: B.count-1, through: 0, by: -1){
            if A[indexA] == B[indexB]{
                newArr[indexA][indexB] = newArr[indexA+1][indexB+1] + 1
                if maxLength < newArr[indexA][indexB]{
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
/*:
 ### Add two numbers
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
    while l1 != nil || l2 != nil{
        sum /= 10
        if l1 != nil{
            sum += l1!.val
            l1 = l1?.next
        }
        if l2 != nil{
            sum += l2!.val
            l2 = l2?.next
        }
        runner.next = ListNode(sum % 10)
        runner = runner.next!
    }
    
    if sum / 10 == 1{
        runner.next = ListNode(1)
    }
    return list.next
}
//// Test Cases:
//// Test #1:
//var result = addTwoNumbers(l1, l4)
//print(result!.traverse())
//// Test #2:
//var resultNew = addTwoNumbers(l7, l8)
//print(resultNew!.traverse())
/*:
 ### String to Int
 */
extension Character{
    var asciiValue: UInt32?{
        return String(self).unicodeScalars.filter{$0.isASCII}.first?.value
    }
}

func stringToInt(_ string: String) -> Int{
    if string.count == 0{
        return 0
    }
    var total = Int32(0), sign = Int32(1), index = 0
    let anArray = Array(string)
    
    // Remove spaces
    while anArray[index] == " " && index < anArray.count{
        index += 1
    }
    
    // Handle signs
    if anArray[index] == "+" || anArray[index] == "-"{
        sign = anArray[index] == "+" ? 1 : -1
        index += 1
    }
    
    // Convert number and avoid overflow
    while index < anArray.count{
        let digit = anArray[index]
        if let ascii = digit.asciiValue, ascii >= 48, ascii <= 57, let value = Int32(String(digit)){
            // Check for overflow
            if Int32.max / 10 < total || Int32.max / 10 == total && Int32.max % 10 < value{
                return sign == 1 ? Int(Int32.max) : Int(Int32.min)
            }
            total = total * Int32(10) + value
        }else{
            break
        }
        index += 1
    }
    return Int(total * sign)
}
// Test Cases:
//print(stringToInt(""))
//print(stringToInt("+-2"))
//print(stringToInt("21474836472147483647"))
//print(stringToInt("    -123456789"))
//print(stringToInt("2147483648"))
/*:
 ### Implement pow(x, n)
 */
func myPow(_ x: Double, _ n: Int) -> Double {
    if n == 0{
        return 1
    }
    var n = n, x = x
    if n < 0{
        n = -n
        x = 1/x
    }
    return n == 2 ? x * x : (n % 2 == 0 ? myPow(myPow(x, n/2), 2) : x * myPow(myPow(x, n/2), 2))
}
// Test Cases:
//print(myPow(2, -3))
//print(myPow(2, 4))
//print(myPow(2, 0))
//print(myPow(0, 2))
//print(myPow(-2, 3))
//print(myPow(-2, 2))
//print(myPow(-2, -3))
//print(myPow(1.00001, 123456))
/*:
 ### Remove Nth Node From End of List
 */
func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
    if n<1 { return nil }
    var runner = head
    var nTh = head
    var n_1th: ListNode?
    for _ in 1..<n{
        if runner != nil{
            runner = runner!.next
        }
    }
    while runner?.next != nil{
        n_1th = nTh
        runner = runner?.next
        nTh = nTh?.next
    }
    // Remove nth node
    if n_1th != nil{
        n_1th?.next = nTh?.next
    }else{
        return head?.next
    }
    return head
}
// Test Cases:
//print(removeNthFromEnd(l1, 1)!.traverse())
//print(removeNthFromEnd(l1, 8)!.traverse())
/*:
 ## Difficulty: Hard
 */
/*:
 ### Median of two sorted array
 */
//func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
//
//}

//: [Next](@next)
