//
//  ViewController.swift
//  Mather-iOS
//
//  Created by Kevin Springer on 1/15/18.
//  Copyright © 2018 Kevin Springer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, MatherModelDelegate {
    
    @IBOutlet weak var firstNumber: UITextField!
    
    @IBOutlet weak var secondNumberPicker: UIPickerView!
    
    var numberPickerData: [[String]] = [[String]]()
    var secondNumber: [ String: String ] = [ "tens": "1", "ones": "1" ]
    
    @IBOutlet weak var responseField: UILabel!
    
    let model: MatherModel = MatherModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.model.delegate = self
        
        self.secondNumberPicker.delegate = self
        self.secondNumberPicker.dataSource = self
        
        numberPickerData = [["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"], ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberPickerData[component].count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return numberPickerData[component][row]
    }

    // Capture the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        if component == 0 {
            secondNumber["tens"] = numberPickerData[component][row]
        } else if component == 1 {
            secondNumber["ones"] = numberPickerData[component][row]
        }
    }
    
    @IBAction func submitButton(_ sender: UIButton) {
        if let firstInput = firstNumber.text {
            let inputA = Int(firstInput)
            let inputB = Int(secondNumber["tens"]!)! * 10 + Int(secondNumber["ones"]!)!
            if inputA != nil {
                model.addem(num1: inputA!, num2: inputB)
                
                self.view.endEditing(true) // this will hide the keyboard on submit
            }
        }
    }
    
    func dataReady() {
        responseField.text = String(self.model.total!)
        self.responseField.reloadInputViews()
    }
    
    // The next two functions allow a tap outside the keyboard area to dismiss the keyboard
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleSingleTap))
        tapRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapRecognizer)
    }

    @objc func handleSingleTap(recognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
}

