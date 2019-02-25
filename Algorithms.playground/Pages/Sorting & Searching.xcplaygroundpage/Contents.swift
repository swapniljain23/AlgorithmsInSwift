//: [Previous](@previous)
//: # TOP 10 ALGORITHMS
//: ---
//: ## SECTION III: Sorting and Searching
//: ---
/*:
 ## #1. Binary Search.
    Input: Sorted array and number to search
    Output: Return the index if number found in input array or return nil.
 ### Runtime: O(log n)
 ### Memory: T(n/2) + c
 */
import Foundation
var unSortedArray = [2, 225, 17, 10, 220, 108, 109, 293, 83]
let sortedArray = [2, 10, 17, 99, 105, 108, 109, 220, 225]
func binarySearch(_ sortedArray: [Int],
               _ numberToSearch: Int,
                   _ lowerIndex: Int,
                   _ upperIndex: Int) -> Int? {
    if lowerIndex > upperIndex {
        return nil
    }
    let midIndex = lowerIndex + (upperIndex - lowerIndex) / 2
    if numberToSearch < sortedArray[midIndex] {
        // Recursive call to search item in first half of the array.
        return binarySearch(sortedArray, numberToSearch, lowerIndex, midIndex-1)
    } else if numberToSearch > sortedArray[midIndex] {
        // Recursive call to search item in second half of the array.
        return binarySearch(sortedArray, numberToSearch, midIndex+1, upperIndex)
    } else {
        return midIndex
    }
}
func binarySearchIterative(_ sortedArray: [Int], numberToSearch: Int) -> Int? {
  var lowerIndex = 0, upperIndex = sortedArray.count - 1
  while lowerIndex <= upperIndex {
    let midIndex = lowerIndex + (upperIndex - lowerIndex) / 2
    if numberToSearch < sortedArray[midIndex] {
      upperIndex = midIndex - 1
    } else if numberToSearch > sortedArray[midIndex] {
      lowerIndex = midIndex + 1
    } else {
      return midIndex
    }
  }
  return nil
}
//print(binarySearchIterative(sortedArray, numberToSearch: 2))
//print(binarySearchIterative(sortedArray, numberToSearch: 225))
//print(binarySearchIterative(sortedArray, numberToSearch: 105))
//print(binarySearchIterative(sortedArray, numberToSearch: 100))
//print(binarySearch(sortedArray, 2, 0, sortedArray.count-1))
//print(binarySearch(sortedArray, 225, 0, sortedArray.count-1))
//print(binarySearch(sortedArray, 105, 0, sortedArray.count-1))
//print(binarySearch(sortedArray, 100, 0, sortedArray.count-1))
//: ---
/*:
 ## #2. Search an element in a sorted and rotated array.
 An element in a sorted array can be found in O(log n) time via binary search. But suppose we rotate
 an ascending order sorted array at some pivot unknown to you beforehand. So for instance, 1 2 3 4 5
 might become 3 4 5 1 2. Devise a way to find an element in the rotated array in O(log n) time.
 
    Input  : arr[] = {5, 6, 7, 8, 9, 10, 1, 2, 3}; key = 3
    Output : Found at index 8
 
    Input  : arr[] = {5, 6, 7, 8, 9, 10, 1, 2, 3}; key = 30
    Output : Not found
 
    Input : arr[] = {30, 40, 50, 10, 20}; key = 10
    Output : Found at index 3
 */
// O(log n)
// All solutions provided here assume that all elements in array are distinct.
func specialBinarySearch(_ sortedRotatedArray: [Int],
                             _ numberToSearch: Int,
                                 _ lowerIndex: Int,
                                 _ upperIndex: Int) -> Int? {
  if lowerIndex > upperIndex {
    return nil
  }
  let midIndex = (upperIndex + lowerIndex) / 2
  if sortedRotatedArray[midIndex] == numberToSearch {
    return midIndex
  }
  
  // If first half of array is sorted.
  if sortedRotatedArray[lowerIndex] < sortedRotatedArray[midIndex] {
    if numberToSearch >= sortedRotatedArray[lowerIndex] &&
        numberToSearch <= sortedRotatedArray[midIndex] {
      return specialBinarySearch(sortedRotatedArray,
                                 numberToSearch,
                                 lowerIndex,
                                 midIndex-1)
    } else {
      return specialBinarySearch(sortedRotatedArray,
                                 numberToSearch,
                                 midIndex+1,
                                 upperIndex)
    }
  } else {
    // If first half of array is not sorted then second half must be.
    if numberToSearch >= sortedRotatedArray[midIndex] &&
        numberToSearch <= sortedRotatedArray[upperIndex] {
      return specialBinarySearch(sortedRotatedArray,
                                 numberToSearch,
                                 midIndex+1,
                                 upperIndex)
    } else {
      return specialBinarySearch(sortedRotatedArray,
                                 numberToSearch,
                                 lowerIndex,
                                 midIndex-1)
    }
  }
}
//let arr1 = [5, 6, 7, 8, 9, 10, 1, 2, 3]
//let arr2 = [5, 6, 7, 8, 9, 10, 1, 2, 3]
//let arr3 = [30, 40, 50, 10, 20]
//print(specialBinarySearch(arr1, 3, 0, arr1.count-1))
//print(specialBinarySearch(arr2, 30, 0, arr2.count-1))
//print(specialBinarySearch(arr3, 10, 0, arr3.count-1))
//: ---
/*:
 ## #3. Bubble Sort.
 Bubble Sort is the simplest sorting algorithm that works by repeatedly swapping the adjacent
 elements if they are in wrong order.
 ### Runtime: O(n^2)
 ### Memory: O(1)
 */
func bubbleSort(_ unsortedArr: [Int]) -> [Int] {
    var unsortedArr = unsortedArr
    for index in 0..<unsortedArr.count {
        for innerIndex in 1..<unsortedArr.count-index {
            if unsortedArr[innerIndex-1] > unsortedArr[innerIndex] {
                // Swap element here.
                (unsortedArr[innerIndex-1], unsortedArr[innerIndex]) =
                      (unsortedArr[innerIndex], unsortedArr[innerIndex-1])
            }
        }
    }
    return unsortedArr
}
//print(bubbleSort(unSortedArray))
//: ---
/*:
 ## #4. Insertion Sort.
 Insertion sort is a simple sorting algorithm that works the way we sort playing cards in our hands.
 ### Runtime: O(n^2)
 ### Memory: O(1)
 */
func insertionSort(_ unsortedArr: [Int]) -> [Int] {
  var unsortedArr = unsortedArr
  for index in 1..<unsortedArr.count {
    var previousIndex = index - 1
    let indexVal = unsortedArr[index]
    while(previousIndex >= 0 && unsortedArr[previousIndex] > indexVal) {
//      (unsortedArr[previousIndex],unsortedArr[previousIndex+1]) =
//          (unsortedArr[previousIndex+1],unsortedArr[previousIndex])
      // OR
//      unsortedArr.swapAt(previousIndex, previousIndex+1)
      // OR
      unsortedArr[previousIndex+1] = unsortedArr[previousIndex]
      previousIndex -= 1
    }
    unsortedArr[previousIndex+1] = indexVal
  }
  return unsortedArr
}
//print(insertionSort(unSortedArray))
//: ---
/*:
 ## #5. Merge Sort.
 Like QuickSort, Merge Sort is a Divide and Conquer algorithm. It divides input array in two halves,
 calls itself for the two halves and then merges the two sorted halves.
 ### Runtime: O(n log(n))
 ### Memory: Depends
 */
func mergeSort(_ unsortedArr: [Int]) -> [Int] {
  if unsortedArr.count <= 1 {
    return unsortedArr
  }
  let midIndex = unsortedArr.count / 2
  let leftArr = mergeSort(Array(unsortedArr[0..<midIndex]))
  let rightArr = mergeSort(Array(unsortedArr[midIndex..<unsortedArr.count]))
  return merge(leftArr, rightArr)
}
func merge(_ leftArray: [Int], _ rightArray: [Int]) -> [Int] {
  var leftArrIndex = 0
  var rightArrIndex = 0
  var sortedArr = [Int]()
  while leftArrIndex < leftArray.count && rightArrIndex < rightArray.count {
    if leftArray[leftArrIndex] < rightArray[rightArrIndex] {
      sortedArr.append(leftArray[leftArrIndex])
      leftArrIndex += 1
    } else {
      sortedArr.append(rightArray[rightArrIndex])
      rightArrIndex += 1
    }
  }
  sortedArr.append(contentsOf: leftArray[leftArrIndex..<leftArray.count])
  sortedArr.append(contentsOf: rightArray[rightArrIndex..<rightArray.count])
  return sortedArr
}
//print(mergeSort(unSortedArray))
//: ---
/*:
 ## #6. Heap Sort
 Heap sort is a comparison based sorting technique based on Binary Heap data structure. It is
 similar to selection sort where we first find the maximum element and place the maximum element at
 the end. We repeat the same process for remaining element.
 A Binary Heap is a Complete Binary Tree where items are stored in a special order such that value
 in a parent node is greater(or smaller) than the values in its two children nodes. The former is
 called as max heap and the latter is called min heap. The heap can be represented by binary tree
 or array.
 Since a Binary Heap is a Complete Binary Tree, it can be easily represented as array and
 array based representation is space efficient. If the parent node is stored at index I, the left
 child can be calculated by 2 * I + 1 and right child by 2 * I + 2 (assuming the indexing starts at
 0).
 ### Runtime: O(nLogn)
 ### Memory:
 */
// TODO: Not working as expected. Review it.
func heapify(array: inout [Int], size: Int, index: Int) {
  var largest = index // Initialize largest as root.
  let left = 2 * index + 1 // left child.
  let right = 2 * index + 2 // right child.
  // Left child is larger than root.
  if left < size && array[left] > array[index] {
    largest = left
  }
  // Right child is larger than root.
  if right < size && array[right] > array[index] {
    largest = right
  }
  // If the largest is not root.
  if largest != index {
    array.swapAt(index, largest)
    // Recursively heapify the affected sub tree.
    heapify(array: &array, size: size, index: largest)
  }
}
func heapSort(array: inout [Int], size: Int) {
  // Build heap (rearrange array).
  var index = size / 2 - 1
  while index >= 0 {
    heapify(array: &array, size: size, index: index)
    index -= 1
  }
  // One by one extract an element from heap.
  index = size-1
  while index >= 0 {
    // Move current root to end.
    array.swapAt(0, index)
    // Call max heapify on the reduced heap.
    heapify(array: &array, size: index, index: 0)
    index -= 1
  }
}
//heapSort(array: &unSortedArray, size: unSortedArray.count)
//print(unSortedArray)
//: ---
/*:
 ## #7. Quick Sort.
 Like Merge Sort, QuickSort is a Divide and Conquer algorithm. It picks an element as pivot and
 partitions the given array around the picked pivot.
 The key process in quickSort is partition(). Target of partitions is, given an array and an element
 x of array as pivot, put x at its correct position in sorted array and put all smaller elements
 (smaller than x) before x, and put all greater elements (greater than x) after x. All this should
 be done in linear time.
 ### Runtime: Avg case O(nLog(n)), worst case: O(n^2)
 ### Memory: O(log(n))
 */
func quickSort(_ unsortedArr: inout [Int], left: Int = 0, right: Int) -> [Int] {
  let pivotIndex = partition(&unsortedArr, left: left, right: right)
  // Sort left half.
  if left < pivotIndex-1 {
    let _ = quickSort(&unsortedArr, left: left, right: pivotIndex-1)
  }
  // Sort right half.
  if pivotIndex < right {
    let _ = quickSort(&unsortedArr, left: pivotIndex, right: right)
  }
  return unsortedArr
}
func partition(_ unsortedArr: inout [Int], left: Int, right: Int) -> Int {
  var left = left, right = right
  let pivotVal = unsortedArr[(left+right)/2]
  while (left <= right) {
    while unsortedArr[left] < pivotVal {
      left += 1
    }
    while unsortedArr[right] > pivotVal {
      right -= 1
    }
    if (left <= right) {
      // Swap element.
      unsortedArr.swapAt(left, right)
      left += 1
      right -= 1
    }
  }
  return left
}
//print(quickSort(&unSortedArray, right: unSortedArray.count-1))
//: ---
/*:
 ## #8. Interpolation Search.
 */
//: ---
/*:
 ## #9. K’th Smallest/Largest Element in Unsorted Array | Set 2 (Expected Linear Time).
 */
//: ---
/*:
 ## #10. Given a sorted array and a number x, find the pair in array whose sum is closest to x.
 */
//: ---
//: # REST ALL.
//: ---
/*:
 ## Selection Sort
 Worse than Insertion Sort, better than Bubble Sort.
 ### Runtime: O(n^2)
 ### Memory: O(1)
 */
func selectionSort(_ unsortedArr: [Int]) -> [Int] {
    if unsortedArr.count <= 1 {
        return unsortedArr
    }
    var unsortedArr = unsortedArr
    for index in 0..<unsortedArr.count-1 {
        var lowerIndex = index
        for innerIndex in index+1..<unsortedArr.count {
            if unsortedArr[innerIndex] < unsortedArr[lowerIndex] {
                lowerIndex = innerIndex
            }
        }
        if lowerIndex != index {
            unsortedArr.swapAt(index, lowerIndex)
        }
    }
    return unsortedArr
}
//print(selectionSort(unSortedArray))
//: ---
//: [Next](@next)
