import Foundation
var unSortedArray = [2, 225, 17, 10, 220, 108, 109, 293, 83]
let sortedArray = [2, 10, 17, 99, 105, 108, 109, 220, 225]
//: [Previous](@previous)
/*:
 # Sorting and Searching Algos
 */
/*:
 ## Binary Search
 ### Runtime: O(log(n))
 ### Memory: O()
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
 ### Runtime: O(n^2)
 ### Memory: O(1)
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
 ### Runtime: O(n^2)
 ### Memory: O(1)
 ### Worse than Insertion Sort, better than Bubble Sort
 */
func selectionSort(_ unsortedArr: [Int])->[Int]{
    if unsortedArr.count <= 1{
        return unsortedArr
    }
    var unsortedArr = unsortedArr
    for index in 0..<unsortedArr.count-1{
        var lowerIndex = index
        for innerIndex in index+1..<unsortedArr.count{
            if unsortedArr[innerIndex] < unsortedArr[lowerIndex]{
                lowerIndex = innerIndex
            }
        }
        if lowerIndex != index{
            unsortedArr.swapAt(index, lowerIndex)
        }
    }
    return unsortedArr
}
// Test Cases:
//print(selectionSort(unSortedArray))
/*:
 ## Insertion Sort
 ### Runtime: // O(n^2)
 ### Memory: // O(1)
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
//print(insertionSort(unSortedArray))
/*:
 ## Merge Sort
 ### Runtime: O(n log(n))
 ### Memory: Depends
 */
func mergeSort(_ unsortedArr: [Int]) -> [Int]{
    if unsortedArr.count <= 1{
        return unsortedArr
    }
    let midIndex = unsortedArr.count / 2
    let leftArr = mergeSort(Array(unsortedArr[0..<midIndex]))
    let rightArr = mergeSort(Array(unsortedArr[midIndex..<unsortedArr.count]))
    return merge(leftArr, rightArr)
}
func merge(_ leftArray: [Int], _ rightArray: [Int]) -> [Int]{
    var leftArrIndex = 0
    var rightArrIndex = 0
    var sortedArr = [Int]()
    while leftArrIndex < leftArray.count && rightArrIndex < rightArray.count{
        if leftArray[leftArrIndex] < rightArray[rightArrIndex]{
            sortedArr.append(leftArray[leftArrIndex])
            leftArrIndex += 1
        }else{
            sortedArr.append(rightArray[rightArrIndex])
            rightArrIndex += 1
        }
    }
    sortedArr.append(contentsOf: leftArray[leftArrIndex..<leftArray.count])
    sortedArr.append(contentsOf: rightArray[rightArrIndex..<rightArray.count])
    return sortedArr
}
// Test Cases:
//print(mergeSort(unSortedArray))
/*:
 ## Heap Sort
 ### Runtime:
 ### Memory:
 */

/*:
 ## Quick Sort
 ### Runtime: Avg case O(n log(n)), worst case: O(n^2)
 ### Memory: O(log(n))
 */
func quickSort(_ unsortedArr: inout [Int], left: Int = 0, right: Int) -> [Int]{
    let pivotIndex = partition(&unsortedArr, left: left, right: right)
    // sort left half
    if left < pivotIndex-1{
        let _ = quickSort(&unsortedArr, left: left, right: pivotIndex-1)
    }
    // sort right half
    if pivotIndex < right{
        let _ = quickSort(&unsortedArr, left: pivotIndex, right: right)
    }
    return unsortedArr
}
func partition(_ unsortedArr: inout [Int], left: Int, right: Int) -> Int{
    var left = left, right = right
    let pivotVal = unsortedArr[(left+right)/2]
    while (left <= right){
        while unsortedArr[left] < pivotVal{
            left += 1
        }
        while unsortedArr[right] > pivotVal{
            right -= 1
        }
        if (left <= right){
            // swap element
            unsortedArr.swapAt(left, right)
            left += 1
            right -= 1
        }
    }
    return left
}
// Test Cases:
//print(quickSort(&unSortedArray, right: unSortedArray.count-1))
//: [Next](@next)
