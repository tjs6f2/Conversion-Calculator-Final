//
//  Converter.swift
//  Conversion Calculator
//
//  Created by Thomas Schultz on 4/12/18.
//  Copyright © 2018 array. All rights reserved.
//

import Foundation

struct Converter {

    var inputUnit: String
    var outputUnit: String

    var label: String {
        get {
            return inputUnit + " to " + outputUnit
        }
    }

}
