//
//  ViewController.swift
//  MiraclePill
//
//  Created by Maury on 26/04/22.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let statesPickerView: [String] = ["Medellin", "Bello", "Sabaneta", "Envigado", "Itagui", "La estrella"]
    let pricePill = 150
    @IBOutlet weak var statePicker: UIPickerView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var stateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        statePicker.delegate = self
        statePicker.dataSource = self
        priceLabel.text = "$\(pricePill)"
    }

    @IBAction func clicButtonState(_ sender: Any) {
        statePicker.isHidden = !statePicker.isHidden
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return statesPickerView.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return statesPickerView[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        stateButton.setTitle(statesPickerView[row], for: UIControl.State())
        statePicker.isHidden = true
        
    }
}

