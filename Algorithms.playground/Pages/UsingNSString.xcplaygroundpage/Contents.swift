import Foundation
//: [Previous](@previous)
/*:
 # NSString
 */
/*:
 ## Check if NSString has all unique characters
 */
func hasAllUniqueCharacters(string: NSString) -> Bool{
    if string.length>256{
        return false
    }
    var arr = [Bool](repeating: false, count: 256)
    for index in 0...string.length-1{
        if arr[Int(string.character(at: index))]{
            return false
        }
        arr[Int(string.character(at: index))] = true
    }
    return true
}
// Test Cases:
//print(hasAllUniqueCharacters(string: "Arihant"))
/*:
 ## Reverse a NSString
 */
func reverseNSString(string: NSString){
    if string.length == 0{
        return
    }
    let char = string.character(at: string.length-1)
    print(Character(UnicodeScalar(char)!))
    
    let subString: NSString = string.substring(to: string.length-1) as NSString
    reverseNSString(string: subString)
}
// Test Cases:
//reverseNSString(string: "Swapnil")
//: [Next](@next)
