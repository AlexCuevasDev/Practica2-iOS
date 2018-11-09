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
    
    var viewArray : [View] = []
    var coinArray = ["Euro","Dollar","Pounds", "Yen","WoWToken"]
    //Así con el WoW Token puedes mirar cuanto gastaste en tu vida universitaria ^^
    var coinDictionary = [String: Currency]()
    var position : Int
    
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
        initViews()
        imageBackground.image = viewArray[0].backGroundImage
  /*      let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageHack.isUserInteractionEnabled = true */
    }
    //Initialization of the coins into the dictionary
    func initCoins(){
        coinDictionary[coinArray[0]] = Currency(name: coinArray[0].uppercased(),value: 1,symbol: "€")
        coinDictionary[coinArray[1]] = Currency(name: coinArray[1].uppercased(), value: 0.87, symbol: "$")
        coinDictionary[coinArray[2]] = Currency(name: coinArray[2].uppercased(), value: 1.14, symbol: "£")
        coinDictionary[coinArray[3]] = Currency(name: coinArray[3].uppercased(), value: 0.0077, symbol: "¥")
        coinDictionary[coinArray[4]] = Currency(name: coinArray[4].uppercased(), value: 20, symbol: "W")
    }
    
    func initViews(){
        viewArray.append(View(flag: UIImage(named: "europeFlag")!, back: UIImage(named: "bridge")!, coin: coinDictionary["Euro"]!))
        viewArray.append(View(flag: UIImage(named: "usaFlag")!, back: UIImage(named: "cars")!, coin: coinDictionary["Dollar"]!))
        viewArray.append(View(flag: UIImage(named: "ukFlag")!, back: UIImage(named: "metro")!, coin: coinDictionary["Pound"]!))
        viewArray.append(View(flag: UIImage(named: "japanFlag")!, back: UIImage(named: "citySkyBlack")!, coin: coinDictionary["Yen"]!))
        viewArray.append(View(flag: UIImage(named: "wowLogo")!, back: UIImage(named: "road")!, coin: coinDictionary["WoWToken"]!))
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
    
    func initConvertionLabels(){
        
        lbConversion.text = "Conversion from \(coinArray[pickerView.selectedRow(inComponent: 0)]) to \(coinArray[pickerView.selectedRow(inComponent: 1)])"
    }

    @IBAction func convertClick(_ sender: Any) {
        if(insertText.text != ""){
            if(insertText.text == "999"){
                
            }
        initConvertionLabels()
        calc()
        }
    }
    @IBAction func btnNext(_ sender: Any) {
        
    }
    @IBAction func btnBefore(_ sender: Any) {
    }
    
  /*  @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
       let tappedImage = tapGestureRecognizer.view as! UIImageView
        
    } */
}

