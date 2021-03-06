//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Maury on 6/05/22.
//

import UIKit
import AVFoundation

let imgButtons: [String] = ["7", "8", "9", "4", "5", "6", "1", "2", "3", "0", "divide", "multiply", "subtract", "add", "equal"]

class ViewController: UIViewController {
    
    @IBOutlet weak var labelToWrite: UILabel!
    
    @IBOutlet var buttonsShowView: [ButtonsShowView]!
    
    // Funcion de operaciones Calculator
    func operationCalculator (num1: Double, num2: Double, opCal: String) -> (Double,String) {
        switch opCal {
        case "+":
            return (num1 + num2, opCal)
        case "-":
            return (num1 - num2, opCal)
        case "*":
            return (num1 * num2, opCal)
        case "/":
            guard num2 != 0.0 else {
                return (0,"Error!")
            }
            return (num1 / num2, opCal)
        default:
            return (num1, opCal)
        }
    }
    
    // Funcion de sonido
    func playSound () {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    var btnSound: AVAudioPlayer!
        override func viewDidLoad() {
        super.viewDidLoad()
        
            for i in 0..<imgButtons.count {
            buttonsShowView[i].setup(imageName: imgButtons[i])
            }
            
            let path = Bundle.main.path(forResource: "btn", ofType: "wav")
            let soundURL = URL(fileURLWithPath: path!)
            
            do {
                try btnSound = AVAudioPlayer(contentsOf: soundURL)
                btnSound.prepareToPlay()
            } catch let err as NSError {
                print(err.debugDescription)
            }
            
            var resultado: Double = 0
            var resultadoString: String = ""
            var operando: Double = 0
            var opCal: String = ""
            // Numbers buttons
            for j in 0..<10 {
                buttonsShowView[j].didTouchCallback = {
                    self.playSound()
                    guard self.labelToWrite.text != "0" else {
                        resultadoString = ""
                        self.labelToWrite.text = resultadoString
                        return
                    }
                    self.labelToWrite.text = resultadoString
                    self.labelToWrite.text = (self.labelToWrite.text ?? "") + imgButtons[j]
                    resultadoString = self.labelToWrite.text ?? ""
                    resultado = Double(resultadoString) ?? 0
                }
                // Divide
                buttonsShowView[10].didTouchCallback = {
                    self.playSound()
                    guard self.labelToWrite.text != "" else {
                        return
                    }
                    guard operando != 0 else {
                        opCal = "/"
                        resultadoString = self.labelToWrite.text ?? ""
                        operando = Double(resultadoString) ?? 0
                        resultado = Double(resultadoString) ?? 0
                        resultadoString = ""
                        return
                    }
                    resultadoString = self.labelToWrite.text ?? ""
                    resultado = Double(resultadoString) ?? 0
                    (operando, opCal) = self.operationCalculator(num1: operando, num2: resultado, opCal: opCal)
                    guard opCal != "Error!" else {
                        self.labelToWrite.text = "Error!"
                        resultadoString = ""
                        resultado = 0
                        operando = 0
                        return
                    }
                    resultadoString = String(operando)
                    self.labelToWrite.text = resultadoString
                    resultadoString = ""
                    opCal = "/"
                }
                // Multiply
                buttonsShowView[11].didTouchCallback = {
                    self.playSound()
                    guard self.labelToWrite.text != "" else {
                        return
                    }
                    guard operando != 0 else {
                        opCal = "*"
                        resultadoString = self.labelToWrite.text ?? ""
                        operando = Double(resultadoString) ?? 0
                        resultado = Double(resultadoString) ?? 0
                        resultadoString = ""
                        return
                    }
                    resultadoString = self.labelToWrite.text ?? ""
                    resultado = Double(resultadoString) ?? 0
                    (operando, opCal) = self.operationCalculator(num1: operando, num2: resultado, opCal: opCal)
                    resultadoString = String(operando)
                    self.labelToWrite.text = resultadoString
                    resultadoString = ""
                    opCal = "*"
                }
                // Subtract
                buttonsShowView[12].didTouchCallback = {
                    self.playSound()
                    guard self.labelToWrite.text != "" else {
                        return
                    }
                    guard operando != 0 else {
                        opCal = "-"
                        resultadoString = self.labelToWrite.text ?? ""
                        operando = Double(resultadoString) ?? 0
                        resultado = Double(resultadoString) ?? 0
                        resultadoString = ""
                        return
                    }
                    resultadoString = self.labelToWrite.text ?? ""
                    resultado = Double(resultadoString) ?? 0
                    (operando, opCal) = self.operationCalculator(num1: operando, num2: resultado, opCal: opCal)
                    resultadoString = String(operando)
                    self.labelToWrite.text = resultadoString
                    resultadoString = ""
                    opCal = "-"
                }
                // Add
                buttonsShowView[13].didTouchCallback = {
                    self.playSound()
                    guard self.labelToWrite.text != "" else {
                        return
                    }
                    guard operando != 0 else {
                        opCal = "+"
                        resultadoString = self.labelToWrite.text ?? ""
                        operando = Double(resultadoString) ?? 0
                        resultado = Double(resultadoString) ?? 0
                        resultadoString = ""
                        return
                    }
                    resultadoString = self.labelToWrite.text ?? ""
                    resultado = Double(resultadoString) ?? 0
                    (operando, opCal) = self.operationCalculator(num1: operando, num2: resultado, opCal: opCal)
                    resultadoString = String(operando)
                    self.labelToWrite.text = resultadoString
                    resultadoString = ""
                    opCal = "+"
                }
                // Equal
                buttonsShowView[14].didTouchCallback = {
                    self.playSound()
                    guard self.labelToWrite.text != "" else {
                        return
                    }
                    guard operando != 0 else {
                        resultadoString = self.labelToWrite.text ?? ""
                        operando = Double(resultadoString) ?? 0
                        resultado = Double(resultadoString) ?? 0
                        resultadoString = ""
                        return
                    }
                    resultadoString = self.labelToWrite.text ?? ""
                    resultado = Double(resultadoString) ?? 0
                    (operando, opCal) = self.operationCalculator(num1: operando, num2: resultado, opCal: opCal)
                    guard opCal != "Error!" else {
                        self.labelToWrite.text = "Error!"
                        resultadoString = ""
                        resultado = 0
                        operando = 0
                        return
                    }
                    resultadoString = String(operando)
                    self.labelToWrite.text = resultadoString
                    opCal = ""
                    resultadoString = ""
                    resultado = 0
                }
        }
    }
}
