//: [Previous](@previous)
//: ## Daily Coding Problem
//: ---
import Foundation
/*:
 ### Problem #1 [Easy, Google]
 ### Given a list of numbers and a number k, return whether any two numbers from the list add up to k.
    Input: [10, 15, 3, 7] and k = 17
    Output: true, since 10 + 7 is 17.
 */
//: ---
/*:
 ### Problem #2 [Hard, Uber]
 ### Given an array of integers, return a new array such that each element at index i of the new array is the product of all the numbers in the original array except the one at i.
    Input: [1, 2, 3, 4, 5]
    Output: [120, 60, 40, 30, 24]
    Input: [3, 2, 1]
    Output: [2, 3, 6]
 Follow-up: what if you can't use division?
 */
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
  init(_ value: Int, left: Node? = nil, right: Node? = nil) {
    self.value = value
    self.left = left
    self.right = right
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
  var node = deserialize(root: Node(0), serializedArray: &serializedArray, index: &index)
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
 TODO.
 */
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

//: ---
/*:
 ### Problem #8 [Easy]
 */
//: ---
/*:
 ### Problem #9 [Easy]
 */
//: ---
/*:
 ### Problem #10 [Easy]
 */
//: ---
/*:
 ### Problem #11 [Easy]
 */
//: ---
/*:
 ### Problem #12 [Easy]
 */
//: ---
//: [Next](@next)
