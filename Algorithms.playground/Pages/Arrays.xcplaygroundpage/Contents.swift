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
func isSumOfAnyTwoElementIsEqualToN(_ anArray: [Int], _ n: Int) -> Bool{
    var aSet = Set<Int>()
    for index in 0..<anArray.count{
        let diffVal = n - anArray[index]
        if aSet.contains(diffVal){
            return true
        }
        aSet.insert(anArray[index])
    }
    return false
}
// Test Cases:
//let arrayOne = [2, 4, 8, 18, 13, 9, 15]
//print(isSumOfAnyTwoElementIsEqualToN(arrayOne, 10))
//print(isSumOfAnyTwoElementIsEqualToN(arrayOne, 9))
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
/*:
 ## Rotate an array by Delta
 With buffer array
 */
/*
 Input: [1, 4, 7, 3, 2, 9], 3
 Output: [3, 2, 9, 1, 4, 7]
 */
func rotateArrayByDelta(array: [Int], delta: Int) -> [Int]{
    var newDelta = delta
    if delta >= array.count{
        newDelta = delta % array.count
    }
    var outputArray = [Int]()
    var arrayIndex = newDelta
    for index in 0..<array.count{
        if index+newDelta == array.count{
            arrayIndex = 0
        }
        outputArray.append(array[arrayIndex])
        arrayIndex += 1
    }
    return outputArray
}
// Test Cases:
//print(rotateArrayByDelta(array: [1, 4, 7, 3, 2, 9], delta: 5))
/*:
 ## Rotate an array by Delta
 Without buffer array
 */
/*
 Input: [1, 4, 7, 3, 2, 9], 4
 Output: [ 2, 9, 1, 4, 7, 3]
 */
func rotateArrayByDeltaWithNoBuffer(array: [Int], delta: Int) -> [Int]{
    var array = array
    var newDelta = delta
    if delta >= array.count{
        newDelta = delta % array.count
    }
    // Reverse the first half
    for index in 0..<newDelta/2{
        (array[index], array[newDelta-1-index]) = (array[newDelta-1-index], array[index])
    }
    // Reverse the second half
    for index in newDelta..<newDelta+((array.count-newDelta)/2){
        (array[index], array[array.count-1-(index-newDelta)]) = (array[array.count-1-(index-newDelta)], array[index])
    }
    // Return the whole array and return
    return array.reversed()
}
// Test Cases:
//let array = [1, 4, 7, 3, 2, 9]
//print(rotateArrayByDeltaWithNoBuffer(array: array, delta: 0))
//print(rotateArrayByDeltaWithNoBuffer(array: array, delta: 1))
//print(rotateArrayByDeltaWithNoBuffer(array: array, delta: 2))
//print(rotateArrayByDeltaWithNoBuffer(array: array, delta: 3))
//print(rotateArrayByDeltaWithNoBuffer(array: array, delta: 4))
//print(rotateArrayByDeltaWithNoBuffer(array: array, delta: 5))
//print(rotateArrayByDeltaWithNoBuffer(array: array, delta: 6))
/*:
 ## Reverse partial range in array
 */
/*
 Input: [1, 4, 7, 3, 2, 9], 1, 4
 Output: [1, 2, 3, 7, 4, 9]
 */
func reverseSubArray(array: [Int], startIndex: Int, endIndex: Int) -> [Int]{
    var startIndex = startIndex
    var endIndex = endIndex
    var array = array
    if startIndex >= array.count-1 || startIndex < 0 || endIndex <= 0 || endIndex > array.count-1 || startIndex >= endIndex{
        return array
    }
    while startIndex < endIndex{
        (array[startIndex], array[endIndex]) = (array[endIndex], array[startIndex])
        startIndex += 1
        endIndex -= 1
    }
    return array
}
// Test Cases:
//let array = [1, 4, 7, 3, 2, 9]
//print(reverseSubArray(array: array, startIndex: 0, endIndex: 2))

//: [Next](@next)
