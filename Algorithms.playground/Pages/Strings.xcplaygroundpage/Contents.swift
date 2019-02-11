//: [Previous](@previous)
/*:
 ---
 # Strings
 ---
 */
//: ## Sting extension
import Foundation
extension String {
    var asciiValue: [UInt32] {
        return self.unicodeScalars.filter{$0.isASCII}.map{$0.value}
    }
}
//: ## Character extension
extension Character {
    var asciiValue: UInt32? {
        return String(self).unicodeScalars.filter{$0.isASCII}.first?.value
    }
}
//: ## Substring
func getSubstringFromString(sourceString: String, beforeString str: String) -> String {
    if let range = sourceString.range(of: str) {
        return String(sourceString[..<range.lowerBound])
    }
    return ""
}
func getSubstringAfterString(sourceString: String, afterString str: String) -> String {
    if let range = sourceString.range(of: str) {
        return
          String(sourceString[range.upperBound...sourceString.index(before: sourceString.endIndex)])
    }
    return ""
}
//print(getSubstringFromString(sourceString: "Swapnil:Jain", beforeString: "Jain"))
//print(getSubstringAfterString(sourceString: "Swapnil:Jain", afterString: "Ja"))
//: ---
//: ## 1. Check if the string has all unique characters
// Approach I: ASCII (limit 256)
func hasAllUniqueChars(string: String) -> Bool {
    if string.count > 256 {
        return false
    }
    var arr = [Bool](repeating: false, count: 256)
    for char in string {
        let scalar = String(char).unicodeScalars
        if arr[Int(scalar[scalar.startIndex].value)] {
            return false
        }
        arr[Int(scalar[scalar.startIndex].value)] = true
    }
    return true
}
//print(hasAllUniqueChars(string: "Arihant"))
// Approach II:
// Use bit vector
// Approach III:
// Sort the string (n log n) and then check linearly
// Approach IV:
// Check every char of the string with every other char O(n^2)
//: ---
//: ## 2. Reverse the string
//: Approach I
func reverseStringInPlace(string: String) -> String {
    guard string.count > 1 else {
        return string
    }
    var newString = Array(string)
    let maxIndex = newString.count - 1
    for index in 0...maxIndex {
        if index > maxIndex - index {
            break
        }
        (newString[index], newString[maxIndex-index]) =
            (newString[maxIndex-index], newString[index])
    }
    return String(newString)
}
//print(reverseStringInPlace(string: "Apple"))
//: Approach II
func reverseStringUsingIndex(string: String) -> String {
    var reverseString = String()
    for character in string {
        reverseString.insert(character, at: reverseString.startIndex)
    }
    return reverseString
}
//print(reverseStringUsingIndex(string: "Apple"))
//: ---
//: ## 3. Check if string 1 is permutation of string 2
//: Approach I - Sort
func permutationIstAppr(string1: String, string2: String) -> Bool {
    if string1.count != string2.count {
        return false
    }
    let charArray1 = string1.sorted()
    let charArray2 = string2.sorted()
    if charArray1.elementsEqual(charArray2) {
        return true
    } else {
        return false
    }
}
//print(permutationIstAppr(string1: "Swapnil", string2: "nilSwap"))
//: Approach II: Check if two strings have identical count for each unique char
func permutationIIndAppr(string1: String, string2: String) -> Bool {
    if string1.count != string2.count {
        return false
    }
    var charCountArr = [Int](repeating: 0, count: 256)
    for char in string1 {
        let scalar = String(char).unicodeScalars
        charCountArr[Int(scalar[scalar.startIndex].value)] += 1
    }
    for char in string2 {
        let scalar = String(char).unicodeScalars
        let asciiValue = Int(scalar[scalar.startIndex].value)
        charCountArr[asciiValue] -= 1
        if charCountArr[asciiValue] < 0 {
            return false
        }
    }
    return true
}
print(permutationIIndAppr(string1: "Swapnil", string2: "nilSwap"))
print(permutationIIndAppr(string1: "Swapnilxxxyy", string2: "nilSwapxxyyy"))
//: ---
//: ## 4. Replace all spaces in a string with %20
func replaceSpace(charArr: [Character], length: Int) {
    var charArr = charArr
    var spaceCount = 0
    for index in 0...length-1 {
        if charArr[index] == " " {
            spaceCount += 1
        }
    }
    var newLength = length + (2 * spaceCount)
    var index = length - 1
    while index >= 0 {
        if charArr[index] ==  " " {
            charArr[newLength-1] = "0"
            charArr[newLength-2] = "2"
            charArr[newLength-3] = "%"
            newLength -= 3
        } else {
            charArr[newLength-1] = charArr[index]
            newLength -= 1
        }
        index -= 1
    }
    print(charArr)
}
//replaceSpace(
//    charArr: [" ","W"," ","P","N","I"," "," "," "," "," "," "," "," "," "],
//     length: 7)
//: ---
/*:
 ## 5. Basic string compression
 
    Input: SSJJSJ
    Output: S2J2S1J1
*/
func countCompress(str: String) -> Int {
    if str.count <= 1{
        return str.count
    }
    var compressedStringSize = 0
    var count = 1
    var lastChar = str[str.startIndex]
    for index in 1...str.count-1 {
        let char = str[str.index(str.startIndex, offsetBy: index)]
        if char == lastChar {
            count += 1
        } else {
            compressedStringSize += 1 + String(count).count
            lastChar = char
            count = 1
        }
    }
    compressedStringSize += 1 + String(count).count
    return compressedStringSize
}
//print(countCompress(str: "SSSSJJJJSSSSJJJ"))
//print(countCompress(str: "SJSJ"))
//print(countCompress(str: "JJJJJJJJJJ"))
func compressedString(str: String) -> String {
    if str.count <= 1 || str.count <= countCompress(str: str) {
        return str
    }
    var count = 1
    var lastChar = str[str.startIndex]
    var compressedStr = String(lastChar)
    for index in 1...str.count-1 {
        let char =  str[str.index(str.startIndex, offsetBy: index)]
        if char == lastChar {
            count += 1
        } else {
            compressedStr.append(String(count) + String(char))
            count = 1
            lastChar = char
        }
    }
    compressedStr.append(String(count))
    return compressedStr
}
//print(compressedString(str: "SSSSJJJJSSSSJJJJ"))
//print(compressedString(str: "SJSJSJSJSJSJSJSJ"))
//print(compressedString(str: "SJ"))
//: ---
//: ## 6. Check if string 2 is a rotatin of string 1
func isRotation(s1: String, s2: String) -> Bool {
    if s1.count == s2.count && s1.count > 0 {
        let s1s1 = s1 + s1
        if isSubstring(s1: s1s1, s2: s2){
            return true
        }
    }
    return false
}
func isSubstring(s1: String, s2: String) -> Bool {
    if s1.count == 0 || s2.count == 0 || s1.count < s2.count {
        return false
    }
    var matchCount = 0
    for index in 0...s1.count-1 {
        let c1 = s1[s1.index(s1.startIndex, offsetBy: index)]
        let c2 = s2[s2.index(s2.startIndex, offsetBy: matchCount)]
        if c1 == c2 {
            matchCount += 1
            if matchCount == s2.count {
                return true
            }
        } else {
            matchCount = 0
        }
    }
    return false
}
//print(isSubstring(s1: "SwapnilJain", s2: "jain"))
//print(isRotation(s1: "SwapnilJain", s2: "JainSwapnil"))
//: ---
//: ## 7. Convert a string into integer
func stringToInt(_ string: String) -> Int? {
    var number = 0
    var multipler = 1
    for char in string.reversed() {
        if let asciiVal = char.asciiValue, asciiVal >= 48, asciiVal <= 57 {
            number = number + (Int(String(char))! * multipler)
            multipler *= 10
        } else {
            return nil
        }
    }
    return number
}
//print(stringToInt("1"))
//print(stringToInt("99"))
//print(stringToInt("101"))
//print(stringToInt("1009"))
//print(stringToInt("10900"))
//: ---
//: ## 8. Check if the string is palindrome
func isPalindrome(string: String) -> Bool {
    for index in 0..<string.count/2 {
        let charFromStart = string[string.index(string.startIndex, offsetBy: index)]
        let charFromLast = string[string.index(string.endIndex, offsetBy: -index-1)]
        if charFromStart != charFromLast {
            return false
        }
        /* // Case insensitive matching
         if String(charFromStart).lowercased() != String(charFromLast).lowercased(){
             return false
         }
         */
    }
    return true
}
//print(isPalindrome(string: "AppleXelppA"))
//print(isPalindrome(string: "civic"))
//print(isPalindrome(string: "Apple"))
//: ---
/*:
 ## 9. String comparison
 * Write a comparator that takes two strings and returns a standard integer value:
 
        Something negative if the first string is "smaller", zero if they are "equal", and something positive if the first string is "larger".
        We want to agree with the standard comparator for all cases except one:
        If we encounter a consecutive string of integers, we want to read it for its numeric value, and use that as the comparison.
        For instance, in the standard string comparator, "a10b" comes before "a2b", because 'a' == 'a' and '1' < '2'.
        In our string ordering, I want to reverse this, instead parsing it so that we see 'a' == 'a', but 10 > 2.
 */
func compareStrings(stringA: String, stringB: String) -> Int {
    if stringA.isEmpty || stringB.isEmpty {
        return -9
    }
    var indexA = 0, indexB = 0
    var intA = "", intB = ""
    while indexA != stringA.count && indexB != stringB.count {
        let charA = stringA[stringA.index(stringA.startIndex, offsetBy: indexA)]
        let charB = stringB[stringB.index(stringB.startIndex, offsetBy: indexB)]
        var isaNumber = false
        
        if charA.asciiValue! >= UInt32(48) && charA.asciiValue! <= UInt(57) {
            intA.append(charA)
            indexA += 1
            isaNumber = true
        }
        if charB.asciiValue! >= UInt32(48) && charB.asciiValue! <= UInt(57) {
            intB.append(charB)
            indexB += 1
            isaNumber = true
        }
        
        if !isaNumber { // Both are non-digit characters
            if !intA.isEmpty && !intB.isEmpty {
                let intValA = stringToInt(intA)!
                let intValB = stringToInt(intB)!
                if intValA > intValB {
                    return 1
                } else if intValA < intValB {
                    return -1
                }
                intA = ""
                intB = ""
            }
            if charA > charB {
                return 1
            } else if charA < charB {
                return -1
            }
            indexA += 1
            indexB += 1
        }
    }
    
    if stringA.count > stringB.count {
        return 1
    } else if stringA.count < stringB.count {
        return -1
    } else if !intA.isEmpty && !intB.isEmpty {
        let intValA = stringToInt(intA)!
        let intValB = stringToInt(intB)!
        if intValA > intValB {
            return 1
        } else if intValA < intValB {
            return -1
        }
    }
    return 0
}
// Test Cases:
//print(compareStrings(stringA: "", stringB: ""))
//print(compareStrings(stringA: "a2b", stringB: "a2b"))
//print(compareStrings(stringA: "a10b", stringB: "a2b"))
//print(compareStrings(stringA: "a10b", stringB: "a11b"))
//print(compareStrings(stringA: "a99b", stringB: "a999b"))
//print(compareStrings(stringA: "a1000b4321", stringB: "a1000b1234"))
//print(compareStrings(stringA: "a1000b4321", stringB: "a1000b12345"))
//print(compareStrings(stringA: "12345", stringB: "12345"))
//print(compareStrings(stringA: "10", stringB: "101010"))
//print(compareStrings(stringA: "99xx99", stringB: "99yy99"))
//print(compareStrings(stringA: "99xx99", stringB: "99xx99"))
//print(compareStrings(stringA: "abcde", stringB: "abcde"))
//print(compareStrings(stringA: "abcdezy", stringB: "abcde"))
//: ---
//: ## 10. Find out the first non-repeating character in the string
//: Time complexity - O(n^2)
func firstNonRepeatingCharacter(string: String) -> Character? {
    var aSet = Set<Character>()
    var outerIndex = 0
    for char in string {
        if !aSet.contains(char) {
            var isUnique = true
            for innerIndex in outerIndex+1..<string.count {
                let nextChar = string[string.index(string.startIndex, offsetBy: innerIndex)]
                if char == nextChar {
                    aSet.insert(char)
                    isUnique = false
                    break
                }
            }
            if isUnique {
                return char
            }
        }
        outerIndex += 1
    }
    return nil
}
//print(firstNonRepeatingCharacter(string: "Apple") ??
//    "No non-repeating character found.")
//print(firstNonRepeatingCharacter(string: "AApple") ??
//    "No non-repeating character found.")
//print(firstNonRepeatingCharacter(string: "AApplle") ??
//    "No non-repeating character found.")
//print(firstNonRepeatingCharacter(string: "AAppllee") ??
//    "No non-repeating character found.")
//print(firstNonRepeatingCharacter(string: "AaaaaaaAxxyyabc") ??
//    "No non-repeating character found.")
//: ---
//: ## 11. Check if the string is an edit away from the other one
func oneEditApart(string1: String, string2: String) -> Bool {
  var arr1 = Array(string1), arr2 = Array(string2)
  if (arr1.count < arr2.count) {
    swap(&arr1, &arr2)
  }
  if(arr1.count - arr2.count > 1) {
    return false
  }
  var idx1 = 0, idx2 = 0
  var mismatchCount = 0
  while idx2 != arr2.count {
    if (arr1[idx1] != arr2[idx2]) {
      mismatchCount += 1
      if (mismatchCount > 1) {
        return false
      }
      if (arr1.count > arr2.count) {
        idx2 -= 1
      }
    }
    idx1 += 1
    idx2 += 1
  }
  return true
}
//print(oneEditApart(string1: "cat", string2: "dog"))
//print(oneEditApart(string1: "cat", string2: "cats"))
//print(oneEditApart(string1: "cat", string2: "cut"))
//print(oneEditApart(string1: "cat", string2: "cast"))
//print(oneEditApart(string1: "cat", string2: "at"))
//print(oneEditApart(string1: "cat", string2: "act"))
//: ---
//: [Next](@next)
