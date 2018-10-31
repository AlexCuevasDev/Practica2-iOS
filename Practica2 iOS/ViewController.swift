//
//  ViewController.swift
//  Practica2 iOS
//
//  Created by Alex Cuevas on 24/10/2018.
//right © 2018 Alex Cuevas. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    // TODO DICCIONARIOS CLASES ARRAYS

    @IBOutlet weak var pickerView: UIPickerView!
    var coinArray = ["Euro","Dollar","Pounds", "Yen","Tomate"]
    var coinDictionary = [String: Int]()
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinArray[row]
    }
    
    override func viewDidLoad() {
        pickerView.dataSource = self
        pickerView.delegate = self
        super.viewDidLoad()
        
    }
    
    func initDictionary(){
        for i in coinArray{
            coinDictionary
        }
    }
    
    func initCoins(){
        Currency(name: coinArray[0].uppercased(),value: 1,symbol: "s")
    }

}

