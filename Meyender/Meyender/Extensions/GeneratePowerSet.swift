//
//  generatePowerSet.swift
//  Meyender
//
//  Created by Varun Gupta on 15/03/2020.
//  Copyright © 2020 Varun Gupta. All rights reserved.
//

import Foundation
func generatePowerSet(exercises: [Activity]) -> [Activity] {
    guard let ex1 = exercises.randomElement(), let ex2 = exercises.randomElement(),let ex3 = exercises.randomElement() else {
        return []
    }
    
    return [ex1,ex2,ex3]
}
