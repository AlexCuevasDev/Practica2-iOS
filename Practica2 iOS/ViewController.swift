//
//  ViewController.swift
//  Practica2 iOS
//
//  Created by Alex Cuevas on 24/10/2018.
//right © 2018 Alex Cuevas. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    

    @IBOutlet weak var pickerView: UIPickerView!
    var monedas = ["Euro","Dollar","Yen","Tomate"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return monedas.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return monedas[row]
    }
    
    override func viewDidLoad() {
        pickerView.dataSource = self
        pickerView.delegate = self
        super.viewDidLoad()
    }

}

