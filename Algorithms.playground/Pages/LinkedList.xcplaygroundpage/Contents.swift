//: [Previous](@previous)
//: ---
//: # TOP 10 ALGORITHMS
//: ---
//: ## SECTION VI: Linked List
//: ---
//: ## Data Structure
import Foundation
class Node {
  var next: Node?
  var data: Int
  init(value: Int) {
    data = value
  }
}
//: ---
//: ## #1. Linked List Operations - Append, Delete, Traverse
class LinkedList {
  var head: Node?
  func appendToTail(value: Int) {
    let node = Node(value: value)
    // Incase head is nil, append as head node
    guard let head = head else {
      self.head = node
      return
    }
    // Append as normal node at the end of linked list
    var this = head
    while this.next != nil {
      this = this.next!
    }
    this.next = node
  }

  func traverseLinkedList() {
    var this = head
    while this != nil {
      print("\(this!.data) => ", separator: "", terminator: "")
      this = this?.next
    }
  }
    
  func deleteNode(value: Int) {
    // Incase head is nil, delete nothing
    guard let head = head else { return }
    // Incase head is the node to delete
    var this = head
    if this.data == value {
      self.head = head.next
      return
    }
    // Traverse linked list to find and delete required node (except head)
    while this.next != nil {
      if this.next?.data == value {
        this.next = this.next?.next
        return
      }
      this = this.next!
    }
  }
}
//var linkedList: LinkedList = LinkedList()
//linkedList.appendToTail(value: 5)
//linkedList.appendToTail(value: 5)
//linkedList.appendToTail(value: 5)
//linkedList.appendToTail(value: 10)
//linkedList.appendToTail(value: 15)
//linkedList.appendToTail(value: 5)
//linkedList.appendToTail(value: 10)
//linkedList.appendToTail(value: 15)
//linkedList.appendToTail(value: 20)
//linkedList.appendToTail(value: 20)
//linkedList.appendToTail(value: 25)
//linkedList.appendToTail(value: 30)
//print(linkedList.traverseLinkedList())
//linkedList.deleteNode(value: 5)
//print(linkedList.traverseLinkedList())
//linkedList.deleteNode(value: 30)
//print(linkedList.traverseLinkedList())
//linkedList.deleteNode(value: 15)
//print(linkedList.traverseLinkedList())
//: ---
//: ## #2. Given a linked list which is sorted, insert a node in sorted way
func insertInSortedLinkedList(head: Node, value: Int) -> Node {
  var head = head
  let node = Node(value: value)
  if value <= head.data {
    node.next = head
    head = node
  } else {
    var runner = head
    while runner.next != nil && runner.next!.data < value {
      runner = runner.next!
    }
    node.next = runner.next
    runner.next = node
  }
  return head
}
//var linkedList: LinkedList = LinkedList()
//linkedList.appendToTail(value: 5)
//linkedList.appendToTail(value: 10)
//linkedList.appendToTail(value: 20)
//linkedList.head = insertInSortedLinkedList(head: linkedList.head!, value: 25)
//linkedList.traverseLinkedList()
//: ---
/*:
 ## #3. Compare two strings represented as linked lists
 Given two linked lists, represented as linked lists (every character is a node in linked list).
 Write a function compare() that works similar to strcmp(), i.e., it returns 0 if both strings are
 same, 1 if first linked list is lexicographically greater, and -1 if second string is
 lexicographically greater.
 
    Input: list1 = g->e->e->k->s->a, list2 = g->e->e->k->s->b
    Output: -1
 
    Input: list1 = g->e->e->k->s->a, list2 = g->e->e->k->s
    Output: 1
 
    Input: list1 = g->e->e->k->s, list2 = g->e->e->k->s
    Output: 0
 */
//: ---
/*:
 ## #4. Add two numbers represented by linked lists
 
    Input: 5->6->3  and 8->4->2
    Output: 1->4->0->5
 */
//: ---
/*:
 ## #5. Merge a linked list into another linked list at alternate positions
 
    Input:  5->7->17->13->11 and 12->10->2->4->6
    Output: 5->12->7->10->17->2->13->4->11->6 and nil
 
    Input: 1->2->3 and 4->5->6->7->8
    Output: 1->4->2->5->3->6 and 7->8
 */
//: ---
/*
 ## #6. Reverse a Linked List in groups of given size
 
    Inputs:  1->2->3->4->5->6->7->8->NULL and k = 3
    Output:  3->2->1->6->5->4->8->7->NULL.
 
    Inputs:  1->2->3->4->5->6->7->8->NULL and k = 5
    Output:  5->4->3->2->1->8->7->6->NULL.
 */
//: ---

//: ---
//: ## Rest All
//: ---
/*:
 ## Remove duplicates from unsorted linked list
 Approach I: With temporary buffer\
 Time: O(n)
 */
func removeDuplicates(linkedList: LinkedList) -> LinkedList {
  // Incase head is nil, return
  guard let head = linkedList.head else { return linkedList }
  // Incase linked list has some node
  var dataSet = Set<Int>()
  var this = head
  dataSet.insert(this.data)
  while this.next != nil {
    if dataSet.contains(this.next!.data) {
      this.next = this.next?.next
    } else {
      dataSet.insert(this.next!.data)
      this = this.next!
    }
  }
  return linkedList
}
//print(removeDuplicates(linkedList: linkedList).traverseLinkedList())
//: ---
/*:
 ## Remove duplicates from unsorted linked list
 Approach II: Without temporary buffer\
 Space: O(1)\
 Time: O(n^2)
 */
func removeDuplicates_(linkedList: LinkedList) -> LinkedList {
  var current = linkedList.head
  while current != nil {
    var runner = current!
    // Remove all future nodes that have the same value.
    while runner.next != nil {
      if current!.data == runner.next!.data {
        runner.next = runner.next!.next
      } else {
        runner = runner.next!
      }
    }
    current = current?.next
  }
  return linkedList
}
//print(removeDuplicates_(linkedList: linkedList).traverseLinkedList())
//: ---
//: ## Implement an algorithm to find the nth to last element of a singly linked list
//: Time: O(n)\
//: Space: O(1)
func nThToLast(linkedList: LinkedList, n: Int) -> Node? {
  if n<1 { return nil }
  var p1 = linkedList.head
  var p2 = linkedList.head
  for _ in 1..<n {
    if p2?.next != nil {
      p2 = p2?.next
    } else {
      return nil
    }
  }
  while p2?.next != nil {
    p1 = p1?.next
    p2 = p2?.next
  }
  return p1
}
//print(linkedList.traverseLinkedList())
//print(nThToLast(linkedList: linkedList, n: 1)?.data ?? "Invalid Input")
//print(nThToLast(linkedList: linkedList, n: 9)?.data ?? "Invalid Input")
//print(nThToLast(linkedList: linkedList, n: 10)?.data ?? "Invalid Input")
//print(nThToLast(linkedList: linkedList, n: 4)?.data ?? "Invalid Input")
//: ---
/*:
 ## Check if two linkedlist intersect each other and return the node where they intersect
  1. Nested loops
  2. Mark visited nodes
  3. Using difference of nodes counts
 */
func checkIfTheyIntersect(_ list1: Node?, _ list2: Node?) -> Node? {
  let list1Length = nodeCount(list: list1)
  let list2Length = nodeCount(list: list2)
  var runner1 = list1, runner2 = list2
  if list1Length > list2Length {
    for _ in 1...list1Length-list2Length {
      runner1 = runner1?.next
    }
  } else if list1Length < list2Length {
    for _ in 1...list2Length-list1Length {
      runner2 = runner2?.next
    }
  }
  while runner1 != nil && runner2 != nil {
    if runner1 === runner2 {
      return runner1
    }
    runner1 = runner1?.next
    runner2 = runner2?.next
  }
  return nil
}
func nodeCount(list: Node?) -> Int {
  var list = list, nodeCount = 0
  while list != nil {
    nodeCount += 1
    list = list?.next
  }
  return nodeCount
}
//var node1 = Node(value: 1)
//var node2 = Node(value: 2)
//var node3 = Node(value: 3)
//var node11 = Node(value: 11)
//var node12 = Node(value: 12)
//node1.next = node2
//node2.next = node3
//node11.next = node12
//node12.next = node2
//print(checkIfTheyIntersect(node1, node11))
//: ---
//: ## Check if the given linkedlist is circular
func isCircular(_ list: Node?) -> Bool {
  var runner1 = list
  var runner2 = list?.next
  while runner1 != nil && runner2 != nil {
    if runner1 === runner2 {
      return true
    }
    runner1 = runner1?.next
    runner2 = runner2?.next?.next
  }
  return false
}
//print(isCircular(node1))
//node3.next = node1
//print(isCircular(node1))
//: ---
//: [Next](@next)
