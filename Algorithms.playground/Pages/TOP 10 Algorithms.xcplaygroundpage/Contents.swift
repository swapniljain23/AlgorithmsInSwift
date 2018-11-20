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


//: ### #3. Count triplets with sum smaller than a given value.

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

//: [Next](@next)
