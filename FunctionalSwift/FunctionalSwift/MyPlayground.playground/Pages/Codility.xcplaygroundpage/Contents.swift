//: [Previous](@previous)

import Foundation


func leaderOfArray(inout arr:[Int]) -> (leader: Int, count: Int) {
    
    if arr.count == 0 {
        return (-1, 0)
    }
    
    var leader = -1
    
    var candidate = arr[0]
    var count = 0
    
    for i in 0..<arr.count {
        let value = arr[i]
        if count == 0 {
            candidate = value
            count = 1
        } else if value != candidate{
            count -= 1
        } else {
            count += 1
        }
    }
    
    if count > 0 {
        count = 0
        for value in arr {
            if value == candidate {
                count += 1
            }
        }
        
        if count > arr.count / 2 {
            leader = candidate
        }
    }
    
    return (leader, count)
}

func solution(inout A : [Int]) -> Int {
    //get leader and leaders count
    let (leader, _) = leaderOfArray(&A)
    
    if leader == -1 {
        return -1
    }
    
    var result = -1
    var count = 0
    
    for i in 0..<A.count {
        if A[i] == leader {
            count += 1
        }
        
        if count > (i + 1) / 2 {
            result = i
            break
        }
        
    }
    
    return result
}


var arr = [3, 4, 3, 2, 3, -1, 3, 3]
solution(&arr)

