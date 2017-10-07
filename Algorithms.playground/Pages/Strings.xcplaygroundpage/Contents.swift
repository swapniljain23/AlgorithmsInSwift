import Foundation
//: [Previous](@previous)
/*:
 # Strings
 */
/*:
 ## Substring
 */
func getSubstringFromString(sourceString: String, beforeString str: String) -> String{
    if let range = sourceString.range(of: str){
        return String(sourceString[..<range.lowerBound])
    }
    return ""
}
func getSubstringAfterString(sourceString: String, afterString str: String) -> String{
    if let range = sourceString.range(of: str){
        return String(sourceString[range.upperBound...sourceString.index(before: sourceString.endIndex)])
    }
    return ""
}
// Test Cases:
//print(getSubstringFromString(sourceString: "Swapnil:Jain", beforeString: "Jain"))
//print(getSubstringAfterString(sourceString: "Swapnil:Jain", afterString: "Ja"))
/*:
 ## Check if String has all Unique characters
 */
// Approach I: ASCII (limit 256)
func hasAllUniqueChars(string: String) -> Bool{
    if string.characters.count>256{
        return false
    }
    var arr = [Bool](repeating: false, count: 256)
    for char in string.characters {
        let scalar = String(char).unicodeScalars
        if arr[Int(scalar[scalar.startIndex].value)]{
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
/*:
 ## Reverse a String: Approach I
 */
func reverseStringInPlace(string: String) -> String{
    guard string.characters.count > 1 else{
        return string
    }
    var newString = Array(string.characters)
    let maxIndex = newString.count - 1
    for index in 0...maxIndex{
        if index > maxIndex - index{
            break
        }
        (newString[index],newString[maxIndex-index]) = (newString[maxIndex-index],newString[index])
    }
    return String(newString)
}
// Test Cases:
/*:
 ## Reverse a String: Approach II
 */
func reverseStringUsingIndex(string: String) -> String{
    var reverseString = String()
    for character in string.characters{
        reverseString.insert(character, at: reverseString.startIndex)
    }
    return reverseString
}
// Test Cases:
//print(reverseStringUsingIndex(string: "Apple"))
/*:
 ## Check if String One is Permutation of String Two: Approach I
 Sort
 */
func permutationIstAppr(string1: String, string2: String) -> Bool{
    if string1.characters.count != string2.characters.count{
        return false
    }
    let charArray1 = string1.characters.sorted()
    let charArray2 = string2.characters.sorted()
    if charArray1.elementsEqual(charArray2){
        return true
    }else{
        return false
    }
}
// Test Cases:
//print(permutationIstAppr(string1: "Swapnil", string2: "nilSwap"))
/*:
 ## Check if String One is Permutation of String Two: Approach II
 Check if two strings have identical count for each unique char
 */
func permutationIIndAppr(string1: String, string2: String) -> Bool{
    if string1.characters.count != string2.characters.count{
        return false
    }
    var charCountArr = [Int](repeating: 0, count: 256)
    for char in string1.characters{
        let scalar = String(char).unicodeScalars
        charCountArr[Int(scalar[scalar.startIndex].value)] += 1
    }
    for char in string2.characters{
        let scalar = String(char).unicodeScalars
        if (charCountArr[Int(scalar[scalar.startIndex].value)]) - 1 < 0{
            return false
        }
    }
    return true
}
// Test Cases:
//print(permutationIIndAppr(string1: "Swapnil", string2: "nilswap"))
// TODO:- Bug >> print(permutationIIndAppr(string1: "Swapnilxxxyy", string2: "nilSwapxxyyy"))
/*:
 ## Replace all spaces in String with %20
 */
func replaceSpace( charArr: [Character], length: Int){
    var charArr = charArr
    var spaceCount = 0
    for index in 0...length-1{
        if charArr[index] == " "{
            spaceCount += 1
        }
    }
    var newLength = length + (2 * spaceCount)
    var index = length - 1
    while index>=0 {
        if charArr[index] ==  " "{
            charArr[newLength-1] = "0"
            charArr[newLength-2] = "2"
            charArr[newLength-3] = "%"
            newLength -= 3
        }else{
            charArr[newLength-1] = charArr[index]
            newLength -= 1
        }
        index -= 1
    }
    print(charArr)
}
// Test Cases:
//replaceSpace(charArr: [" ","W"," ","P","N","I"," "," "," "," "," "," "," "," "," "], length: 7)
/*:
 ## Basic String Compression
 */
/*
 Input: SSJJSJ
 Output: S2J2S1J1
*/
func countCompress(str: NSString) -> Int{
    if str.length <= 1{
        return str.length
    }
    var compressedStringSize = 0
    var count = 1
    var lastChar = str.character(at: 0)
    for index in 1...str.length-1{
        let char = str.character(at: index)
        if char == lastChar{
            count += 1
        }else{
            compressedStringSize += 1 + String(count).characters.count
            lastChar = char
            count = 1
        }
    }
    compressedStringSize += 1 + String(count).characters.count
    return compressedStringSize
}
// Test Cases:
//print(countCompress(str: "SSSSJJJJSSSSJJJ"))
//print(countCompress(str: "SJSJ"))
//print(countCompress(str: "JJJJJJJJJJ"))
func compressedString(str: NSString) -> NSString{
    if str.length <= 1 || str.length <= countCompress(str: str){
        return str
    }
    var count = 1
    var lastChar = str.character(at: 0)
    let compressedStr = NSMutableString.init(string: String(Character(UnicodeScalar(lastChar)!)))
    for index in 1...str.length-1{
        let char =  str.character(at: index)
        if char == lastChar{
            count += 1
        }else{
            compressedStr.append(String(count) + String(Character(UnicodeScalar(char)!)))
            count = 1
            lastChar = char
        }
    }
    compressedStr.append(String(count))
    return compressedStr
}
// Test Cases:
//print(compressedString(str: "SSSSJJJJSSSSJJJJ"))
//print(compressedString(str: "SJSJSJSJSJSJSJSJ"))
//print(compressedString(str: "SJ"))
/*:
 ## Check If String 2 is a rotatin of String 1
 */
func isRotation(s1: String, s2: String) -> Bool{
    if s1.characters.count == s2.characters.count && s1.characters.count > 0{
        let s1s1 = s1 + s1
        if isSubstring(s1: s1s1 as NSString, s2: s2 as NSString){
            return true
        }
    }
    return false
}
func isSubstring(s1: NSString, s2: NSString) -> Bool{
    if s1.length == 0 || s2.length == 0 || s1.length < s2.length{
        return false
    }
    var matchCount = 0
    for index in 0...s1.length-1{
        if s1.character(at: index) == s2.character(at: matchCount){
            matchCount += 1
            if matchCount == s2.length{
                return true
            }
        }else{
            matchCount = 0
        }
    }
    return false
}
// Test Cases:
//print(isSubstring(s1: "SwapnilJain", s2: "jain"))
//print(isRotation(s1: "SwapnilJain", s2: "JainSwapnil"))
//: [Next](@next)