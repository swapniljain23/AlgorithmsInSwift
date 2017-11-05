import Foundation
//: [Previous](@previous)
/*:
 # Linked List
 */
/*:
 ## Node Class
 */
class Node{
    var next: Node?
    var data: Int
    
    init(value: Int){
        data = value
    }
}
/*:
 ## Linked List Operations
 */
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
        var this = head
        while this != nil{
            print("\(this!.data) => ", separator: "", terminator: "")
            this = this?.next
        }
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
    }
}
// Test Cases:
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
//
//linkedList.deleteNode(value: 5)
//print(linkedList.traverseLinkedList())
//linkedList.deleteNode(value: 30)
//print(linkedList.traverseLinkedList())
//linkedList.deleteNode(value: 15)
//print(linkedList.traverseLinkedList())
/*:
 ## Remove duplicates from unsorted linked list
 Approach I: With temporary buffer
 */
func removeDuplicates(linkedList: LinkedList) -> LinkedList{
    // Incase head is nil, return
    guard let head = linkedList.head else{
        return linkedList
    }
    // Incase linked list has some node
    var dataSet = Set<Int>()
    var this = head
    dataSet.insert(this.data)
    while this.next != nil{
        if dataSet.contains(this.next!.data){
            this.next = this.next?.next
        }else{
            dataSet.insert(this.next!.data)
            this = this.next!
        }
    }
    return linkedList
}
// Space:
// Time: O(n)
// Test Cases:
//print(removeDuplicates(linkedList: linkedList).traverseLinkedList())
/*:
 ## Remove duplicates from unsorted linked list
 Approach II: Without temporary buffer
 */
func removeDuplicates_(linkedList: LinkedList) -> LinkedList{
    var current = linkedList.head
    while current != nil{
        var runner = current!
        // Remove all future nodes that have the same value.
        while runner.next != nil{
            if current!.data == runner.next!.data{
                runner.next = runner.next!.next
            }else{
                runner = runner.next!
            }
        }
        current = current?.next
    }
    return linkedList
}
// Space: O(1)
// Time: O(n^2)
// Test Cases:
//print(removeDuplicates_(linkedList: linkedList).traverseLinkedList())
/*:
 ## Implement an algorithm to find the nth to last element of a singly linked list
 */
func nThToLast(linkedList: LinkedList, n: Int) -> Node?{
    if n<1 { return nil }
    var p1 = linkedList.head
    var p2 = linkedList.head
    for _ in 1..<n{
        if p2?.next != nil{
            p2 = p2?.next
        }else{
            return nil
        }
    }
    while p2?.next != nil{
        p1 = p1?.next
        p2 = p2?.next
    }
    return p1
}
// Time: O(n)
// Space: O(1)
// Test Cases:
//print(linkedList.traverseLinkedList())
//print(nThToLast(linkedList: linkedList, n: 1)?.data ?? "Invalid Input")
//print(nThToLast(linkedList: linkedList, n: 9)?.data ?? "Invalid Input")
//print(nThToLast(linkedList: linkedList, n: 10)?.data ?? "Invalid Input")
//print(nThToLast(linkedList: linkedList, n: 4)?.data ?? "Invalid Input")
//: [Next](@next)
