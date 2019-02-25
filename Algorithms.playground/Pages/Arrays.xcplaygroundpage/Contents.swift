//: [Previous](@previous)
/*:
 ---
 # Arrays
 ---
*/
/*:
 ## 1. Check if sum of any two elements in an array is equal to n.
 
    Input: An array of Int, a number Int.
    Output: true/false
 */
import Foundation
func isSumOfAnyTwoElementIsEqualToN(_ anArray: [Int], _ n: Int) -> Bool {
    var aSet = Set<Int>()
    for index in 0..<anArray.count {
        let diffVal = n - anArray[index]
        if aSet.contains(diffVal){
            return true
        }
        aSet.insert(anArray[index])
    }
    return false
}
//let arrayOne = [2, 4, 8, 18, 13, 9, 15]
//print(isSumOfAnyTwoElementIsEqualToN(arrayOne, 10))
//print(isSumOfAnyTwoElementIsEqualToN(arrayOne, 9))
//: ---
/*:
 ## 2. Skip multiplication in factorial
 
    Input: 3
    Output: [6, 3, 2]
 
 Algo:\
 6 = ~1~ * 2 * 3 (skip multiplication by value at index 0)\
 3 = 1 * ~2~ * 3 (skip multiplication by value at index 1)\
 2 = 1 * 2 * ~3~ (skip multiplication by value at index 2)\
 Time complexity: O(n)
 */
func products(number: Int) -> [Int] {
    var outputArray = Array(repeating: 1, count: number)
    let multipleValue = factorial(number)
    for index in 1...number {
        outputArray[index-1] = multipleValue / index
    }
    return outputArray
}
func factorial(_ number: Int) -> Int {
    return number == 1 ?  1 : number * factorial(number-1)
}
//print(products(number: 1))
//print(products(number: 2))
//print(products(number: 3))
//print(products(number: 4))
//print(products(number: 5))
//: ---
/*:
 ## 3. Rotate an array by Delta (with buffer array)
 
    Input: [1, 4, 7, 3, 2, 9], 3
    Output: [3, 2, 9, 1, 4, 7]
 */
func rotateArrayByDelta(array: [Int], delta: Int) -> [Int] {
    var newDelta = delta
    if delta >= array.count {
        newDelta = delta % array.count
    }
    var outputArray = [Int]()
    var arrayIndex = newDelta
    for index in 0..<array.count {
        if index+newDelta == array.count {
            arrayIndex = 0
        }
        outputArray.append(array[arrayIndex])
        arrayIndex += 1
    }
    return outputArray
}
//print(rotateArrayByDelta(array: [1, 4, 7, 3, 2, 9], delta: 5))
//: ---
/*:
 ## 4. Rotate an array by Delta (without buffer array)
 
    Input: [1, 4, 7, 3, 2, 9], 4
    Output: [ 2, 9, 1, 4, 7, 3]
 */
func rotateArrayByDeltaWithNoBuffer(array: [Int], delta: Int) -> [Int] {
    var array = array
    var newDelta = delta
    if delta >= array.count {
        newDelta = delta % array.count
    }
    // Reverse the first half
    for index in 0..<newDelta/2 {
        (array[index], array[newDelta-1-index]) =
            (array[newDelta-1-index], array[index])
    }
    // Reverse the second half
    for index in newDelta..<newDelta+((array.count-newDelta)/2) {
        (array[index], array[array.count-1-(index-newDelta)]) =
            (array[array.count-1-(index-newDelta)], array[index])
    }
    // Revese the whole array and return
    return array.reversed()
}
//let array = [1, 4, 7, 3, 2, 9]
//print(rotateArrayByDeltaWithNoBuffer(array: array, delta: 0))
//print(rotateArrayByDeltaWithNoBuffer(array: array, delta: 1))
//print(rotateArrayByDeltaWithNoBuffer(array: array, delta: 2))
//print(rotateArrayByDeltaWithNoBuffer(array: array, delta: 3))
//print(rotateArrayByDeltaWithNoBuffer(array: array, delta: 4))
//print(rotateArrayByDeltaWithNoBuffer(array: array, delta: 5))
//print(rotateArrayByDeltaWithNoBuffer(array: array, delta: 6))
//: ---
/*:
 ## 5. Reverse partial range in an array
 
    Input: [1, 4, 7, 3, 2, 9], 1, 4
    Output: [1, 2, 3, 7, 4, 9]
 */
func reverseSubArray(array: [Int], startIndex: Int, endIndex: Int) -> [Int] {
    var startIndex = startIndex
    var endIndex = endIndex
    var array = array
    if startIndex >= array.count-1 ||
      startIndex < 0 ||
      endIndex <= 0 ||
      endIndex > array.count-1 ||
      startIndex >= endIndex {
        return array
    }
    while startIndex < endIndex {
        (array[startIndex], array[endIndex]) = (array[endIndex], array[startIndex])
        startIndex += 1
        endIndex -= 1
    }
    return array
}
//let array = [1, 4, 7, 3, 2, 9]
//print(reverseSubArray(array: array, startIndex: 0, endIndex: 2))
//: ---
//: ## 6. Generate 2D Spiral array
func generate2dSpiralArray(length: Int) -> [[Int]] {
  var spiralArr = Array(repeating: Array(repeating: 0, count: length),
                            count: length)
  guard length > 0 else {
    return spiralArr
  }
  var row = 0, column = 0
  var dr = [0, 1, 0, -1]
  var dc = [1, 0, -1, 0]
  var dir = 0
  var value = 1, limit = length * length
  while (value <= limit) {
    spiralArr[row][column] = value
    row += dr[dir]
    column += dc[dir]
    if (isInvalid(spiralArr: spiralArr, row: row, column: column)) {
      row -= dr[dir]
      column -= dc[dir]
      dir = (dir + 1) % 4
      row += dr[dir]
      column += dc[dir]
    }
    value += 1
  }
  return spiralArr
}
func isInvalid(spiralArr: [[Int]], row: Int, column: Int) -> Bool {
  return row < 0 ||
      column < 0 ||
      row >= spiralArr.count ||
      column >= spiralArr.count ||
      spiralArr [row][column] != 0
}
func print2dArray(_ array: [[Int]]) {
  for row in array {
    for item in row {
      print(item, separator: " ", terminator: " ")
    }
    print("")
  }
}
//print2dArray(generate2dSpiralArray(length: 1))
//print2dArray(generate2dSpiralArray(length: 2))
//print2dArray(generate2dSpiralArray(length: 3))
//print2dArray(generate2dSpiralArray(length: 4))
//print2dArray(generate2dSpiralArray(length: 5))
//: ---
/*:
 ## 7. Given an array of sorted integers, return the array of integers squared still sorted
 
    [1,2,3] -> [1,4,9]
    [-1, 0, 1] -> [0, 1, 1]
    [-5, -3, 1, 2, 7] -> [1, 4, 9, 25, 49]
    [-8, -5, -2, 0, 3, 4, 7] -> [0, 4, 9, 16, 25, 49, 64]
*/
func squaredSortedArray(_ array: [Int]) -> [Int] {
  var squaredSortedArray = [Int]()
  
  // Find the index for the last negative value in the given array.
  var midIndex = 0
  while array[midIndex] < 0 {
    midIndex += 1
  }
  
  // Assign the last negative value index to leftIndex and first positive value
  // index to rightIndex.
  var leftIndex = midIndex
  var rightIndex = midIndex + 1
  
  // Pick elements from either left or right side of mid index and insert
  // their square in output array.
  while leftIndex >= 0 && rightIndex < array.count {
    if array[leftIndex] * array[leftIndex] < array[rightIndex] * array[rightIndex] {
      squaredSortedArray.append(array[leftIndex] * array[leftIndex])
      leftIndex -= 1
    } else {
      squaredSortedArray.append(array[rightIndex] * array[rightIndex])
      rightIndex += 1
    }
  }
  
  while leftIndex >= 0 {
    squaredSortedArray.append(array[leftIndex] * array[leftIndex])
    leftIndex -= 1
  }
  while rightIndex < array.count {
    squaredSortedArray.append(array[rightIndex] * array[rightIndex])
    rightIndex += 1
  }
  
  return squaredSortedArray
}
//print(squaredSortedArray([1, 2, 3]))
//print(squaredSortedArray([-1, 0, 1]))
//print(squaredSortedArray([-5, -3, 1, 2, 7]))
//print(squaredSortedArray([-5, -3, 1, 2]))
//print(squaredSortedArray([-5, -3, 1, 2, 5]))
//print(squaredSortedArray([-8, -5, -2, 0, 3, 4, 7]))
//:---
/*
 ## 8. kTh most frequent
 */
//:---
/*:
 ## 9. Calculate the minimum distance for each cell of N*N matrix from the given special cells
 Given matrix is filled with Int.max except special cells which contains 0.
 */
func calculateMinDistance(array: [[Int]]) -> [[Int]] {
  var array = array
  for (rowIndex, rowArray) in array.enumerated() {
    for (columnIndex, cellValue) in rowArray.enumerated() {
      if cellValue == 0 {
        // Special cell.
        fillUpperLeft(array: &array, cellIndex: (rowIndex, columnIndex), distance: 0)
        fillUpperRight(array: &array, cellIndex: (rowIndex, columnIndex), distance: 0)
        fillLowerLeft(array: &array, cellIndex: (rowIndex, columnIndex), distance: 0)
        fillLowerRight(array: &array, cellIndex: (rowIndex, columnIndex), distance: 0)
      }
    }
  }
  return array
}
func fillUpperLeft(array: inout [[Int]], cellIndex: (Int, Int), distance: Int) {
  if cellIndex.0 < 0 ||
      cellIndex.0 >= array.count ||
      cellIndex.1 < 0 ||
      cellIndex.1 >= array.count {
    return
  }
  if array[cellIndex.0][cellIndex.1] != 0 && array[cellIndex.0][cellIndex.1] > distance {
    array[cellIndex.0][cellIndex.1] = distance
  }
  fillUpperLeft(array: &array, cellIndex: (cellIndex.0 - 1, cellIndex.1), distance: distance + 1)
  fillUpperLeft(array: &array, cellIndex: (cellIndex.0, cellIndex.1 - 1), distance: distance + 1)
  fillUpperLeft(array: &array,
            cellIndex: (cellIndex.0 - 1, cellIndex.1 - 1),
             distance: distance + 2)
}
func fillUpperRight(array: inout [[Int]], cellIndex: (Int, Int), distance: Int) {
  if cellIndex.0 < 0 ||
    cellIndex.0 >= array.count ||
    cellIndex.1 < 0 ||
    cellIndex.1 >= array.count {
    return
  }
  if array[cellIndex.0][cellIndex.1] != 0 && array[cellIndex.0][cellIndex.1] > distance {
    array[cellIndex.0][cellIndex.1] = distance
  }
  fillUpperRight(array: &array, cellIndex: (cellIndex.0 - 1, cellIndex.1), distance: distance + 1)
  fillUpperRight(array: &array, cellIndex: (cellIndex.0, cellIndex.1 + 1), distance: distance + 1)
  fillUpperRight(array: &array,
             cellIndex: (cellIndex.0 - 1, cellIndex.1 + 1),
              distance: distance + 2)
}
func fillLowerLeft(array: inout [[Int]], cellIndex: (Int, Int), distance: Int) {
  if cellIndex.0 < 0 ||
    cellIndex.0 >= array.count ||
    cellIndex.1 < 0 ||
    cellIndex.1 >= array.count {
    return
  }
  if array[cellIndex.0][cellIndex.1] != 0 && array[cellIndex.0][cellIndex.1] > distance {
    array[cellIndex.0][cellIndex.1] = distance
  }
  fillLowerLeft(array: &array, cellIndex: (cellIndex.0 + 1, cellIndex.1), distance: distance + 1)
  fillLowerLeft(array: &array, cellIndex: (cellIndex.0, cellIndex.1 - 1), distance: distance + 1)
  fillLowerLeft(array: &array,
            cellIndex: (cellIndex.0 + 1, cellIndex.1 - 1),
             distance: distance + 2)
}
func fillLowerRight(array: inout [[Int]], cellIndex: (Int, Int), distance: Int) {
  if cellIndex.0 < 0 ||
    cellIndex.0 >= array.count ||
    cellIndex.1 < 0 ||
    cellIndex.1 >= array.count {
    return
  }
  if array[cellIndex.0][cellIndex.1] != 0 && array[cellIndex.0][cellIndex.1] > distance {
    array[cellIndex.0][cellIndex.1] = distance
  }
  fillLowerRight(array: &array, cellIndex: (cellIndex.0 + 1, cellIndex.1), distance: distance + 1)
  fillLowerRight(array: &array, cellIndex: (cellIndex.0, cellIndex.1 + 1), distance: distance + 1)
  fillLowerRight(array: &array,
             cellIndex: (cellIndex.0 + 1, cellIndex.1 + 1),
              distance: distance + 2)
}
//print(calculateMinDistance(array: [[0, Int.max, Int.max, Int.max],
//                                   [Int.max, Int.max, Int.max, Int.max],
//                                   [Int.max, Int.max, 0, Int.max],
//                                   [Int.max, Int.max, Int.max, Int.max]]))
//:---
//: [Next](@next)
