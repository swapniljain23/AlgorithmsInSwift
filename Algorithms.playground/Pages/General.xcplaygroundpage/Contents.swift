import Foundation
//: [Previous](@previous)
/*:
 ## Check if two points will ever meet.
 */
//0 <= x1 < x2 <= 10000
//1 <= v1 <= 10000
//1 <= v2 <= 10000
func willTheyMeet(x1: Int, v1: Int, x2: Int, v2: Int) -> Bool{
    var x1 = x1, v1 = v1, x2 = x2, v2 = v2
    if (x1 > x2 && v1 >= v2) || (x2 > x1 && v2 >= v1){
        return false
    }
    while x2 > x1{
        x1 += v1
        x2 += v2
        if x1 == x2{
            return true
        }
    }
    return false
}
//print(willTheyMeet(x1: 0, v1: 3, x2: 4, v2: 2))
//print(willTheyMeet(x1: 0, v1: 2, x2: 5, v2: 3))

//: [Next](@next)
