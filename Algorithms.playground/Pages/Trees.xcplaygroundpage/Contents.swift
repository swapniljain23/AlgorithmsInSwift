import Foundation
//: [Previous](@previous)
/*:
 # Trees
*/
class Node{
    var value: Int
    var left: Node?
    var right: Node?
    init(value: Int){
        self.value = value
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
/*:
 ## Level Order Tree Traversal: With Buffer
 */
/*
 Print the binary tree where all nodes in the same hierarchy (depth) should be printed in the same line.
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
func levelOrderTreeTraversal(root: Node){
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
//levelOrderTreeTraversal(root: node1)
/*:
 ## Height of the Tree
 */
func heightOfTheTree(_ root: Node?) -> Int{
    guard let root = root else{
        return 0
    }
    if root.left != nil || root.right != nil{
        return 1 +  [heightOfTheTree(root.left), heightOfTheTree(root.right)].max()!
    }
    return 1
}
//print(heightOfTheTree(node1))
/*:
 ## Level Order Tree Traversal: With No Buffer
 */
func levelOrderTreeTraversalWithNoBuffer(_ root: Node){
    for level in 1...heightOfTheTree(root){
        traverseAlevel(root, level)
        print("")
    }
}
func traverseAlevel(_ root: Node?, _ level: Int){
    guard let root = root else{
        return
    }
    if level == 1{
        print(root.value, separator: "", terminator: " ")
    }else if level > 1{
        traverseAlevel(root.left, level-1)
        traverseAlevel(root.right, level-1)
    }
}
//levelOrderTreeTraversalWithNoBuffer(node1)
/*:
 ## Inorder travesal
 * Left, Root, Right
 */
func inorderTraversal(_ root: Node?){
    guard let root = root else{
        return
    }
    inorderTraversal(root.left)
    print(root.value, separator: "", terminator: " ")
    inorderTraversal(root.right)
}
//print(inorderTraversal(node1))
/*:
 ## Preorder travesal
 * Root, Left, Right
 */
func preorderTraversal(_ root: Node?){
    guard let root = root else{
        return
    }
    print(root.value, separator: "", terminator: " ")
    preorderTraversal(root.left)
    preorderTraversal(root.right)
}
//print(preorderTraversal(node1))
/*:
 ## Postorder travesal
 * Left, Right, Root
 */
func postorderTraversal(_ root: Node?){
    guard let root = root else{
        return
    }
    postorderTraversal(root.left)
    postorderTraversal(root.right)
    print(root.value, separator: "", terminator: " ")
}
//print(postorderTraversal(node1))
//: [Next](@next)
