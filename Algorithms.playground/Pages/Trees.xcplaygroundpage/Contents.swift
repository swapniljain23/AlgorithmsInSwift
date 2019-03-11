//: [Previous](@previous)
//: # TOP 10 ALGORITHMS
//: ---
//: ## SECTION IV: Tree / Binary Search Tree
//: ---
//: ## Data structure
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
//: ---
/*:
 ## #1. Find minimum depth of a binary tree (level order traversal)
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
  // Process until queue is empty.
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
//: ---
/*:
 ## #2. Maximum path sum in a binary tree
 Given a binary tree, find the maximum path sum. The path may start and end at any
 node in the tree.
*/
func maxPathSum(root: Node, result: inout Int) -> Int {
  var leftSum = 0
  var rightSum = 0
  // Recursive call to get sum of left and right child.
  if let left = root.left {
    leftSum = maxPathSum(root: left, result: &result)
  }
  if let right = root.right {
    rightSum = maxPathSum(root: right, result: &result)
  }
  // At-most one child of root.
  let sum = [[leftSum, rightSum].max()! + root.value, root.value].max()!
  // When node is under consideration.
  let maxInPath = [sum, leftSum + rightSum + root.value].max()!
  result = [result, maxInPath].max()!
  
  return sum
}
//var result = 0
//maxPathSum(root: node1, result: &result)
//print(result) // 746
//result = 0
//maxPathSum(root: node2, result: &result)
//print(result) // 154
//: ---
/*:
 ## #3. Check if an array can represent preorder traversal of binary search tree
 Given an array of numbers, return true if given array can represent preorder
 traversal of a binary search tree, else return false. Expected time complexity is
 O(n).
 
    Input - {2, 3, 4}
    Output: true
    Input: {2, 4, 1}
    Output: false
    Input: {40, 30, 35, 80, 100}
    Output: true
    Input: {40, 30, 35, 20, 80, 100}
    Output: false
 */
func canRepresentBST(items: [Int]) -> Bool {
  var stack = [Int]()
  var root = Int.min
  for item in items {
    if item < root { return false }
    while !stack.isEmpty && stack.last! < item {
      root = stack.removeLast()
    }
    stack.append(item)
  }
  return true
}
//print(canRepresentBST(items: [2, 3, 4]))
//print(canRepresentBST(items: [2, 4, 1]))
//print(canRepresentBST(items: [40, 30, 35, 80, 100]))
//print(canRepresentBST(items: [40, 30, 35, 20, 80, 100]))
//: ---
/*:
 ## #4. Check whether a binary tree is a full binary tree or not
 A full binary tree is defined as a binary tree in which all nodes have either zero
 or two child nodes. 
 */
func isFullBinaryTree(tree: Node) -> Bool {
  // Return  true, if tree doesn't have any left and right node.
  if tree.left == nil && tree.right == nil {
    return true
  }
  // Recursive call if tree has both left and right child.
  if let left = tree.left, let right = tree.right {
      return isFullBinaryTree(tree: left) && isFullBinaryTree(tree: right)
  }
  // Return flase in all other cases.
  return false
}
//print(isFullBinaryTree(tree: node1))
//:---
/*:
 ## #5.
 */
//: ---
//: # REST ALL
/*:
 ## 1. Level order tree traversal
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
// With buffer.
func levelOrderTreeTraversal(root: Node) {
  var queue = [root]
  var childCount = 0
  var nextRowCount = 1
  while !queue.isEmpty {
    let node = queue.remove(at: 0)
    print(node.value, separator: " ", terminator: " ")
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
func maxDepth(_ root: Node?) -> Int {
    guard let root = root else {
        return 0
    }
    return 1 +  [maxDepth(root.left), maxDepth(root.right)].max()!
}
//print(maxDepth(node1))
// Without buffer.
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
//: ---
//: ## 2. Inorder, preorder, postorder traversal
// Inorder - Left, Root, Right
func inorderTraversal(_ root: Node?) {
    guard let root = root else {
        return
    }
    inorderTraversal(root.left)
    print(root.value, separator: "", terminator: " ")
    inorderTraversal(root.right)
}
//print(inorderTraversal(node1))
// Preorder - Root, Left, Right
func preorderTraversal(_ root: Node?) {
    guard let root = root else {
        return
    }
    print(root.value, separator: "", terminator: " ")
    preorderTraversal(root.left)
    preorderTraversal(root.right)
}
//print(preorderTraversal(node1))
// Postorder - Left, Right, Root
func postorderTraversal(_ root: Node?) {
    guard let root = root else {
        return
    }
    postorderTraversal(root.left)
    postorderTraversal(root.right)
    print(root.value, separator: "", terminator: " ")
}
//print(postorderTraversal(node1))
//: ---
/*:
 ## 3. Implement a function to check if a tree is balanced.
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
//: ---
/*:
 ## 4. Insertion, deletion, search, search parent of a node in BST
 */
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
  
    func removeNode(value: Int) -> Bool {
        guard let nodeToRemove = findNode(value: value, root: root) else {
            return false
        }
        let parentNode = findParent(value: value, root: root)
        if parentNode == nil && nodeToRemove.left == nil && nodeToRemove.right == nil {
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
//tree.insertNode(newValue: 2)
//print(inorderTraversal(tree.root))
//tree.insertNode(newValue: -14)
//print(inorderTraversal(tree.root))
//tree.insertNode(newValue: 251)
//print(inorderTraversal(tree.root))
//tree.insertNode(newValue: 191)
//print(inorderTraversal(tree.root))
//
//let tree = Tree(node1)
//print(inorderTraversal(tree.root))
//tree.removeNode(value: 11)
//tree.removeNode(value: 51)
//tree.removeNode(value: 101)
//tree.removeNode(value: 151)
//print(inorderTraversal(tree.root))
//: ---
//: ## 5. Finding the smallest and largest values in the binary search tree.
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
//: ---
//: ## 6. Print all leaf nodes with their complete path
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
//: ---
//: ## 7. Update binary search tree with sum (starting from 0) in decending order
var sum = 0
func updateBST(root: Node?) {
  guard let root = root else {
    return
  }
  updateBST(root: root.right)
  let temp = root.value
  root.value = sum
  sum += temp
  updateBST(root: root.left)
}
//inorderTraversal(node1)
//updateBST(root: node1)
//inorderTraversal(node1)
//: ---
//: [Next](@next)
