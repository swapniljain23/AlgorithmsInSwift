//: [Previous](@previous)
/*:
 # Mathematics
 */
/*:
 ## Find the median
 */
import Foundation

struct Business {
    var id: Int
    var rating: Double
}

func medianRating(of businesses: [Business]) -> Double {
    if businesses.count < 1 {
        return 0
    }
    var businesses = businesses.sorted {
        return $0.rating < $1.rating ? true : false
    }
    if businesses.count % 2 == 0 {
        let nThRating = businesses[(businesses.count/2)-1]
        let n1ThRating = businesses[businesses.count/2]
        return (nThRating.rating + n1ThRating.rating)/2
    } else {
        return businesses[businesses.count/2].rating
    }
}
// Test Cases:
//let b1 = Business(id: 101, rating: 102)
//let b2 = Business(id: 101, rating: 56)
//let b3 = Business(id: 101, rating: 34)
//let b4 = Business(id: 101, rating: 99)
//let b5 = Business(id: 101, rating: 89)
//let b6 = Business(id: 101, rating: 101)
//let b7 = Business(id: 101, rating: 10)
//let b8 = Business(id: 101, rating: 54)
//print(medianRating(of: [b1,b2,b3,b4,b5,b6,b7]))
//print(medianRating(of: [b1,b2,b3,b4,b5,b6,b7,b8]))
/*:
 ## LCM: Least/Lowest Common Multiple of 2 numbers
 */
func lcmOfTwoNumbers(_ n1: Int, _ n2: Int) -> Int {
    if n1 == 0 || n2 == 0 {
        return 0
    }
    let minNo = [n1, n2].min()!
    var maxNo = [n1, n2].max()!
    let maxOffset = maxNo
    var remainder = maxNo % minNo
    while remainder != 0 {
        maxNo = maxNo + maxOffset
        remainder = maxNo % minNo
    }
    return maxNo
}
//print(lcmOfTwoNumbers(0, 0))
//print(lcmOfTwoNumbers(1, 1))
//print(lcmOfTwoNumbers(12, 12))
//print(lcmOfTwoNumbers(12, 18))
//print(lcmOfTwoNumbers(240, 924))
/*:
 ## LCM: Least/Lowest Common Multiple of n numbers
 ### Smaller Nos
 */
func calculateSmallNosLCM(_ anArr: [Int]) -> Int {
    if anArr.count < 1 || anArr.contains(0) {
        return 0
    }
    let maxNo = anArr.max()!
    var lcm = maxNo
    var isAllDivisible = false
    
    repeat {
        isAllDivisible = true
        for item in anArr {
            if lcm % item != 0 {
                isAllDivisible = false
            }
        }
        if isAllDivisible {
            return lcm
        }
        lcm += maxNo
    } while !isAllDivisible
    return lcm
}
// Test Cases:
//print(calculateSmallNosLCM([]))
//print(calculateSmallNosLCM([0, 0, 0]))
//print(calculateSmallNosLCM([10]))
//print(calculateSmallNosLCM([2, 4, 6]))
//print(calculateSmallNosLCM([10, 15, 20]))
//print(calculateSmallNosLCM([10, 15, 20, 20]))
//print(calculateSmallNosLCM([10, 15, 20, 7]))
//print(calculateSmallNosLCM([10, 15, 20, 7, 9]))
/*:
 ## LCM: Least/Lowest Common Multiple of n numbers
 ### Large Nos
 */
func calculateLargeNosLCM(_ anArr: [Int]) -> Int {
    if anArr.count < 1 || anArr.contains(0) {
        return 0
    } else if anArr.count < 2 {
        return anArr[0]
    }
    
    var anArr = anArr
    var divideBy = 2
    var lcm = 1
    var oneCount = 0
    
    while oneCount != anArr.count {
        var isDivided = false
        for index in 0..<anArr.count {
            if anArr[index] % divideBy == 0 {
                anArr[index] /= divideBy
                if anArr[index] == 1 {
                    oneCount += 1
                }
                isDivided = true
            }
        }
        if isDivided {
            lcm *= divideBy
        } else {
            divideBy += 1
        }
    }
    return lcm
}
// Test Cases:
//print(calculateLargeNosLCM([]))
//print(calculateLargeNosLCM([0, 0, 0]))
//print(calculateLargeNosLCM([10]))
//print(calculateLargeNosLCM([2, 4, 6]))
//print(calculateLargeNosLCM([10, 15, 20]))
//print(calculateLargeNosLCM([10, 15, 20, 20]))
//print(calculateLargeNosLCM([10, 15, 20, 7]))
//print(calculateLargeNosLCM([10, 15, 20, 7, 9]))
/*:
 ## HCF: Highest/Greatest Common Factor of 2 numbers
 */
func hcfOfTwoNumbers(_ n1: Int, _ n2: Int) -> Int {
    if n1 == 0 || n2 == 0 {
        return 0
    }
    var minNo = [n1, n2].min()!
    var maxNo = [n1, n2].max()!
    var remainder = maxNo % minNo
    while remainder != 0 {
        maxNo = minNo
        minNo = remainder
        remainder = maxNo % minNo
    }
    return minNo
}
//print(hcfOfTwoNumbers(0, 0))
//print(hcfOfTwoNumbers(1, 1))
//print(hcfOfTwoNumbers(12, 12))
//print(hcfOfTwoNumbers(12, 18))
//print(hcfOfTwoNumbers(240, 924))
/*:
 ## HCF: Highest/Greatest Common Factor of n numbers
 ### Smaller Nos
 */
func calculateSmallNosHCF(anArr: [Int]) -> Int {
    if anArr.count < 1 || anArr.contains(0) {
        return 0
    }
    let minNo = anArr.min()!
    var hcf = minNo
    var isAllDivisible = false
    var divisor = 2
    repeat {
        isAllDivisible = true
        for item in anArr {
            if item % hcf != 0 {
                isAllDivisible = false
            }
        }
        if isAllDivisible {
            return hcf
        }
        while minNo % divisor != 0 && divisor < minNo {
            divisor += 1
        }
        hcf = minNo / divisor
        divisor += 1
    } while hcf != 1
    return hcf
}
// Test Cases:
//print(calculateSmallNosHCF(anArr: []))
//print(calculateSmallNosHCF(anArr: [1, 1, 1]))
//print(calculateSmallNosHCF(anArr: [12, 18]))
//print(calculateSmallNosHCF(anArr: [240, 924]))
//print(calculateSmallNosHCF(anArr: [13, 14, 15, 17]))
//print(calculateSmallNosHCF(anArr: [99, 11]))
//print(calculateSmallNosHCF(anArr: [1, 6, 8, 10, 12]))
//print(calculateSmallNosHCF(anArr: [7, 17, 19, 23, 29]))
//print(calculateSmallNosHCF(anArr: [12, 16, 20]))
/*:
 ## HCF: Highest/Greatest Common Factor of n numbers
 ### Larger Nos
 */
func calculateLargeNosHCF(anArr: [Int]) -> Int {
    if anArr.count < 1 || anArr.contains(0) {
        return 0
    } else if anArr.count < 2 {
        return anArr[0]
    }
    
    var anArr = anArr
    var divideBy = 2
    var hcf = 1
    var oneCount = 0
    
    while oneCount != anArr.count {
        var divideCount = 0
        oneCount = 0
        for index in 0..<anArr.count {
            if anArr[index] % divideBy == 0 {
                anArr[index] /= divideBy
                divideCount += 1
            }
            if anArr[index] == 1 {
                oneCount += 1
            }
        }
        if divideCount == anArr.count {
            hcf *= divideBy
        } else if divideCount == 0 {
            divideBy += 1
        }
    }
    return hcf
}
//print(calculateLargeNosHCF(anArr: []))
//print(calculateLargeNosHCF(anArr: [5]))
//print(calculateLargeNosHCF(anArr: [1, 1, 1]))
//print(calculateLargeNosHCF(anArr: [12, 24, 36]))
//print(calculateLargeNosHCF(anArr: [12, 18, 15]))
//print(calculateLargeNosHCF(anArr: [17, 51, 85]))
//print(calculateLargeNosHCF(anArr: [240, 924]))
//print(calculateLargeNosHCF(anArr: [1, 6, 8, 10, 12]))
//print(calculateLargeNosHCF(anArr: [7, 17, 19, 23, 29]))
/*:
 ## Print Fibonacci Series
 */
func printFibonacci(_ n: Int) {
    var previous = 0
    var current = 1
    for num in 0...n {
        if num == 0 {
            print(0, separator: "", terminator: " ")
        } else if num == 1 {
            print(1, separator: "", terminator: " ")
        } else {
            let sum = previous + current
            print(sum, separator: "", terminator: " ")
            previous = current
            current = sum
        }
        if num == n {
            print("")
        }
    }
}
// Test Cases:
//printFibonacci(0)
//printFibonacci(1)
//printFibonacci(2)
//printFibonacci(10)
/*:
 ## Print nTh number in Fibonacci Series (Recursive)
 ### Runtime: 0(2^n), Exponential
 */
func fibonacciNthTerm(_ n: Int) -> Int {
    if n == 0 {
        return 0
    } else if n == 1 {
        return 1
    } else {
        return fibonacciNthTerm(n-1) + fibonacciNthTerm(n-2)
    }
}
// Test Cases:
//print(fibonacciNthTerm(0))
//print(fibonacciNthTerm(1))
//print(fibonacciNthTerm(2))
//print(fibonacciNthTerm(10))
/*:
 ## Print sum of n numbers in Fibonacci series
 */
func fibonacciSum(n: Int) -> Int {
    if n == 0 {
        return 0
    } else if n == 1 {
        return 1
    }
    var sum = 0
    var previous = 0
    var current = 1
    for _ in 2...n {
        sum = previous + current
        previous = current
        current = sum
    }
    return sum
}
// Test Cases:
//print(fibonacciSum(n: 0))
//print(fibonacciSum(n: 1))
//print(fibonacciSum(n: 2))
//print(fibonacciSum(n: 10))
/*:
 ## Check if the number is prime or not
 * primality test: trial division
 * https://en.wikipedia.org/wiki/Primality_test#Fast_deterministic_tests
 *       All integers can be formed by 6k + i
         where i = -1, 0, 1, 2, 3, 4
         6k + 0, 6k + 2 and 6k + 4 = All divisible by 2
         6k + 3 = divisble by 3
         Only 6k - 1 and 6k + 1 = Can be prime?
 */
func isPrime(_ number: Int) -> Bool {
    if number <= 1 {
        return false
    } else if number <= 3 {
        return true
    } else if number % 2 == 0 || number % 3 == 0 {
        return false
    }
    var index = 5 // 6k-1(6*1-1)
    while index * index <= number {
        if number % index == 0 || number % (index+2) == 0 {
            return false
        }
        index += 6
    }
    return true
}
/*:
 ## Print the list of all PRIME numbers between num1 and num2
 */
func printAllPrimeBetween(lower: Int, upper: Int) {
    for number in lower...upper {
        if isPrime(number) {
            print(number, separator: "", terminator: " ")
        }
    }
}
//print(printAllPrimeBetween(lower: 1, upper: 100))
//print(printAllPrimeBetween(lower: 100, upper: 200))

//: [Next](@next)
