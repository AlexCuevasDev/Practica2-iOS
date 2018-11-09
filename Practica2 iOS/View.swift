
//
//  View.swift
//  Practica2 iOS
//
//  Created by Alex Cuevas on 07/11/2018.
//  Copyright © 2018 Alex Cuevas. All rights reserved.
//

import Foundation
import UIKit

class View{
    var flagImage : UIImage
    var backGroundImage : UIImage
    var coin : Currency
    
    
    init(flag: UIImage, back: UIImage, coin: Currency) {
        flagImage = flag
        backGroundImage = back
        self.coin = coin
    }
}
