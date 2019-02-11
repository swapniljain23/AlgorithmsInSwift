//: [Previous](@previous)
//: # TOP 10 ALGORITHMS
//: ---
//: ## SECTION I: Strings and Arrays
//: ---
/*:
 ## #1. Reverse an array without affecting special characters
 Given a string, that contains special character together with alphabets (‘a’ to ‘z’
 and ‘A’ to ‘Z’), reverse the string in a way that special characters are not
 affected.
 
    Input:   str = "a,b$c"
    Output:  str = "c,b$a"
 
    Input:   str = "Ab,c,de!$"
    Output:  str = "ed,c,bA!$"
 */
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
// O(n)
func reverseTheString(_ string: String) -> String {
  var string = Array(string)
  var startIndex = 0
  var endIndex = string.count - 1
  while startIndex < endIndex {
    let startChar = string[startIndex]
    let endChar = string[endIndex]
    // Swap characters when both are alphabets and continue.
    if startChar.isAnAlphabet() && endChar.isAnAlphabet() {
      // Swap here.
      string.swapAt(startIndex, endIndex)
      startIndex += 1
      endIndex -= 1
      continue
    }
    // Move startIndex by +1 if startChar is not an alphabet.
    if !startChar.isAnAlphabet() {
      startIndex += 1
    }
    // Move endIndex by -1 if endChar is not an alphabet.
    if !endChar.isAnAlphabet() {
      endIndex -= 1
    }
  }
  return String(string)
}
//print(reverseTheString(""))
//print(reverseTheString("Hello"))
//print(reverseTheString("!Hell*#o"))
//print(reverseTheString("Ab,c,de!$"))
//: ---
//: ## #2. All possible palindromic partitions
// TODO: Will do it later.
//: ---
/*:
 ## #3. Count triplets with sum smaller than a given value
 Given an array of distinct integers and a sum value. Find count of triplets with sum
 smaller than given sum value. Expected Time Complexity is O(n^2).
 
    Input: arr[] = {-2, 0, 1, 3}, sum = 2.
    Output: 2

    Input: arr[] = {5, 1, 3, 4, 7}, sum = 12.
    Output: 4
 */
// O(n^2)
func tripletsCount(array: [Int], sum: Int) -> Int {
  var array = array.sorted()
  var tripletsCount = 0
  for i in 0..<array.count-2 {
    var j = i + 1, k = array.count - 1
    while j < k {
      if array[i] + array[j] + array[k] >= sum {
        k -= 1
      } else {
        tripletsCount += (k - j)
        j += 1
      }
    }
  }
  return tripletsCount
}
//print(tripletsCount(array: [-2, 0, 1, 3], sum: 2))
//print(tripletsCount(array: [5, 1, 3, 4, 7], sum: 12))
//: ---
/*:
 ## #4. Convert array into Zig-Zag fashion
 Given an array of DISTINCT elements, rearrange the elements of array in zig-zag
 fashion in O(n) time. The converted array should be in form a < b > c < d > e < f.

    Input:  arr[] = {4, 3, 7, 8, 6, 2, 1}
    Output: arr[] = {3, 7, 4, 8, 2, 6, 1}
 
    Input:  arr[] =  {1, 4, 3, 2}
    Output: arr[] =  {1, 4, 2, 3}
 */
// O(n)
func convertArayIntoZigZag(array: [Int]) -> [Int] {
  var array = array
  for index in 0..<array.count - 1 {
    // Check for the operator '<' or '>'.
    if index % 2 == 0 {
      if array[index] > array[index+1] {
        array.swapAt(index, index+1)
      }
    } else {
      if array[index] < array[index+1] {
        array.swapAt(index, index+1)
      }
    }
  }
  return array
}
//print(convertArayIntoZigZag(array: [4, 3, 7, 8, 6, 2, 1]))
//print(convertArayIntoZigZag(array: [1, 4, 3, 2]))
//: ---
/*:
 ## #5. Generate all possible sorted arrays from alternate elements of two given sorted arrays
 Given two sorted arrays A and B, generate all possible arrays such that first
 element is taken from A then from B then from A and so on in increasing order till
 the arrays exhausted. The generated arrays should end with an element from B.

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
    var indexA1 = indexA
    var indexB = 0
    var resultArray = [Int]()
    while indexB < arrayB.count {
      let lastValA = arrayA[indexA1]
      let lastValB = arrayB[indexB]
      if lastValA < lastValB {
        resultArray.append(lastValA)
        resultArray.append(lastValB)
        outputArray.append(resultArray)
        indexA1 += 1
        while indexA1 < arrayA.count && arrayA[indexA1] < arrayB[indexB] {
          indexA1 += 1
        }
        if indexA1 == arrayA.count {
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
//: ---
/*:
 ## #6. Pythagorean triplet in an array
 Given an array of integers, write a function that returns true if there is a
 triplet (a, b, c) that satisfies a^2 + b^2 = c^2.
    
    Input: arr[] = {3, 1, 4, 6, 5}
    Output: True
    There is a Pythagorean triplet (3, 4, 5).

    Input: arr[] = {10, 4, 6, 12, 5}
    Output: False
    There is no Pythagorean triplet.
*/
func hasPythagoreanTriplet(array: [Int]) -> Bool {
  var newArray = [Int]()
  
  // Step 1: Create a new array with square of each element. O(n)
  for item in array {
    newArray.append(item * item)
  }
  
  // Step 2: Sort the array. O(nLog(n))
  newArray.sort()
  
  // Step 3: Meet in middle. O(n^2)
  var indexA = newArray.count - 1
  while indexA >= 2 {
    var indexB = 0, indexC = indexA - 1
    while indexB < indexC {
      if newArray[indexB] + newArray[indexC] ==  newArray[indexA] {
        return true
      } else if newArray[indexB] + newArray[indexC] > newArray[indexA] {
        indexC -= 1
      } else {
        indexB += 1
      }
    }
    indexA -= 1
  }
  return false
}
//print(hasPythagoreanTriplet(array: [3, 1, 4, 6, 5]))
//print(hasPythagoreanTriplet(array: [10, 4, 6, 12, 5]))
//: ---
/*:
 ## #7. Length of the largest subarray with contiguous elements
 Given an array of distinct integers, find length of the longest subarray which
 contains numbers that can be arranged in a continuous sequence.
 
    Input:  arr[] = {10, 12, 11};
    Output: Length of the longest contiguous subarray is 3
 
    Input:  arr[] = {14, 12, 11, 20};
    Output: Length of the longest contiguous subarray is 2
 
    Input:  arr[] = {1, 56, 58, 57, 90, 92, 94, 93, 91, 45};
    Output: Length of the longest contiguous subarray is 5
 */
// O(n^2)
func lenghtOfLongestContiguousSubarray(inArray array: [Int]) -> Int {
  var maxLength = 1
  for outerIndex in 0..<array.count-1 {
    // Set minVal, maxVal to the value in the outerIndex.
    var minVal = array[outerIndex]
    var maxVal = array[outerIndex]
    for innerIndex in outerIndex+1..<array.count {
      // Update minVal, maxVal.
      minVal = [minVal, array[innerIndex]].min()!
      maxVal = [maxVal, array[innerIndex]].max()!
      if maxVal - minVal == innerIndex - outerIndex {
        // Update maxLength.
        maxLength = [maxLength, maxVal - minVal + 1].max()!
      }
    }
  }
  return maxLength
}
//print(lenghtOfLongestContiguousSubarray(inArray: [10, 12, 11]))
//print(lenghtOfLongestContiguousSubarray(inArray: [14, 12, 11, 20]))
//print(lenghtOfLongestContiguousSubarray(inArray:
//    [1, 56, 58, 57, 90, 92, 94, 93, 91, 45]))
//: ---
/*:
 ## #8. Find the smallest positive integer value that cannot be represented as sum of any subset of a given array
 Given a sorted array (sorted in non-decreasing order) of positive numbers, find the
 smallest positive integer value that cannot be represented as sum of elements of any
 subset of given set.
 Expected time complexity is O(n).
 
    Input:  arr[] = {1, 3, 6, 10, 11, 15};
    Output: 2
    Input:  arr[] = {1, 1, 1, 1};
    Output: 5
    Input:  arr[] = {1, 1, 3, 4};
    Output: 10
    Input:  arr[] = {1, 2, 5, 10, 20, 40};
    Output: 4
    Input:  arr[] = {1, 2, 3, 4, 5, 6};
    Output: 22
 */
// O(n)
func smallestPositiveInteger(inArray array: [Int]) -> Int {
  var smallestInt = 1
  for item in array where item <= smallestInt {
    smallestInt += item
  }
  return smallestInt
}
//print(smallestPositiveInteger(inArray: [1, 3, 6, 10, 11, 15]))
//print(smallestPositiveInteger(inArray: [1, 1, 1, 1]))
//print(smallestPositiveInteger(inArray: [1, 1, 3, 4]))
//print(smallestPositiveInteger(inArray: [1, 2, 5, 10, 20, 40]))
//print(smallestPositiveInteger(inArray: [1, 2, 3, 4, 5, 6]))
//: ---
/*:
 ## #9. Smallest subarray with sum greater than a given value
 Given an array of integers and a number x, find the smallest subarray with sum
 greater than the given value.
 
    Input: arr[] = {1, 4, 45, 6, 0, 19}, x  =  51
    Output: 3, Minimum length subarray is {4, 45, 6}
 
    Input: arr[] = {1, 10, 5, 2, 7}, x = 9
    Output: 1, Minimum length subarray is {10}
 
    Input: arr[] = {1, 11, 100, 1, 0, 200, 3, 2, 1, 250}, x = 280
    Output: 4, Minimum length subarray is {100, 1, 0, 200}
 
    Input: arr[] = {1, 2, 4}, x = 8
    Output : Not Possible, Whole array sum is smaller than 8.
 */
// O(n^2)
func smallestSubarray(ofArray array: [Int], withSumGreaterThan sum: Int) -> Int {
  var subarrayCount = array.count + 1
  for outerIndex in 0..<array.count {
    // Initiazlie item and current subarray sum with the value
    // at current outerIndex.
    let item = array[outerIndex]
    var subarraySum = item
    for innerIndex in outerIndex+1..<array.count {
      if subarraySum > sum {
        if innerIndex - outerIndex < subarrayCount {
          subarrayCount = innerIndex - outerIndex
        }
        break
      }
      // Keep updating subarray sum.
      subarraySum += array[innerIndex]
    }
  }
  return subarrayCount > array.count ? -1 : subarrayCount
}
//print(smallestSubarray(ofArray: [1, 4, 45, 6, 0, 19], withSumGreaterThan: 51))
//print(smallestSubarray(ofArray: [1, 10, 5, 2, 7], withSumGreaterThan: 9))
//print(smallestSubarray(ofArray: [1, 11, 100, 1, 0, 200, 3, 2, 1, 250],
//            withSumGreaterThan: 280))
//print(smallestSubarray(ofArray: [1, 2, 4], withSumGreaterThan: 8))
// O(n)
func smallestSubWithSum(array: [Int], sum: Int) -> Int {
  var currentSum = 0, minLength = array.count + 1
  var start = 0, end = 0
  while end < array.count {
    // Keep adding array items while current sum is smaller than the given sum.
    while currentSum <= sum && end < array.count {
      currentSum += array[end]
      end += 1
    }
    // Keep removing start items until current sum becomes smaller than the given
    // sum.
    while currentSum > sum && start < array.count {
      // Update min length if needed.
      if end - start < minLength {
        minLength = end - start
      }
      // Remove starting elements.
      currentSum -= array[start]
      start += 1
    }
  }
  return minLength > array.count ? -1 : minLength
}
//print(smallestSubWithSum(array: [1, 4, 45, 6, 0, 19], sum: 51))
//print(smallestSubWithSum(array: [1, 10, 5, 2, 7], sum: 9))
//print(smallestSubWithSum(array: [1, 11, 100, 1, 0, 200, 3, 2, 1, 250], sum: 280))
//print(smallestSubWithSum(array: [1, 2, 4], sum: 8))
//: ---
/*:
 ## #10. Stock buy sell to maximize profit
 The cost of a stock on each day is given in an array, find the max profit that you can make by
 buying and selling in those days. For example, if the given array is {100, 180, 260, 310, 40, 535,
 695}, the maximum profit can earned by buying on day 0, selling on day 3. Again buy on day 4 and
 sell on day 6.
 */
// O(n)
struct Index {
  var buy: Int
  var sell: Int
}
func stockBuySell(stocks: [Int]) -> [Index] {
  var solution = [Index]()
  var i = 0, n = stocks.count
  while i < stocks.count - 1 {
    // Find the local minima.
    while i < n-1 && stocks[i+1] <= stocks[i] {
      i += 1
    }
    if i == n-1 {
      break
    }
    let buyIndex = i
    i += 1
    // Find the local maxima.
    while i < n && stocks[i] >= stocks[i-1] {
      i += 1
    }
    let sellIndex = i-1
    solution.append(Index(buy: buyIndex, sell: sellIndex))
  }
  return solution
}
//print(stockBuySell(stocks: [100, 180, 260, 310, 40, 535, 695]))
//: ---
//: [Next](@next)
