//
//  PerformedExercise.swift
//  iosdApp
//
//  Created by Bhavin on 21/04/18.
//  Copyright © 2018 Bhavin. All rights reserved.
//

import Foundation

class PerformedExercise: NSObject {
    
    var exercise: Exercise?
    var repCount: Int?
    var repDone: Int?
    
    init(exercise: Exercise!, repCount: Int!, repDone: Int!) {
        self.exercise = exercise
        self.repCount = repCount
        self.repDone = repDone
    }
}
