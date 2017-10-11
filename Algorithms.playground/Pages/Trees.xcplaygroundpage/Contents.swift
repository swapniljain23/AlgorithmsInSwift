import Foundation
//: [Previous](@previous)
/*:
 # Trees
*/
/*:
 ## Print the binary tree
 */
/*
 Print the binary tree where all nodes in the same hierarchy (depth) should be printed in the same line.
 Similar question: Print UIView hierarchy with idention.
 Input:
 1 -> 2, 3
 2 -> 4, 5
 3 -> 6, 7
 4 -> 8
 7 -> 9
 Output:
 1
 23
 4567
 89
*/
class Node{
    var value: Int
    var left: Node?
    var right: Node?
    init(value: Int){
        self.value = value
    }
}
func printBinaryTree(root: Node){
    var queue = [root]
    var childCount = 0
    var nextRowCount = 1
    while !queue.isEmpty{
        let node = queue.remove(at: 0)
        print(node.value, separator: "", terminator: "")
        nextRowCount -= 1
        if let left = node.left{
            queue.append(left)
            childCount += 1
        }
        if let right = node.right{
            queue.append(right)
            childCount += 1
        }
        if nextRowCount == 0{
            print("")
            nextRowCount = childCount
            childCount = 0
        }
    }
}
//let node1 = Node(value: 1)
//let node2 = Node(value: 2)
//let node3 = Node(value: 3)
//let node4 = Node(value: 4)
//let node5 = Node(value: 5)
//let node6 = Node(value: 6)
//let node7 = Node(value: 7)
//let node8 = Node(value: 8)
//let node9 = Node(value: 9)
//node1.left = node2
//node1.right = node3
//node2.left = node4
//node2.right = node5
//node3.left = node6
//node3.right = node7
//node4.left = node8
//node7.right = node9
//printBinaryTree(root: node1)
//: [Next](@next)
