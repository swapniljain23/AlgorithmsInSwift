//: [Previous](@previous)
//: # TOP 10 ALGORITHMS
//: ---
//: ## SECTION II: Dynamic Programming
//: ---
/*:
 ## #1. Longest common subsequence
 Given two sequences, find the length of longest subsequence present in both of them.
 A subsequence is a sequence that appears in the same relative order, but not
 necessarily contiguous. For example, “abc”, “abg”, “bdf”, “aeg”, ‘”acefg”, .. etc
 are subsequences of “abcdefg”. So a string of length n has 2^n different possible
 subsequences.
 
    LCS for input Sequences “ABCDGH” and “AEDFHR” is “ADH” of length 3.
    LCS for input Sequences “AGGTAB” and “GXTXAYB” is “GTAB” of length 4.
 */
import Foundation
func longestCommonSubsequence(_ array1: [Character], _ array2: [Character]) -> Int {
  if array1.count == 0 || array2.count == 0 {
    return 0
  }
  if (array1.last == array2.last) {
    return 1 + longestCommonSubsequence(Array(array1.dropLast()),
                                        Array(array2.dropLast()))
  } else {
    return [longestCommonSubsequence(array1, Array(array2.dropLast())),
            longestCommonSubsequence(Array(array1.dropLast()), array2)].max()!
  }
}
//print(longestCommonSubsequence(["A", "B", "C", "D", "G", "H"],
//                               ["A", "E", "D", "F", "H", "R"]))
//print(longestCommonSubsequence(["A", "G", "G", "T", "A", "B"],
//                               ["G", "X", "T", "X", "A", "Y", "B"]))
//: ---
/*:
 ## #2. Longest increasing subsequence
 The longest increasing subsequence (LIS) problem is to find the length of the
 longest subsequence of a given sequence such that all elements of the subsequence
 are sorted in increasing order. For example, the length of LIS for {10, 22, 9, 33,
 21, 50, 41, 60, 80} is 6 and LIS is {10, 22, 33, 50, 60, 80}.
 
    Input  : arr[] = {3, 10, 2, 1, 20}
    Output : Length of LIS = 3, The longest increasing subsequence is 3, 10, 20.
 
    Input  : arr[] = {3, 2}
    Output : Length of LIS = 1, The longest increasing subsequences are {3} and {2}.
 
    Input : arr[] = {50, 3, 10, 7, 40, 80}
    Output : Length of LIS = 4, The longest increasing subsequence is {3, 7, 40, 80}.
 */
func longestIncreasingSubsequence(array: [Int], max: inout Int) -> Int {
  if array.count == 1 {
    return 1
  }
  let length = array.count
  var localMax = 1, result = 1
  for i in 1..<length {
    result = longestIncreasingSubsequence(array: Array(array[0..<i]), max: &max)
    if array[i-1] < array[length-1] && result + 1 > localMax {
      localMax = result + 1
    }
  }
  if max < localMax {
    max = localMax
  }
  return localMax
}
//var max = 0
//longestIncreasingSubsequence(array: [3, 10, 2, 1, 20], max: &max)
//print(max)
//max = 0
//longestIncreasingSubsequence(array: [3, 2], max: &max)
//print(max)
//max = 0
//longestIncreasingSubsequence(array: [50, 3, 10, 7, 40, 80], max: &max)
//print(max)
//max = 0
//longestIncreasingSubsequence(array: [100, 200, 300, 500, 110, 120, 130, 140],
//                               max: &max)
//print(max)
func longestNonDecreasingSequence(sequence: [Int]) -> Int {
  var longestSequence = Array(repeating: 0, count: sequence.count)
  longestSequence[0] = 1
  for index in 1..<sequence.count {
    longestSequence[index] = 1
    for innerIndex in 0..<index {
      if sequence[index] > sequence[innerIndex] &&
          longestSequence[index] < longestSequence[innerIndex] + 1 {
        longestSequence[index] = longestSequence[innerIndex] + 1
      }
    }
  }
  return longestSequence.max()!
}
//print(longestNonDecreasingSequence(sequence: [5, 3, 4, 8, 6, 7]))
//print(longestNonDecreasingSequence(sequence: [3, 10, 2, 1, 20]))
//print(longestNonDecreasingSequence(sequence: [3, 2]))
//print(longestNonDecreasingSequence(sequence: [50, 3, 10, 7, 40, 80]))
//print(longestNonDecreasingSequence(sequence: [100, 200, 300, 500, 110, 120, 130, 140]))
//: ---
/*:
 ## #3. Edit distance
 Given two strings str1 and str2 and below operations that can performed on str1.
 Find minimum number of edits (operations) required to convert ‘str1’ into ‘str2’.
 Insert, Remove, Replace.
 
    Input:   str1 = "geek", str2 = "gesek"
    Output:  1, We can convert str1 into str2 by inserting a 's'.
 
    Input:   str1 = "cat", str2 = "cut"
    Output:  1, We can convert str1 into str2 by replacing 'a' with 'u'.
 
    Input:   str1 = "sunday", str2 = "saturday"
    Output:  3, Last three and first characters are same.  We basically need to
    convert "un" to "atur". This can be done using below three operations.
    Replace 'n' with 'r', insert t, insert a.
 */
func editDistance(string1: String, string2: String) -> Int {
  let m = string1.count
  let n = string2.count
  // If first string is empty, the only option is to insert all
  // character of second string into first.
  if m == 0 { return n }
  // If second string is empty, the only option is to remove all
  // character of first string.
  if n == 0 { return m }
  // If last character of two strings are same, just ignore the
  // last character and get the count for the remaining strings.
  if string1.last! == string2.last! {
    return editDistance(string1: String(string1.dropLast()),
                        string2: String(string2.dropLast()))
  }
  // If last characters of two string are not same, consider all operations on
  // last character of first string, recursively compute the cost and take the
  // minimum of three values.
  return 1 + [editDistance(string1: string1, string2: String(string2.dropLast())),
              editDistance(string1: String(string1.dropLast()), string2: string2),
              editDistance(string1: String(string1.dropLast()),
                           string2: String(string2.dropLast()))].min()!
}
//print(editDistance(string1: "geek", string2: "gesek"))
//print(editDistance(string1: "cat", string2: "cut"))
//print(editDistance(string1: "sunday", string2: "saturday"))
//: ---
/*:
 ##  #4. Partition a set into two subsets such that the difference of subset sums is minimum
 Given a set of integers, the task is to divide it into two sets S1 and S2 such that
 the absolute difference between their sums is minimum.
 If there is a set S with n elements, then if we assume Subset1 has m elements,
 Subset2 must have n-m elements and the value of abs(sum(Subset1) – sum(Subset2))
 should be minimum.
 
    Input:  arr[] = {1, 6, 11, 5}
    Output: 1
    Explanation:
    Subset1 = {1, 5, 6}, sum of Subset1 = 12
    Subset2 = {11}, sum of Subset2 = 11
 */
// Recursive solution.
func findMinRec(array: [Int], sumCalculated: Int, sumTotal: Int) -> Int {
  if array.count == 0 {
    return abs(sumCalculated - (sumTotal - sumCalculated))
  }
  return [findMinRec(array: Array(array.dropLast()),
             sumCalculated: sumCalculated + array.last!,
                  sumTotal: sumTotal),
          findMinRec(array: Array(array.dropLast()),
             sumCalculated: sumCalculated,
                  sumTotal: sumTotal)].min()!
}
func findMinSum(array: [Int]) -> Int {
  var sumTotal = array.reduce(0) { $0 + $1 }
  return findMinRec(array: array, sumCalculated: 0, sumTotal: sumTotal)
}
//print(findMinSum(array: [1, 6, 11, 5]))
// TODO: Dynamic programming solution.
//: ---
/*:
 ## #5. Count number of ways to cover a distance
 Given a distance ‘dist, count total number of ways to cover the distance with
 1, 2 and 3 steps.
 
    Input:  n = 3
    Output: 4, Below are the four ways
    1 step + 1 step + 1 step
    1 step + 2 step
    2 step + 1 step
    3 step
 
    Input:  n = 4
    Output: 7
 */
func numberOfWaysToCoverDistance(distance: Int) -> Int {
  var countArray = Array(repeating: 0, count: distance+1)
  // Initialize base values.
  countArray[0] = 1
  countArray[1] = 1
  countArray[2] = 2
  // Fill the count array in bottom up manner.
  for index in 3...distance {
    countArray[index] =
        countArray[index-3] + countArray[index-2] + countArray[index-1]
  }
  return countArray[distance]
}
//print(numberOfWaysToCoverDistance(distance: 3))
//print(numberOfWaysToCoverDistance(distance: 4))
//print(numberOfWaysToCoverDistance(distance: 5))
//: ---
/*:
 ## #6. Find the longest path in a matrix with given constraints
 Given a n*n matrix where all numbers are distinct, find the maximum length path
 (starting from any cell) such that all cells along the path are in increasing order
 with a difference of 1.
 
    Input:  mat[][] = {{1, 2, 9}, {5, 3, 8}, {4, 6, 7}}
    Output: 4, The longest path is 6-7-8-9.
 */
func findTheLongestFromACell(i: Int, j: Int, array: [[Int]], dp: [[Int]]) -> Int {
  let n = array.count
  var dp = dp
  // Edge cases.
  if i < 0 || i >= n || j < 0 || j >= n {
    return 0
  }
  // Check if already computed.
  if dp[i][j] != -1 {
    return dp[i][j]
  }
  
  if i < n-1 && array[i+1][j] == array[i][j] + 1 {
    dp[i][j] = 1 + findTheLongestFromACell(i: i+1, j: j, array: array, dp: dp)
    return dp[i][j]
  }
  if i > 0 && array[i-1][j] == array[i][j] + 1 {
    dp[i][j] = 1 + findTheLongestFromACell(i: i-1, j: j, array: array, dp: dp)
    return dp[i][j]
  }
  if j < n-1 && array[i][j+1] == array[i][j] + 1 {
    dp[i][j] = 1 + findTheLongestFromACell(i: i, j: j+1, array: array, dp: dp)
    return dp[i][j]
  }
  if j > 0 && array[i][j-1] == array[i][j] + 1 {
    dp[i][j] = 1 + findTheLongestFromACell(i: i, j: j-1, array: array, dp: dp)
    return dp[i][j]
  }
  dp[i][j] = 1
  return dp[i][j]
}
// Return length of the longest path beginning with any cell.
func findTheLongestOverAll(array: [[Int]]) -> Int {
  let length = array.count
  var result = 1 // Initialize result.
  // Create a look up table and initialize with -1.
  var dp = Array(repeating: Array(repeating: -1, count: array.count),
                     count: array.count)
  
  // Compute longest path beginning from all cells.
  for i in 0..<length {
    for j in 0..<length {
      if dp[i][j] == -1 {
        dp[i][j] = findTheLongestFromACell(i: i, j: j, array: array, dp: dp)
      }
      result = [result, dp[i][j]].max()!
    }
  }
  return result
}
//print(findTheLongestOverAll(array: [[1, 2, 9], [5, 3, 8], [4, 6, 7]]))
//: ---
/*:
 ## #7. Subset sum problem
 
 */
//: ---
/*:
 ## #8.
 */
//: ---
/*:
 ## #9.
 */
//: ---
/*:
 ## #10.
 */
//: ---
//: # Rest All
//: ---
/*:
 ## 1. Minimum number of coins
 Given a list of N coins, their values (V1, V2, … , VN), and the total sum S. Find the minimum
 number of coins the sum of which is S (we can use as many coins of one type as we want), or report
 that it’s not possible to select coins in such a way that they sum up to S.
 */
func minimumNoOfCoins(coinValues: [Int], sum: Int) -> Int {
  var minCoinsArray = Array(repeating: Int.max, count: sum+1)
  minCoinsArray[0] = 0
  for sumValue in 1...sum {
    for coinValue in coinValues {
      if coinValue <= sumValue &&
          minCoinsArray[sumValue-coinValue] + 1 < minCoinsArray[sumValue] {
        minCoinsArray[sumValue] = minCoinsArray[sumValue-coinValue] + 1
      }
    }
  }
  //print(minCoinsArray)
  return minCoinsArray[sum]
}
//print(minimumNoOfCoins(coinValues: [1, 3, 5], sum: 11))
//: ---
/*:
 ## 2. Maximum number of Apple.
 A table composed of N x M cells, each having a certain quantity of apples, is given.
 You start from the upper-left corner. At each step you can go down or right one cell.
 Find the maximum number of apples you can collect.
 */
func maximumNoOfApples(array: [[Int]]) -> Int {
  var sum = Array(repeating: Array(repeating: 0, count: array[0].count),
                      count: array.count)
  if array.count == 0 {
    return 0
  }
  sum[0][0] = array[0][0]
  for (rowIndex, row) in array.enumerated() {
    for (columnIndex, cell) in row.enumerated() {
      var leftToRight = 0, topToBottom = 0
      if rowIndex > 0 {
        topToBottom = sum[rowIndex-1][columnIndex]
      }
      if columnIndex > 0 {
        leftToRight = sum[rowIndex][columnIndex-1]
      }
      sum[rowIndex][columnIndex] = cell + ([leftToRight, topToBottom]).max()!
    }
  }
  return sum[array.count-1][array[0].count-1]
}
//print(maximumNoOfApples(array: [[1, 2, 3], [4, 5, 6], [7, 8, 9]]))
//print(maximumNoOfApples(array: [[1, 2], [4, 5], [7, 8]]))
//: ---
/*:
 ## 3. Given a 2d array of characters and a word, find the number of occurance of word in array
 Any adjacent element can be picked from 2d array to form the word.
 */
//: ---
//: [Next](@next)
