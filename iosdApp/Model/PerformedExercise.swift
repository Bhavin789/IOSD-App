//
//  PerformedExercise.swift
//  iosdApp
//
//  Created by Bhavin on 21/04/18.
//  Copyright © 2018 Bhavin. All rights reserved.
//

import Foundation

class PerformedExercise: NSObject {
    
    var name: String?
    var repCount: Int?
    var repDone: Int?
    
    init(name: String!, repCount: Int!, repDone: Int!) {
        self.name = name
        self.repCount = repCount
        self.repDone = repDone
    }
}
