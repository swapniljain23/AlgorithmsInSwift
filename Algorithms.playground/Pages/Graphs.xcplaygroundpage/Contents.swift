import Foundation
//: [Previous](@previous)
/*:
 # Graphs Algos
 */
/*:
 ## Search for an element in graph
 */

class Node{
    var element: Int
    var neighbours = [Node]()
    var visited = false
    init(element: Int) {
        self.element = element
    }
}
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
//let node1 = Node(element: 1)
//let node2 = Node(element: 2)
//let node3 = Node(element: 3)
//let node4 = Node(element: 4)
//let node5 = Node(element: 5)
//node1.neighbours = [node2, node3, node4]
//node2.neighbours = [node1, node3]
//node3.neighbours = [node1, node2, node4, node5]
//node4.neighbours = [node1, node3, node5]
//node5.neighbours = [node3, node4]
//print(searchAnElement(node: node1, elementToSearch: 4)?.element)
//print(searchAnElement(node: node1, elementToSearch: 6)?.element)

//: [Next](@next)
