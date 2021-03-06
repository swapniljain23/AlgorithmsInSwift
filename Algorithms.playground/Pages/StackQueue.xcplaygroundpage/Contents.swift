//: [Previous](@previous)
//: # Stack and Queue
//: ---
//: ## Node class
import Foundation
class Node {
    var next: Node?
    var data: Int
    init(value: Int) {
        data = value
    }
}
//: ---
//: ## 1. Stack Operations - Push, Pop, Traverse
class Stack {
    var top: Node?
    func push(value: Int) {
        let node = Node(value: value)
        node.next = top
        top = node
    }
    func pop() {
        top = top?.next
    }
    func traverseStack() {
        var this = top
        while this != nil {
            print("\(this!.data) => ", separator: "", terminator: "")
            this = this!.next
        }
    }
}
//let stack = Stack()
//print(stack.traverseStack())
//stack.push(value: 5)
//stack.push(value: 10)
//stack.push(value: 15)
//stack.push(value: 20)
//print(stack.traverseStack())
//stack.pop()
//stack.pop()
//print(stack.traverseStack())
//stack.pop()
//stack.pop()
//stack.pop()
//print(stack.traverseStack())
//: ---
//: ## 2. Queue Operations - Enqueue, Dequeue, Traverse
class Queue {
    var first, last: Node?
    func enQueue(item: Int) {
        let node = Node(value: item)
        if let _ = first {
            last?.next = node
            last = node
        } else {
            first = node
            last = first
        }
    }
    func deQueue(){
        first = first?.next
    }
    func traverseQueue(){
        var this = first
        while this != nil{
            print("\(this!.data) => ", separator: "", terminator: "")
            this = this?.next
        }
    }
}
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
//: ---
//: ## 3. Implement Queue using two Stacks
class QueueWithStacks {
    var stackIn = [Int]()
    var stackOut = [Int]()
    func enQueue(_ element: Int) {
        stackIn.append(element)
    }
    func deQueue() -> Int? {
        if stackOut.count == 0 {
            while stackIn.count != 0 {
                stackOut.append(stackIn.removeLast())
            }
        }
        return stackOut.count == 0 ? nil : stackOut.removeLast()
    }
}
//let queue = QueueWithStacks()
//queue.enQueue(11)
//print(queue.deQueue() as Any)
//print(queue.deQueue() as Any)
//queue.enQueue(22)
//queue.enQueue(33)
//print(queue.deQueue() as Any)
//: ---
//: [Next](@next)
