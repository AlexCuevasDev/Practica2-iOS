//
//  Currency.swift
//  Practica2 iOS
//
//  Created by Alex Cuevas on 31/10/2018.
//  Copyright © 2018 Alex Cuevas. All rights reserved.
//

import Foundation

class Currency: CustomStringConvertible{
    public var description: String { return "\(name) \(symbol)" }
    
    var name : String
    var value : Double
    var symbol : Character
    
    init (name : String, value : Double, symbol : Character){
        self.name = name
        self.value = value
        self.symbol = symbol
    }
}
