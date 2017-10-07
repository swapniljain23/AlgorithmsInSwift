import Foundation
//: [Previous](@previous)
/*:
 # Arrays
 */
/*:
 ## Check if sum of any two elements in an array is equal to n.
 */
/*
 Input:
 an array of Int
 a number Int
 Output:
 true/false
 */
func isCountOfAnyTwoElementIsEqualToN(_ anArray: [Int], _ n: Int) -> Bool{
    let aSet = Set(anArray)
    for index in 0..<anArray.count{
        let diffVal = n - anArray[index]
        if aSet.contains(diffVal){
            return true
        }
    }
    return false
}
// Test Cases:
//let arrayOne = [2, 4, 8, 18, 13, 9, 15]
//print(isCountOfAnyTwoElementIsEqualToN(arrayOne, 10))
//print(isCountOfAnyTwoElementIsEqualToN(arrayOne, 9))
/*:
 ## Skip multiplication in factorial
 */
/*
 Input: 3
 Output: [6, 3, 2]
 Algo:
 6 = ~1~ * 2 * 3 (skip multiplication by value at index 0)
 3 = 1 * ~2~ * 3 (skip multiplication by value at index 1)
 2 = 1 * 2 * ~3~ (skip multiplication by value at index 2)
 Time complexity: O(n)
 */
func products(number: Int) -> [Int] {
    var outputArray = Array(repeating: 1, count: number)
    let multipleValue = factorial(number)
    for index in 1...number{
        outputArray[index-1] = multipleValue / index
    }
    return outputArray
}
func factorial(_ number: Int) -> Int{
    return number == 1 ?  1 : number * factorial(number-1)
}
//Test Cases:
//print(products(number: 1))
//print(products(number: 2))
//print(products(number: 3))
//print(products(number: 4))
//print(products(number: 5))
//: [Next](@next)
