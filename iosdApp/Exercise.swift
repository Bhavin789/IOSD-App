//
//  Exercise.swift
//  iosdApp
//
//  Created by Bhavin on 21/04/18.
//  Copyright © 2018 Bhavin. All rights reserved.
//

import Foundation

class Exercise: NSObject {
    
    var name: String?
    var tutorialUrl: String?
    var repUrl: String?
    
    init(name: String!, tutorialUrl: String!,repUrl: String!) {
        self.name = name
        self.tutorialUrl = tutorialUrl
        self.repUrl = repUrl
    }
    
}
