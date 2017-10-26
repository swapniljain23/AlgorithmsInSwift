import Foundation

//: [Previous](@previous)
/*:
 # LeetCode Challenges
 */
/*:
 ## Sum of two
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
 ## Add two numbers
 * You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.
 * You may assume the two numbers do not contain any leading zero, except the number 0 itself.
 
         Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)
         Output: 7 -> 0 -> 8
 */
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
//let l1 = ListNode(2)
//let l2 = ListNode(4)
//let l3 = ListNode(3)
//l1.next = l2
////l2.next = l3
//let l4 = ListNode(5)
//let l5 = ListNode(6)
//let l6 = ListNode(4)
//l4.next = l5
//l5.next = l6
//var result = addTwoNumbers(l1, l4)
//print(result!.traverse())
//
//// Test #2:
//let l7 = ListNode(5)
//let l8 = ListNode(5)
//var resultNew = addTwoNumbers(l7, l8)
//print(resultNew!.traverse())
/*:
 ## String to Int
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
//: [Next](@next)
