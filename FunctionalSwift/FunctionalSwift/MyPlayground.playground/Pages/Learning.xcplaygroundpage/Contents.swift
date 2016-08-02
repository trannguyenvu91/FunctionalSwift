//: Playground - noun: a place where people can play

import UIKit

//Building Quick Check
protocol Arbitrary {
    static func arbitrary() -> Self
}

extension Int: Arbitrary {
    static func arbitrary() -> Int {
        return Int(arc4random())
    }
}

extension Character: Arbitrary {
    static func arbitrary() -> Character {
        return Character(UnicodeScalar(random(from: 65, to: 90)))
    }
    func smaller() -> Character? {
        return nil
    }
}

extension String: Arbitrary {
    static func arbitrary() -> String {
        let randomLength = random(from: 0, to: 50)
        let randomCharacters = tabulate(randomLength) { (_) -> Character in
            return Character.arbitrary()
        }
        
        return randomCharacters.reduce("", combine: { (result, c) -> String in
            return result + String(c)
        })
    }
}

func tabulate<A>(times: Int, f: Int -> A) -> [A] {
    return Array(0..<times).map(f)
}

func random(from from:Int, to:Int) -> Int {
    return from + Int(arc4random()) % (to - from)
}


String.arbitrary()



/*

struct City {
    let name:String
    let population:Int
}

func scale(city:City) -> City {
    return City(name: city.name, population: city.population * 1000)
}

//FILTER

func filter<T>(xs:[T], check: T -> Bool) -> [T] {
    var result:[T] = []
    for x in xs {
        if check(x) {
            result.append(x)
        }
    }
    return result
}

//REDUCE
func reduce<A,R>(arr:[A],
            initialValue: R,
            combine:(inout R, A) -> R) -> R {
    var result = initialValue
    
    for x in arr {
        combine(&result, x)
    }
    
    return result
}


let paris = City(name: "Paris", population: 2243)
let hanoi = City(name: "Hanoi", population: 1000)
let warsaw = City(name: "Warsaw", population: 1500)
let sweetdeland = City(name: "SweetdenLand", population: 1300)

let cities = [paris, hanoi, warsaw, sweetdeland]


cities.filter { (city) -> Bool in
    return city.population > 1000
}.map { (city) -> City in
    return scale(city)
}.reduce("City: Population") { (result, city) -> String in
    return result + "\n" + "\(city.name) : \(city.population)"
}
let arr = [1,2,3,4,5,6]
let sum = reduce(arr, initialValue: 0) { (result, input) -> Int in
    result += input
    return result
}



let exampleFiles = ["README.swift", "HelloWorld.swift", "LearningSwift.swift"]
filter(exampleFiles) { (file) -> Bool in
    return file.hasSuffix("swift")
}



//GENERIC
 
func genericComputeIntArray<U, T>(xs:[T], f:T -> U) -> [U] {
    var result:[U] = []
    for x in xs {
        result.append(f(x))
    }
    return result
}

func increaseArray(xs:[Int]) -> [Int] {
    return genericComputeIntArray(xs, f: { (x) -> Int in
        return x + 1
    })
}

func doubleArray(xs:[Int]) -> [Int] {
    return genericComputeIntArray(xs, f: { (x) -> Int in
        return 2 * x
    })
}

func isEvenArray(xs:[Int]) -> [Bool] {
    return genericComputeIntArray(xs, f: { (x) -> Bool in
        return x % 2 == 0
    })
}


let array = [1,2,3,4,5,6]
let evenBools = isEvenArray(array)
*/
