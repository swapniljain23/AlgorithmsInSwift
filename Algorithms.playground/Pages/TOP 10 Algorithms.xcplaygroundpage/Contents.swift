//: [Previous](@previous)
//: # TOP 10 ALGORITHMS
//: ================================
//: ## SECTION I: Strings and Arrays
//: ================================
//: ### #1. Reverse an array without affecting special characters.
import Foundation
extension Character {
  func isAnAlphabet() -> Bool {
    if (self >= "A" && self <= "Z") ||
      (self >= "a" && self <= "z") {
      return true
    }
    return false
  }
}
func reverseTheString(_ string: String) -> String {
  var string = Array(string)
  var startIndex = 0
  var endIndex = string.count - 1
  while (startIndex < endIndex) {
    let startChar = string[startIndex]
    let endChar = string[endIndex]
    if (startChar.isAnAlphabet() && endChar.isAnAlphabet()) {
      // Swap here.
      string.swapAt(startIndex, endIndex)
      startIndex += 1
      endIndex -= 1
      continue
    }
    if (!startChar.isAnAlphabet()) {
      startIndex += 1
    }
    if (!endChar.isAnAlphabet()) {
      endIndex -= 1
    }
  }
  return String(string)
}
//print(reverseTheString(""))
//print(reverseTheString("Hello"))
//print(reverseTheString("!Hell*#o"))
//print(reverseTheString("Ab,c,de!$"))
//: ### #2. All Possible Palindromic Partitions.
// TODO: Will do it later.
//: ### #3. Count triplets with sum smaller than a given value.
// TODO: Need optimized solution.
func tripletsCount(array: [Int], sum: Int) -> Int {
  var tripletsCount = 0
  for i in 0..<array.count-2 {
    for j in i+1..<array.count-1 {
      for k in j+1..<array.count {
        if (array[i] + array[j] + array[k] < sum) {
          tripletsCount += 1
        }
      }
    }
  }
  return tripletsCount
}
print(tripletsCount(array: [-2, 0, 1, 3], sum: 2))
print(tripletsCount(array: [5, 1, 3, 4, 7], sum: 12))
/*:
  ### #4. Convert array into Zig-Zag fashion.
  Given an array of DISTINCT elements, rearrange the elements of array in zig-zag fashion
  in O(n) time. The converted array should be in form a < b > c < d > e < f.

    Input:  arr[] = {4, 3, 7, 8, 6, 2, 1}
    Output: arr[] = {3, 7, 4, 8, 2, 6, 1}
    Input:  arr[] =  {1, 4, 3, 2}
    Output: arr[] =  {1, 4, 2, 3}
 */
func convertArayIntoZigZag(array: [Int]) -> [Int] {
  var array = array
  for index in 0..<array.count - 1 {
    if (index % 2 == 0) {
      if (array[index] > array[index+1]) {
        array.swapAt(index, index+1)
      }
    } else {
      if (array[index] < array[index+1]) {
        array.swapAt(index, index+1)
      }
    }
  }
  return array
}
//print(convertArayIntoZigZag(array: [4, 3, 7, 8, 6, 2, 1]))
//print(convertArayIntoZigZag(array: [1, 4, 3, 2]))
/*:
 ### #5. Generate all possible sorted arrays from alternate elements of two given sorted
 ### arrays.
  Given two sorted arrays A and B, generate all possible arrays such that first element is
  taken from A then from B then from A and so on in increasing order till the arrays
  exhausted. The generated arrays should end with an element from B.

    A = {10, 15, 25}
    B = {1, 5, 20, 30}
    The resulting arrays are:
    10 20
    10 20 25 30
    10 30 // TODO:
    15 20
    15 20 25 30
    15 30 // TODO:
    25 30
 */
// TODO: Missing another use case.
func possibleSortedArrays(arrayA: [Int], arrayB: [Int]) -> [[Int]] {
  var outputArray = [[Int]]()
  for indexA in 0..<arrayA.count {
    var valueA = arrayA[indexA]
    var indexA1 = indexA
    var indexB = 0
    var resultArray = [Int]()
    while (indexB < arrayB.count) {
      var lastValA = arrayA[indexA1]
      var lastValB = arrayB[indexB]
      if (lastValA < lastValB) {
        resultArray.append(lastValA)
        resultArray.append(lastValB)
        outputArray.append(resultArray)
        indexA1 += 1
        while (indexA1 < arrayA.count && arrayA[indexA1] < arrayB[indexB]) {
          indexA1 += 1
        }
        if (indexA1 == arrayA.count) {
          break
        }
        indexB += 1
      } else {
        indexB += 1
      }
    }
  }
  return outputArray
}
//print(possibleSortedArrays(arrayA: [10, 15, 25], arrayB: [1, 5, 20, 30]))


//: [Next](@next)
