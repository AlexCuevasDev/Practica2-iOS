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

    @IBOutlet weak var imageHack: UIImageView!
    @IBOutlet weak var lbValue: UILabel!
    @IBOutlet weak var lbCoin: UILabel!
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var imageFlag: UIImageView!
    @IBOutlet weak var lbTotalConversion: UILabel!
    @IBOutlet weak var lbConversion: UILabel!
    @IBOutlet weak var btnConvert: UIButton!
    @IBOutlet weak var insertText: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var coinArray = ["Euro","Dollar","Pounds", "Yen","Tomate"]
    var coinDictionary = [String: Currency]()
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
        initCoins()
    }
    //Initialization of the coins into the dictionary
    func initCoins(){
        coinDictionary[coinArray[0]] = Currency(name: coinArray[0].uppercased(),value: 1,symbol: "E")
        coinDictionary[coinArray[1]] = Currency(name: coinArray[1].uppercased(), value: 0.87, symbol: "D")
        coinDictionary[coinArray[2]] = Currency(name: coinArray[2].uppercased(), value: 1.14, symbol: "P")
        coinDictionary[coinArray[3]] = Currency(name: coinArray[3].uppercased(), value: 0.0077, symbol: "Y")
        coinDictionary[coinArray[4]] = Currency(name: coinArray[4].uppercased(), value: 0.13, symbol: "Y")
    }
    //Calculating the value of the coin using the ratios in the Currency class, then rounding it
    func calc(){
        let coin1 : Currency = coinDictionary[coinArray[pickerView.selectedRow(inComponent: 0)]]!
        let coin2 : Currency = coinDictionary[coinArray[pickerView.selectedRow(inComponent: 1)]]!
        var sol : Double = Double(insertText.text!)! * coin1.value / coin2.value
        sol = sol*100
        sol.round()
        sol = sol/100
        
        lbTotalConversion.text = String(sol)
    }
    
    func initLabels(){
        
        lbConversion.text = "Conversion from \(coinArray[pickerView.selectedRow(inComponent: 0)]) to \(coinArray[pickerView.selectedRow(inComponent: 1)])"
    }

    @IBAction func convertClick(_ sender: Any) {
        initLabels()
        calc()
    }
}

