import Foundation
//: [Previous](@previous)
/*:
 # Stack and Queue
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
 ## Stack Operations
 */
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
// Test Cases:
//let stack = Stack()
//print(stack.traverseStack())
//stack.pop()
//print(stack.traverseStack())
//stack.push(value: 5)
//stack.push(value: 10)
//stack.push(value: 15)
//stack.push(value: 20)
//print(stack.traverseStack())
//stack.pop()
//stack.pop()
//print(stack.traverseStack())
/*:
 ## Queue Operations
 */
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
// Test Cases:
//let queue = Queue()
//queue.deQueue()
//print(queue.traverseQueue())
//queue.enQueue(item: 5)
//queue.enQueue(item: 15)
//queue.enQueue(item: 25)
//queue.enQueue(item: 35)
//queue.enQueue(item: 45)
//print(queue.traverseQueue())
//queue.deQueue()
//queue.deQueue()
//print(queue.traverseQueue())

//: [Next](@next)
