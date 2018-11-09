//
//  ViewController.swift
//  Practica2 iOS
//
//  Created by Alex Cuevas on 24/10/2018.
//right © 2018 Alex Cuevas. All rights reserved.
//

import UIKit
//global vars so the hack.viewcontroller can see them
var coinDictionary = [String: Currency]()
var coinArray = ["Euro","Dollar","Pound", "Yen","BitCoin"] 

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

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
        calc()
    }
    //I have a counter of ViewDidLoad because when you go to the other view with the hack and come back it loads it again
    override func viewDidLoad() {
        position = 0
        insertText.text = "0"
        btnHack.isHidden = true
        pickerView.dataSource = self
        pickerView.delegate = self
        super.viewDidLoad()    
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
        coinDictionary[coinArray[4]] = Currency(name: coinArray[4].uppercased(), value: 5602.47, symbol: "₿")
    }
    //Initialization of the views into the array
    func initViews(){
        viewArray.append(View(flag: UIImage(named: "europeFlag")!, back: UIImage(named: "bridge")!, coin: coinDictionary["Euro"]!))
        viewArray.append(View(flag: UIImage(named: "usaFlag")!, back: UIImage(named: "cars")!, coin: coinDictionary["Dollar"]!))
        viewArray.append(View(flag: UIImage(named: "ukFlag")!, back: UIImage(named: "metro")!, coin: coinDictionary["Pound"]!))
        viewArray.append(View(flag: UIImage(named: "japanFlag")!, back: UIImage(named: "citySkyBlack")!, coin: coinDictionary["Yen"]!))
       viewArray.append(View(flag: UIImage(named: "bitCoin")!, back: UIImage(named: "road")!, coin: coinDictionary["BitCoin"]!))
    }
    
    //Checks if the Insert Texts is not empty then calculates the value of the coin using the ratios in the Currency class, afterwards rounding it
    func calc(){
        if(insertText != ""){
        initConvertionLabels() //Writes the labels
            
        let coin1 : Currency = coinDictionary[coinArray[pickerView.selectedRow(inComponent: 0)]]!
        let coin2 : Currency = coinDictionary[coinArray[pickerView.selectedRow(inComponent: 1)]]!
        var sol : Double = Double(insertText.text!)! * coin1.value / coin2.value
        sol = sol*100 //Move two 0s to the left
        sol.round() //round without decimals
        sol = sol/100 //Move two 0s to the right
        
        lbTotalConversion.text = String(sol)
        }
    }
    
    func initConvertionLabels(){
        
        lbConversion.text = "Conversion from \(coinArray[pickerView.selectedRow(inComponent: 0)]) to \(coinArray[pickerView.selectedRow(inComponent: 1)])"
    }
    //When the button to exchange the coins is clicked, checks if the user has inputted the hack code
    @IBAction func convertClick(_ sender: Any) {
        if(insertText.text == "999"){
            btnHack.isHidden = false
        }else{
            calc()
        }
    }
    //Changes the background,main images and value of the coin using the properties of a View object
    //which is selected based on the var position and the viewArray
    func changeView(view : View){
        imageBackground.image = view.backGroundImage
        imageFlag.image = view.flagImage
        lbValue.text = String(view.coin.value)
    }
    //Changes the var position, and calls the changeView method to change the whole view
    //if the position reaches the end of the array it starts over
    @IBAction func btnNext(_ sender: Any) {
        if (position < viewArray.count-1){
            position += 1
            changeView(view: viewArray[position])
        }else {
            position = 0
            changeView(view: viewArray[position])
        }
    }
    //Changes the var position, and calls the changeView method to change the whole view
    //if the position reaches the end of the array it starts over
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

