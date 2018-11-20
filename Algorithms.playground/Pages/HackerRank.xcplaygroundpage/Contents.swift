//: [Previous](@previous)
/*:
 # HackerRank: Implementation Challenges (EASY)
 */

/*:
 ## Character extension
 */
import Foundation

extension Character {
  var asciiValue: UInt32? {
    return String(self).unicodeScalars.filter{$0.isASCII}.first?.value
  }
}

/*:
 ## Grading Students
 */
func roundedGrade(actualGrades: [Int]) -> [Int] {
    return actualGrades.map() {
        $0 < 38 || $0 % 5 < 3 ? $0 : $0 + (5 - $0 % 5)
    }
}
//print(roundedGrade(actualGrades: [73, 67, 38, 33]))
/*:
 ## Check if two points will ever meet.
     0 <= x1 < x2 <= 10000
     1 <= v1 <= 10000
     1 <= v2 <= 10000
 */
func willTheyMeet(x1: Int, v1: Int, x2: Int, v2: Int) -> Bool {
    var x1 = x1, v1 = v1, x2 = x2, v2 = v2
    if (x1 > x2 && v1 >= v2) || (x2 > x1 && v2 >= v1) {
        return false
    }
    while x2 > x1 {
        x1 += v1
        x2 += v2
        if x1 == x2 {
            return true
        }
    }
    return false
}
//print(willTheyMeet(x1: 0, v1: 3, x2: 4, v2: 2))
//print(willTheyMeet(x1: 0, v1: 2, x2: 5, v2: 3))
/*:
 ## Between two sets
    some x is between A and B if that value of x satisfies x mod a[i] for every a[i] in A and also satisfies b[i] mod x = 0 for every b[i] in B.
 */
func numberBetweenTwoSets(arrayA: [Int], arrayB: [Int]) -> Int {
    if arrayA.isEmpty || arrayB.isEmpty {
        return 0
    }
    let maxNoFromA = arrayA.max()!
    let minNoFromB = arrayB.min()!
    if maxNoFromA > minNoFromB {
        return 0
    }
    var numberOfX = 0
    outer: for num in maxNoFromA...minNoFromB {
        inner: for element in arrayA {
            if num % element != 0 {
                continue outer
            }
        }
        inner: for element in arrayB {
            if element % num != 0 {
                continue outer
            }
        }
        print(num, separator: "", terminator: ": ")
        numberOfX += 1
    }
    return numberOfX
}
//print(numberBetweenTwoSets(arrayA: [2, 4], arrayB: [16, 32, 96]))
/*:
 ## Day of the Programmer
 */
func dayOfTheProgrammer(year: Int) -> String {
    if year == 1918 {
        return "26.09.\(year)"
    }
    // find out 256th day of the year
    if ((year >= 1919 &&
          (((year % 4 == 0) && (year % 100 != 0)) ||
              (year % 400 == 0))
        ) ||
        (year <= 1917 && year % 4 == 0)) {
        return "12.09.\(year)"
    } else {
        return "13.09.\(year)"
    }
}
/*:
 ## Funny string
 */
func funnyString(anArr: [String]) {
    for string in anArr {
        if string.count < 2 {
            continue
        }
        var isFunny = true
        for index in 1...string.count/2 {
            let char0 = string[string.index(string.startIndex, offsetBy: index-1)]
            let char1 = string[string.index(string.startIndex, offsetBy: index)]
            let char11 = string[string.index(string.endIndex, offsetBy: -index-1)]
            let char00 = string[string.index(string.endIndex, offsetBy: -index)]            
            if abs((Int(char1.asciiValue!) - Int(char0.asciiValue!))) !=
              abs((Int(char11.asciiValue!) - Int(char00.asciiValue!))) {
                isFunny = false
                break
            }
        }
        if isFunny {
            print("Funny")
        }else{
            print("Not Funny")
        }
    }
}
//print(funnyString(anArr: ["acxz", "bcxz"]))
//print(funnyString(anArr: ["ivvkxq", "ivvkx"]))

//: [Next](@next)
