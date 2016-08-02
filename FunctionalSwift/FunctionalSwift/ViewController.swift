//
//  ViewController.swift
//  FunctionalSwift
//
//  Created by Vince Tran on 7/22/16.
//  Copyright © 2016 Vince Tran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var Heights = [8,8,5,7,9,8,7,4,8]
        solution(&Heights)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func solution(inout H : [Int]) -> Int {
        
        var result = 0
        var minHeights:[Int] = [Int.max]
        
        
        for height in H {
            
            let minimumHeight = minHeights.last
            if height > minimumHeight {
                result += 1
                minHeights.append(height)
            } else if height < minimumHeight {
                result += 1
                minHeights.removeLast()
                
                if let lastHeight = minHeights.last {
                    if lastHeight == height{
                        result -= 1
                    } else if lastHeight > height {
                        minHeights.removeLast()
                    }
                }
                
                minHeights.append(height)
            }
        }
        
        
        
        return result
    }
    
}

