//
//  Hack.swift
//  Practica2 iOS
//
//  Created by Alex Cuevas on 09/11/2018.
//  Copyright © 2018 Alex Cuevas. All rights reserved.
//

import UIKit

class Hack: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{

    @IBOutlet weak var insertText: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    override func viewDidLoad() {
        pickerView.dataSource = self
        pickerView.delegate = self
        super.viewDidLoad()
        putValueIntoInsertText()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        putValueIntoInsertText()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinDictionary.count
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       return coinArray[row]
    }
    
    func putValueIntoInsertText(){
        insertText.text = String(coinDictionary[coinArray[pickerView.selectedRow(inComponent: 0)]]!.value)
    }
    
    func hackingCoinRatio(){
        if(insertText.text != ""){
            coinDictionary[coinArray[pickerView.selectedRow(inComponent: 0)]]!.value = Double(insertText.text!)!
        }
    }
    
    @IBAction func btnChange(_ sender: Any) {
        hackingCoinRatio()
    }
    
}
