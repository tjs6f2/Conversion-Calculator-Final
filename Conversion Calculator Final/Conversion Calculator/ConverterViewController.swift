//
//  ConverterViewController.swift
//  Conversion Calculator
//
//  Created by Thomas Schultz on 4/11/18.
//  Copyright © 2018 array. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController {

    var converters = [Converter]()
    
    var currentConverter = 0

    let alert = UIAlertController(title: "Choose Converter", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)

    @IBOutlet weak var inputDisplay: UITextField!
    @IBOutlet weak var outputDisplay: UITextField!

    override func viewDidLoad() {

        super.viewDidLoad()

        converters = [
            Converter(inputUnit: "°F", outputUnit: "°C"),
            Converter(inputUnit: "°C", outputUnit: "°F"),
            Converter(inputUnit: "mi", outputUnit: "km"),
            Converter(inputUnit: "km", outputUnit: "mi")
        ]
        
        for (index, converter) in converters.enumerated() {
            alert.addAction(UIAlertAction(title: converter.label, style: .default, handler: {
                (alertAction) -> Void in
                self.currentConverter = index
                self.inputDisplay.placeholder = converter.inputUnit
                self.outputDisplay.placeholder = converter.outputUnit
                self.updateTextField()
            }))
        }

        inputDisplay.placeholder = converters[0].inputUnit
        outputDisplay.placeholder = converters[0].outputUnit

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func converterButtonTapped(_ sender: UIButton) {
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func onClear(_ sender: UIButton) {
        inputDisplay.text = nil
        outputDisplay.text = nil
    }

    @IBAction func toggleSign() {
        if let text = inputDisplay.text,
            var inputAsDouble = Double(text) {
            inputAsDouble *= -1
            inputDisplay.text = "\(inputAsDouble)"
            updateTextField()
        } else {
            inputDisplay.text = "-"
            outputDisplay.text = "-"
        }
    }

    @IBAction func numberButtonTapped(_ sender: UIButton) {
        inputDisplay.text?.append(sender.currentTitle!)
        updateTextField()
    }

    func milesToKilometers(_ miles: Double) -> Double {
        return 1.61 * miles
    }

    func kilometersToMiles(_ kilometers: Double) -> Double {
        return 0.62 * kilometers
    }

    func cToF(_ celcius: Double) -> Double {
        return celcius * (9/5) + 32
    }

    func fToC(_ fahrenheit: Double) -> Double {
        return (fahrenheit - 32) * (5/9)
    }

    func updateTextField() {
        
        if let text = inputDisplay.text,
            let input = Double(text) {

            var output: Double

            switch currentConverter {
                case 0:
                    output = fToC(input)
                case 1:
                    output = cToF(input)
                case 2:
                    output = milesToKilometers(input)
                case 3:
                    output = kilometersToMiles(input)
                default:
                    return
            }

            outputDisplay.text = "\(output)"

        }

    }

}

