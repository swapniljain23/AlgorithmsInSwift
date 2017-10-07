import Foundation
//: [Previous](@previous)
/*:
 # Sorting and Searching Algos
 */
/*:
 ## Binary Search
 */
/*
 Input: Sorted array and number to search
 Output: Return the index if number found in input array or return nil.
 */
func binarySearch(sortedArray: [Int], numberToSearch: Int, lowerIndex: Int, upperIndex: Int) -> Int?{
    if lowerIndex > upperIndex{
        return nil
    }
    let midIndex = lowerIndex + (upperIndex - lowerIndex) / 2
    if numberToSearch < sortedArray[midIndex]{
        return binarySearch(sortedArray: sortedArray, numberToSearch: numberToSearch, lowerIndex: lowerIndex, upperIndex: midIndex-1)
    }else if numberToSearch > sortedArray[midIndex]{
        return binarySearch(sortedArray: sortedArray, numberToSearch: numberToSearch, lowerIndex: midIndex+1, upperIndex: upperIndex)
    }else{
        return midIndex
    }
}
//Test Cases:
/*
 let sortedArray = [2, 10, 17, 99, 105, 108, 109, 220, 225]
 print(binarySearch(sortedArray: sortedArray, numberToSearch: 2, lowerIndex: 0, upperIndex: sortedArray.count-1))
 print(binarySearch(sortedArray: sortedArray, numberToSearch: 225, lowerIndex: 0, upperIndex: sortedArray.count-1))
 print(binarySearch(sortedArray: sortedArray, numberToSearch: 105, lowerIndex: 0, upperIndex: sortedArray.count-1))
 print(binarySearch(sortedArray: sortedArray, numberToSearch: 100, lowerIndex: 0, upperIndex: sortedArray.count-1))
 */
//: [Next](@next)
