//: [Previous](@previous)
//: # TOP 10 ALGORITHMS
//: =========================================
//: ## SECTION IV: Tree / Binary Search Tree.
//: =========================================
import Foundation
class Node {
  var value: Int
  var left: Node?
  var right: Node?
  init(value: Int) {
    self.value = value
  }
}
class Tree {
  var root: Node?
  init(_ root: Node?) {
    self.root = root
  }
}
let node1 = Node(value: 101)
let node2 = Node(value: 51)
let node3 = Node(value: 151)
let node4 = Node(value: 21)
let node5 = Node(value: 71)
let node6 = Node(value: 121)
let node7 = Node(value: 171)
let node8 = Node(value: 11)
let node9 = Node(value: 201)
node1.left = node2
node1.right = node3
node2.left = node4
node2.right = node5
node3.left = node6
node3.right = node7
node4.left = node8
node7.right = node9
/*:
 ### #1. Find Minimum Depth of a Binary Tree.
 The minimum depth is the number of nodes along the shortest path from root node down to the nearest
 leaf node.
 */
struct QueueItem {
  var node: Node
  var depth: Int
  init(_ node: Node, _ depth: Int) {
    self.node = node
    self.depth = depth
  }
}
func minDepthWithLevelOrderTraversal(root: Node) -> Int {
  var queue = [QueueItem]()
  var item = QueueItem(root, 1)
  queue.append(item)
  
  while !queue.isEmpty {
    item = queue.removeFirst()
    
    // If this is the first leaf node seen so far then return its depth.
    if item.node.left == nil && item.node.right == nil {
      return item.depth
    }
    if let left = item.node.left {
      queue.append(QueueItem(left, item.depth+1))
    }
    if let right = item.node.right {
      queue.append(QueueItem(right, item.depth+1))
    }
  }
  return 0
}
//print(minDepthWithLevelOrderTraversal(root: node1))

// ==========================================
/*:
 ### Level Order Tree Traversal: With Buffer
 Print the binary tree where all nodes in the same hierarchy (depth) should be printed in the same
 line.
 
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
func levelOrderTreeTraversal(root: Node) {
  var queue = [root]
  var childCount = 0
  var nextRowCount = 1
  while !queue.isEmpty {
    let node = queue.remove(at: 0)
    print(node.value, separator: "", terminator: "")
    nextRowCount -= 1
    if let left = node.left {
      queue.append(left)
      childCount += 1
    }
    if let right = node.right {
      queue.append(right)
      childCount += 1
    }
    if nextRowCount == 0 {
      print("")
      nextRowCount = childCount
      childCount = 0
    }
  }
}
//levelOrderTreeTraversal(root: node1)
//: ### Height of the Tree.
func maxDepth(_ root: Node?) -> Int {
    guard let root = root else {
        return 0
    }
    return 1 +  [maxDepth(root.left), maxDepth(root.right)].max()!
}
//print(maxDepth(node1))
//: ### Level Order Tree Traversal: With No Buffer.
func levelOrderTreeTraversalWithNoBuffer(_ root: Node) {
    for level in 1...maxDepth(root) {
        traverseAlevel(root, level)
        print("")
    }
}
func traverseAlevel(_ root: Node?, _ level: Int) {
    guard let root = root else {
        return
    }
    if level == 1 {
        print(root.value, separator: "", terminator: " ")
    } else if level > 1 {
        traverseAlevel(root.left, level-1)
        traverseAlevel(root.right, level-1)
    }
}
//levelOrderTreeTraversalWithNoBuffer(node1)
/*:
 ### Inorder travesal
 Left, Root, Right
 */
func inorderTraversal(_ root: Node?) {
    guard let root = root else {
        return
    }
    inorderTraversal(root.left)
    print(root.value, separator: "", terminator: " ")
    inorderTraversal(root.right)
}
//print(inorderTraversal(node1))
/*:
 ### Preorder travesal
 Root, Left, Right
 */
func preorderTraversal(_ root: Node?) {
    guard let root = root else {
        return
    }
    print(root.value, separator: "", terminator: " ")
    preorderTraversal(root.left)
    preorderTraversal(root.right)
}
//print(preorderTraversal(node1))
/*:
 ## Postorder travesal
 Left, Right, Root
 */
func postorderTraversal(_ root: Node?) {
    guard let root = root else {
        return
    }
    postorderTraversal(root.left)
    postorderTraversal(root.right)
    print(root.value, separator: "", terminator: " ")
}
//print(postorderTraversal(node1))
/*:
 ### Implement a function to check if a tree is balanced.
 A balanced tree is defined to be a tree such that no two leaf nodes differ in distance from the
 root by more than one.
 */
func minDepth(_ root: Node?) -> Int {
    guard let root = root else {
        return 0
    }
    return 1 +  [minDepth(root.left), minDepth(root.right)].min()!
}
func isBalanced(_ root: Node) -> Bool {
    return maxDepth(root) - minDepth(root) <= 1
}
//print(isBalanced(node1))
// ### Insertion in Binary Search Tree.
extension Tree {
    func insertNode(newValue: Int) {
        guard let root = root else {
            self.root = Node(value: newValue)
            return
        }
        insertNode(current: root, newValue: newValue)
    }
    private func insertNode(current: Node, newValue: Int) {
        if newValue < current.value {
            if let left = current.left {
                insertNode(current: left, newValue: newValue)
            } else {
                current.left = Node(value: newValue)
            }
        } else {
            if let right = current.right {
                insertNode(current: right, newValue: newValue)
            } else {
                current.right = Node(value: newValue)
            }
        }
    }
}
//let tree = Tree(node1)
//print(inorderTraversal(tree.root))
//tree.insertNode(newValue: 2)
//print(inorderTraversal(tree.root))
//tree.insertNode(newValue: -14)
//print(inorderTraversal(tree.root))
//tree.insertNode(newValue: 251)
//print(inorderTraversal(tree.root))
//tree.insertNode(newValue: 191)
//print(inorderTraversal(tree.root))
/*:
 ### Deletion in Binary Search Tree.
 ### Find a node in Binary Search Tree.
 ### Find the parent of a node in Binary Search Tree.
 */
extension Tree {
    func removeNode(value: Int) -> Bool {
        guard let nodeToRemove = findNode(value: value, root: root) else {
            return false
        }
        let parentNode = findParent(value: value, root: root)
        if (parentNode == nil && nodeToRemove.left == nil && nodeToRemove.right == nil) {
            root = nil
            return true
        } else if nodeToRemove.left == nil && nodeToRemove.right == nil {
            // #1. The value to remove is a leaf node.
            if nodeToRemove.value < parentNode!.value {
                parentNode!.left = nil
            } else {
                parentNode!.right = nil
            }
        } else if nodeToRemove.left == nil && nodeToRemove.right != nil {
            // #2. The value to remove has a right subtree, but no left subtree
            if nodeToRemove.value < parentNode!.value {
                parentNode!.left = nodeToRemove.right
            } else {
                parentNode!.right = nodeToRemove.right
            }
        } else if nodeToRemove.left != nil && nodeToRemove.right == nil {
            // #3. The value to remove has a left subtree, but no right subtree
            if nodeToRemove.value < parentNode!.value {
                parentNode!.left = nodeToRemove.left
            } else {
                parentNode!.right = nodeToRemove.left
            }
        } else if nodeToRemove.left != nil && nodeToRemove.right != nil {
            // The value to remove has both a left and right subtree in which case we promote the
            // largest value in the left subtree.
            var largetsValueNode = nodeToRemove.left!
            if largetsValueNode.right != nil {
                while largetsValueNode.right != nil {
                    largetsValueNode = largetsValueNode.right!
                }
                findParent(value: largetsValueNode.value, root: root)?.right = nil
                nodeToRemove.value = largetsValueNode.value
            } else {
                nodeToRemove.value = largetsValueNode.value
                nodeToRemove.left = largetsValueNode.left
            }
        }
        return true
    }
    
    func findNode(value: Int, root: Node?) -> Node? {
        guard let root = root else {
            return nil
        }
        if root.value == value {
            return root
        } else if value < root.value {
            return findNode(value: value, root: root.left)
        } else { //if value > root.value {
            return findNode(value: value, root: root.right)
        }
    }
    
    func findParent(value: Int, root: Node?) -> Node? {
        guard let root = root else {
            return nil
        }
        if root.value == value {
            return nil
        } else if value < root.value {
            if root.left == nil {
                return nil
            } else if root.left!.value == value {
                return root
            } else {
                return findParent(value: value, root: root.left)
            }
        } else { //if value > root.value {
            if root.right == nil {
                return nil
            } else if root.right!.value == value {
                return root
            } else {
                return findParent(value: value, root: root.right)
            }
        }
    }
}
//let tree = Tree(node1)
//print(inorderTraversal(tree.root))
//tree.removeNode(value: 11)
//tree.removeNode(value: 51)
//tree.removeNode(value: 101)
//tree.removeNode(value: 151)
//print(inorderTraversal(tree.root))
//  ### Finding the smallest and largest values in the binary search tree.
func findMin(_ root: Node) -> Node {
    if let left = root.left {
        return findMin(left)
    }
    return root
}
func findMax(_ root: Node) -> Node {
    if let right = root.right {
        return findMax(right)
    }
    return root
}
//print(findMin(node1).value)
//print(findMax(node1).value)
// ### Print all leaf nodes with their complete path.
func printLeafNodes(root: Node, parents: inout [Node]) {
  if root.left == nil && root.right == nil {
    printNodes(parents)
    parents.removeLast()
    return
  }
  if let left = root.left {
    parents.append(left)
    printLeafNodes(root: left, parents: &parents)
  }
  if let right = root.right {
    parents.append(right)
    printLeafNodes(root: right, parents: &parents)
  }
  parents.removeLast()
}

func printNodes(_ nodes: [Node]) {
  for node in nodes {
    print(node.value, separator: " ", terminator: " ")
  }
  print("")
}
//var nodes = [node1]
//printLeafNodes(root: node1, parents: &nodes)
//: [Next](@next)
