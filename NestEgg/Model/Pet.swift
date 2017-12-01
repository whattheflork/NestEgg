//
//  File.swift
//  NestEgg
//
//  Created by Andrew Chau on 11/26/17.
//  Copyright © 2017 Andrew Chau. All rights reserved.
//

import Foundation

class Pet {
    let max_happiness = 100
    let max_fullness = 100
    
    var happiness : Int
    var fullness : Int
    
    init() {
        happiness = 25
        fullness = 25
    }
    
    func feeding(foodVal : Int) {
        fullness += foodVal;
        if fullness > max_fullness {
            fullness = max_fullness
        }
    }
    
    func playing(happyVal : Int) {
        happiness += happyVal
        if happiness > max_happiness {
            happiness = max_happiness
        }
    }
}
