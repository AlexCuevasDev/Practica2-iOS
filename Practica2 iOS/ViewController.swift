//
//  ViewController.swift
//  Practica2 iOS
//
//  Created by Alex Cuevas on 24/10/2018.
//right © 2018 Alex Cuevas. All rights reserved.
//

import UIKit
//global vars so the hack.viewcontroller can see them
var coinDictionary = [coinArray[0] : Currency(name: coinArray[0].uppercased(),value: 1.0, symbol: "€"),
                      coinArray[1] : Currency(name: coinArray[1].uppercased(), value: 0.87, symbol: "$"), coinArray[2] : Currency(name: coinArray[2].uppercased(), value: 1.14, symbol: "£"), coinArray[3] : Currency(name: coinArray[3].uppercased(), value: 0.0077, symbol: "¥"),coinArray[4] : Currency(name: coinArray[4].uppercased(), value: 5602.47, symbol: "₿")] as [String:Currency]

var coinArray = ["Euro","Dollar","Pound", "Yen","BitCoin"]

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {

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
    
    var viewArray : [View] = [View(flag: UIImage(named: "europeFlag")!, back: UIImage(named: "paris")!, coin: coinDictionary["Euro"]!), View(flag: UIImage(named: "usaFlag")!, back: UIImage(named: "cars")!, coin: coinDictionary["Dollar"]!),View(flag: UIImage(named: "ukFlag")!, back: UIImage(named: "metro")!, coin: coinDictionary["Pound"]!),View(flag: UIImage(named: "japanFlag")!, back: UIImage(named: "citySkyBlack")!, coin: coinDictionary["Yen"]!),View(flag: UIImage(named: "bitCoin")!, back: UIImage(named: "road")!, coin: coinDictionary["BitCoin"]!)]
    
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

    override func viewDidLoad() {
        position = 0
        insertText.text = "0"
        
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        btnHack.isHidden = true
        pickerView.dataSource = self
        pickerView.delegate = self
        insertText.delegate = self

        changeView(view: viewArray[0])
        calc()
    }
    
    //Checks if the Insert Texts is not empty then calculates the value of the coin using the ratios in the Currency class, afterwards rounding it
    func calc(){
        if(insertText.text != ""){
        initConvertionLabels() //Writes the labels
            
        let coin1 : Currency = coinDictionary[coinArray[pickerView.selectedRow(inComponent: 0)]]!
        let coin2 : Currency = coinDictionary[coinArray[pickerView.selectedRow(inComponent: 1)]]!
        var sol : Double = Double(insertText.text!)! * coin1.value / coin2.value
        sol = sol*100 //Move two 0s to the left
        sol.round() //round to a number without decimals
        sol = sol/100 //Move two 0s to the right
        
        lbTotalConversion.text = String(sol)
        }
    }
    
    //Fills the label with text
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
        lbValue.text = "\(view.coin.name): \(view.coin.value)"
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
    //This method controls the input options of the user to the TextField using its Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let aSet = NSCharacterSet(charactersIn:"0123456789.").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        convertClick(btnConvert)
    }
    
    private func saveCoins(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(coinDictionary.values, toFile: Currency.ArchiveURL.path)
        if isSuccessfulSave {
            print("Coins successfully saved.")
        } else {
            print("Failed to save coins...")
        }
    }
    
    private func loadCoins() -> [Currency]?{
        return NSKeyedUnarchiver.unarchiveObject(withFile: Currency.ArchiveURL.path) as? [Currency]
    }
    
    
}

