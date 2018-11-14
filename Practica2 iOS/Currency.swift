//
//  Currency.swift
//  Practica2 iOS
//
//  Created by Alex Cuevas on 31/10/2018.
//  Copyright © 2018 Alex Cuevas. All rights reserved.
//

import Foundation
import os.log

class Currency: NSObject, NSCoding{
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: Data.dataName)
        aCoder.encode(value, forKey: Data.dataValue)
        aCoder.encode(symbol, forKey: Data.dataSymbol)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let nameCoder = aDecoder.decodeObject(forKey: Data.dataName) as? String else {
            os_log("Unable to decode the name for the Currency object.", log: OSLog.default, type: .debug)
            return nil
        }
         guard let valueCoder = aDecoder.decodeObject(forKey: Data.dataValue) as? Double else {
            os_log("Unable to decode the value for the Currency object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let symbolCoder = aDecoder.decodeObject(forKey: Data.dataValue) as? Character else {
            os_log("Unable to decode the value for the Currency object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        self.init(name: nameCoder,value: valueCoder,symbol: symbolCoder)
    }
    
    var name : String
    var value : Double
    var symbol : Character
    
    init (name : String, value : Double, symbol : Character){
        self.name = name
        self.value = value
        self.symbol = symbol
    }
    
    struct Data {
        static var dataName : String = "name"
        static var dataValue : String = "value"
        static var dataSymbol : String = "symbol"
    }
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("coins")
}
