//
//  FunctionalSwiftTests.swift
//  FunctionalSwiftTests
//
//  Created by Vince Tran on 7/22/16.
//  Copyright © 2016 Vince Tran. All rights reserved.
//

import XCTest
@testable import FunctionalSwift

class FunctionalSwiftTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        check1("Every string starts with Hello") { (s:String) -> Bool in
            return s.hasPrefix("Hello")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}





//Building Arbitrary Values

protocol Smaller {
    func smaller() -> Self?
}

protocol Arbitrary {
    static func arbitrary() -> Self
}

extension Int: Arbitrary, Smaller {
    static func arbitrary() -> Int {
        return Int(arc4random())
    }
    
    func smaller() -> Int? {
        return self == 0 ? nil: self / 2
    }
    
}

extension CGSize:Arbitrary {
    static func arbitrary() -> CGSize {
        let width = Int.arbitrary()
        let height = Int.arbitrary()
        return CGSize(width: width, height: height)
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

//Building Quick Check

func check1<A:Arbitrary>(message: String, prop: A -> Bool) -> Bool {
    let numberOfIterations = 30
    
    for _ in 0..<numberOfIterations {
        let value = A.arbitrary()
        if !prop(value) {
            print("\"\(message)\" doesn't hold: \(value)")
            return false
        }
    }
    print("\"\(message)\" passed \(numberOfIterations) tests.")
    return true
}

func area(size: CGSize) -> CGFloat {
    return size.width * size.height
}













