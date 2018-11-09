//
//  ViewController.swift
//  Practica2 iOS
//
//  Created by Alex Cuevas on 24/10/2018.
//right © 2018 Alex Cuevas. All rights reserved.
//

import UIKit

var coinDictionary = [String: Currency]()
var coinArray = ["Euro","Dollar","Pound", "Yen","BitCoin"] //Le paso el array de Strings también porque en la otra view no deja coger los strings del diccionario con coinDictionary.keys

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    // TODO DICCIONARIOS CLASES ARRAYS



    @IBOutlet weak var btnHack: UIButton!
    @IBOutlet weak var lbValue: UILabel!
    @IBOutlet weak var lbCoin: UILabel!
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var imageFlag: UIImageView!
    @IBOutlet weak var lbTotalConversion: UILabel!
    @IBOutlet weak var lbConversion: UILabel!
    @IBOutlet weak var btnConvert: UIButton!
    @IBOutlet weak var insertText: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    var viewDidLoadCounter : Int = 0

    var viewArray : [View] = []
    var position : Int = 0
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //para que detecte cuando se mueve el pickerview
    }
    
    override func viewDidLoad() {
        position = 0
        pickerView.dataSource = self
        pickerView.delegate = self
        super.viewDidLoad()
        btnHack.isHidden = true
        if(viewDidLoadCounter == 0){
            initCoins()
            initViews()
        }
        changeView(view: viewArray[0])

        viewDidLoadCounter += 1
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
       viewArray.append(View(flag: UIImage(named: "bitCoin")!, back: UIImage(named: "road")!, coin: coinDictionary["BitCoin"]!))
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
                btnHack.isHidden = false
            }else{
        initConvertionLabels()
        calc()
            }
        }
    }
    
    func changeView(view : View){
        imageBackground.image = view.backGroundImage
        imageFlag.image = view.flagImage
        lbValue.text = String(view.coin.value)
    }
    
    @IBAction func btnNext(_ sender: Any) {
        if (position < viewArray.count-1){
            position += 1
            changeView(view: viewArray[position])
        }else {
            position = 0
            changeView(view: viewArray[position])
        }
    }
    @IBAction func btnBefore(_ sender: Any) {
        if (position > 0){
            position -= 1
            changeView(view: viewArray[position])
        }else {
            position = viewArray.count-1
            changeView(view: viewArray[position])
        }
    }

}

