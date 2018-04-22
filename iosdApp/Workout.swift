//
//  Workout.swift
//  iosdApp
//
//  Created by Bhavin on 22/04/18.
//  Copyright © 2018 Bhavin. All rights reserved.
//

import Foundation

class Workout: NSObject{
    var workoutNumber: Int?
    var exercises: [Exercise]?
    
    override init() {
        self.workoutNumber = 1
        
    }
}
