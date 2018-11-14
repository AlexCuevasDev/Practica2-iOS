//
//  Hack.swift
//  Practica2 iOS
//
//  Created by Alex Cuevas on 09/11/2018.
//  Copyright © 2018 Alex Cuevas. All rights reserved.
//

import UIKit

class HackViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate{

    @IBOutlet weak var insertText: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var btnChangeRatio: UIButton!
    
    override func viewDidLoad() {
        pickerView.dataSource = self
        pickerView.delegate = self
        insertText.delegate = self
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
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
        let alert = UIAlertController(title: "Are you sure?", message: "this will change the value of \(coinDictionary[coinArray[pickerView.selectedRow(inComponent: 0)]]!.name) from \(coinDictionary[coinArray[pickerView.selectedRow(inComponent: 0)]]!.value) to \(insertText.text!)", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
            self.hackingCoinRatio()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let aSet = NSCharacterSet(charactersIn:"0123456789.").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        btnChange(btnChangeRatio)
    }
    
}
