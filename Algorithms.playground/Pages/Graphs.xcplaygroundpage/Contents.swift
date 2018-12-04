//: [Previous](@previous)
//: # TOP 10 ALGORITHMS
//: ---
//: ## SECTION V: Graphs
//: ---
//: ## Data Structure
import Foundation
class Node {
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
//: ---
//: ## #1. BFS: Breadth first search/traversal
func breadthFirstTraversal(_ root: Node) {
    var queue = [root]
    root.visited = true
    while !queue.isEmpty {
        let node = queue.removeFirst()
        print(node.element, separator: "", terminator: " ")
        for node in node.neighbours {
            if !node.visited {
                node.visited = true
                queue.append(node)
            }
        }
    }
}
//print(breadthFirstTraversal(nodeA))
//: ---
//: ## #2. DFS: Depth first search/traversal
func depthFirstTraversal(_ root: Node) {
    var stack = [root]
    root.visited = true
    while !stack.isEmpty {
        let node = stack.removeLast()
        print(node.element, separator: "", terminator: " ")
        for node in node.neighbours.reversed() {
            if !node.visited {
                node.visited = true
                stack.append(node)
            }
        }
    }
}
//print(depthFirstTraversal(nodeA))
//: ---
/*: ## #3. Shortest Path from source to all vertices (Dijkstra)
 Given a graph and a source vertex in the graph, find shortest paths from source to
 all vertices in the given graph.
*/
func dijkstra(graph: [[Int]], source: Int) -> [Int] {
  // The outout array, distance[i] will hold the shortest distance from source to i.
  var distance = Array(repeating: Int.max, count: graph.count)
  // shortestPathTree[i] will be true if vertex i is included in shortest path tree
  // or shortest distance from source to i is finalized.
  var shortestPathTree = Array(repeating: false, count: graph.count)
  // Distance of source vertex from itself is always 0.
  distance[source] = 0
  // Find shortest path for all vertices.
  for _ in 0..<graph.count {
    // Pick the minimum distance vertex from the set of vertices not yet processed.
    let mininumDistanceIndex = minimumDistance(distance, shortestPathTree)
    // Mark the picked vertex as processed.
    shortestPathTree[mininumDistanceIndex] = true
    // Update distance value of the adjacent vertices of the picked vertex.
    for indexV in 0..<graph.count {
      // Update distance[indexV] only if its not in shortestPathTree, there is an
      // edge from indexU to indexV, and total weight of path from source to indexV
      // through indexU is smaller than the current value of distance[indexV].
      if !shortestPathTree[indexV] &&
          graph[mininumDistanceIndex][indexV] != 0 &&
          distance[mininumDistanceIndex] != Int.max &&
          distance[mininumDistanceIndex] + graph[mininumDistanceIndex][indexV] <
              distance[indexV] {
        distance[indexV] = distance[mininumDistanceIndex] +
            graph[mininumDistanceIndex][indexV]
      }
    }
  }
  return distance
}
// A utility function to find out the vertex with the minimum distance value
// from the set of vertices which is not yet included in shortest path tree.
func minimumDistance(_ distance: [Int], _ shortestPathTree: [Bool]) -> Int {
  var minimumValue = Int.max
  var minimumIndex = 0
  for (index, value) in distance.enumerated() {
    if value < minimumValue && !shortestPathTree[index] {
      minimumValue = value
      minimumIndex = index
    }
  }
  return minimumIndex
}
//var graph = [[0, 4, 0, 0, 0, 0, 0, 8, 0],
//             [4, 0, 8, 0, 0, 0, 0, 11, 0],
//             [0, 8, 0, 7, 0, 4, 0, 0, 2],
//             [0, 0, 7, 0, 9, 14, 0, 0, 0],
//             [0, 0, 0, 9, 0, 10, 0, 0, 0],
//             [0, 0, 4, 14, 10, 0, 2, 0, 0],
//             [0, 0, 0, 0, 0, 2, 0, 1, 6],
//             [8, 11, 0, 0, 0, 0, 1, 0, 7],
//             [0, 0, 2, 0, 0, 0, 6, 7, 0]]
//print(dijkstra(graph: graph, source: 0))
//: ---
/*:
 ## #4.
 */
//: ---
/*:
 ## #5.
 */
//: ---
/*:
 ## General Properties of Spanning Tree
 * A connected graph G can have more than one spanning tree.
 * All possible spanning trees of graph G, have the same number of edges and vertices.
 * The spanning tree does not have any cycle (loops).
 * Removing one edge from the spanning tree will make the graph disconnected, i.e. the spanning tree
   is minimally connected.
 * Adding one edge to the spanning tree will create a circuit or loop, i.e. the spanning tree is
   maximally acyclic.
 ## Mathematical Properties of Spanning Tree
 * Spanning tree has n-1 edges, where n is the number of nodes (vertices).
 * From a complete graph, by removing maximum e - n + 1 edges, we can construct a spanning tree.
 * A complete graph can have maximum n^n-2 number of spanning trees.
 */
//: ---
/*:
 ## #6. Prim’s Minimum Spanning Tree (MST)
 */
func primMinSpanningTree(graph: [[Int]]) -> [Int] {
  // Array to store constructed MST.
  var parent = Array(repeating: 0, count: graph.count)
  // Key values used to pick minimum weight edge in cut.
  var key = Array(repeating: Int.max, count: graph.count)
  // To represent set of vertices not yet included in MST.
  var minSpanningTree = Array(repeating: false, count: graph.count)
  
  // Always include first vertex in MST.
  key[0] = 0
  parent[0] = -1 // First node is alwasy root of MST.
  
  // The MST will have V vertices, where V = graph.count
  for _ in 0..<graph.count-1 {
    // Pick the minimum key vertex from the set of vertices not yet included in MST.
    let minIndexU = minimumDistance(key, minSpanningTree)
    // Add the picked vertex to the MST.
    minSpanningTree[minIndexU] = true
    // Update key value and parent index of the adjacent vertices of the picked vertex.
    // Consider only those vertices which are not yet included in MST.
    for indexV in 0..<graph.count {
      // graph[minIndexU][indexV] is non zero only for adjacent vertices of m.
      // mstSet[indexV] is false for vertices not yet included in MST.
      // Update the key only if graph[minIndexU][indexV] is smaller than key[indexV].
      if graph[minIndexU][indexV] != 0 &&
          !minSpanningTree[indexV] &&
          graph[minIndexU][indexV] <  key[indexV] {
        key[indexV] = graph[minIndexU][indexV]
        parent[indexV] = minIndexU
      }
    }
  }
  return key
}
let graph = [[0, 2, 0, 6, 0],
             [2, 0, 3, 8, 5],
             [0, 3, 0, 0, 7],
             [6, 8, 0, 0, 9],
             [0, 5, 7, 9, 0]]
print(primMinSpanningTree(graph: graph))
//: ---
//: # Rest All
//: ---
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
//: [Next](@next)
