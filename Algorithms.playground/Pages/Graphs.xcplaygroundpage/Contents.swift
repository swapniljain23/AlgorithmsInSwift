import Foundation
//: [Previous](@previous)
/*:
 # Graphs Algos
 */
class Node{
    var element: Int
    var neighbours = [Node]()
    var visited = false
    init(element: Int) {
        self.element = element
    }
}
let node1 = Node(element: 1)
let node2 = Node(element: 2)
let node3 = Node(element: 3)
let node4 = Node(element: 4)
let node5 = Node(element: 5)
node1.neighbours = [node2, node3, node4]
node2.neighbours = [node1, node3]
node3.neighbours = [node1, node2, node4, node5]
node4.neighbours = [node1, node3, node5]
node5.neighbours = [node3, node4]

let nodeA = Node(element: 11)
let nodeB = Node(element: 22)
let nodeC = Node(element: 33)
let nodeD = Node(element: 44)
let nodeE = Node(element: 55)
let nodeF = Node(element: 66)
let nodeG = Node(element: 77)
let nodeH = Node(element: 88)
nodeA.neighbours = [nodeB, nodeC]
nodeB.neighbours = [nodeD, nodeE]
nodeC.neighbours = [nodeF, nodeG]
nodeE.neighbours = [nodeH, nodeF]
nodeF.neighbours = [nodeG]

/*:
 ## Search for an element in graph
 (Depth first search, with recursion)
 */
func searchAnElement(node: Node, elementToSearch: Int) -> Node?{
    node.visited = true
    if node.element == elementToSearch{
        return node
    }
    for neighbourNode in node.neighbours{
        if !neighbourNode.visited{
            if let nodeFound = searchAnElement(node: neighbourNode, elementToSearch: elementToSearch){
                return nodeFound
            }
        }
    }
    return nil
}
// Test Cases:
//print(searchAnElement(node: node1, elementToSearch: 4)?.element)
//print(searchAnElement(node: node1, elementToSearch: 6)?.element)
/*:
 ## BFS: Breadth first search/traversal
 */
func breadthFirstTraversal(_ root: Node){
    var queue = [root]
    root.visited = true
    while !queue.isEmpty{
        let node = queue.removeFirst()
        print(node.element, separator: "", terminator: " ")
        for node in node.neighbours{
            if !node.visited{
                node.visited = true
                queue.append(node)
            }
        }
    }
}
//print(breadthFirstTraversal(nodeA))
/*:
 ## DFS: Depth first search/traversal
 */
func depthFirstTraversal(_ root: Node){
    var stack = [root]
    root.visited = true
    while !stack.isEmpty{
        let node = stack.removeLast()
        print(node.element, separator: "", terminator: " ")
        for node in node.neighbours.reversed(){
            if !node.visited{
                node.visited = true
                stack.append(node)
            }
        }
    }
}
//print(depthFirstTraversal(nodeA))
//: [Next](@next)
