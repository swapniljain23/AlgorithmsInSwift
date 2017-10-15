import Foundation
let unSortedArray = [2, 225, 17, 10, 220, 108, 109, 293, 83]
let sortedArray = [2, 10, 17, 99, 105, 108, 109, 220, 225]
//: [Previous](@previous)
/*:
 # Sorting and Searching Algos
 */
/*:
 ## Binary Search
 ### Time: O(Log(n))
 ### Space: O()
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
 print(binarySearch(sortedArray: sortedArray, numberToSearch: 2, lowerIndex: 0, upperIndex: sortedArray.count-1))
 print(binarySearch(sortedArray: sortedArray, numberToSearch: 225, lowerIndex: 0, upperIndex: sortedArray.count-1))
 print(binarySearch(sortedArray: sortedArray, numberToSearch: 105, lowerIndex: 0, upperIndex: sortedArray.count-1))
 print(binarySearch(sortedArray: sortedArray, numberToSearch: 100, lowerIndex: 0, upperIndex: sortedArray.count-1))
 */
/*:
 ## Bubble Sort
 ### Time: O(n^2)
 ### Space: O(1)
 */
func bubbleSort(_ unsortedArr: [Int])->[Int]{
    var unsortedArr = unsortedArr
    for index in 0..<unsortedArr.count{
        for innerIndex in 1..<unsortedArr.count-index{
            if unsortedArr[innerIndex-1] > unsortedArr[innerIndex]{
                // Swap element here.
                (unsortedArr[innerIndex-1],unsortedArr[innerIndex]) = (unsortedArr[innerIndex],unsortedArr[innerIndex-1])
            }
        }
    }
    return unsortedArr
}
// Test Cases:
//print(bubbleSort(unSortedArray))
/*:
 ## Selection Sort
 ### Time: O(n^2)
 ### Space: O(1)
 */
func selectionSort(_ unsortedArr: [Int])->[Int]{
    var unsortedArr = unsortedArr
    return unsortedArr
}
/*:
 ## Insertion Sort
 ### Time: O(n^2)
 ### Space: O(1)
 */
func insertionSort(_ unsortedArr: [Int])->[Int]{
    var unsortedArr = unsortedArr
    for index in 1..<unsortedArr.count{
        var previousIndex = index - 1
        let indexVal = unsortedArr[index]
        while(previousIndex >= 0 && unsortedArr[previousIndex] > indexVal){
//            (unsortedArr[previousIndex],unsortedArr[previousIndex+1]) = (unsortedArr[previousIndex+1],unsortedArr[previousIndex])
            unsortedArr.swapAt(previousIndex, previousIndex+1)
            previousIndex -= 1
        }
    }
    return unsortedArr
}
// Test Cases:
print(insertionSort(unSortedArray))

//: [Next](@next)
