//
//  ViewController.swift
//  Propina Viajera
//
//  Created by Maury on 18/04/22.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, XMLParserDelegate {
    
    let currencyFormatter = NumberFormatter()
    
    let availabelCurrencies = ["EUR", "GBP", "USD", "MXN", "JPY", "BRL"]
    
    var currencyConversions: [String:Double] = [:]
    
    var selectedCurrency: String = ""
    
    @IBOutlet weak var billTextField: UITextField!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var tipSegmentedControl: UISegmentedControl!
    
    var devicePriceLabel : String = "EUR"
    
    @IBOutlet weak var localPriceLabel: UILabel!
    
    @IBOutlet weak var currencyTypePickerView: UIPickerView!
    
    
    @IBOutlet weak var tipTextLabel: UILabel!
    
    override var prefersStatusBarHidden: Bool{
        return true
    } // Desabilitar la visualizacion de la hora
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let locale = Locale.current // Obtener toda la informacion de geolocalizacion de donde esta el dispositivo
        devicePriceLabel = locale.currencySymbol! // obtener el simbolo de la moneda local
        
        currencyFormatter.numberStyle = .currency
        resetLabels()
        // Do any additional setup after loading the view.
        currencyTypePickerView.delegate = self
        currencyTypePickerView.dataSource = self
        billTextField.delegate = self
        
        for currecy in availabelCurrencies {
            currencyConversions[currecy] = 1.00
        }
        selectedCurrency = availabelCurrencies.first!
        
        // Conexion al XML
        let url = URL(string: "https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error ?? "Error desconocido")
            } else {
                let xmlParser = XMLParser(data: data!)
                xmlParser.delegate = self
                xmlParser.parse()
                print("parsed Complete")
            }
        }
        task.resume()
        
        // Conexion del elemento "tipTextLabel" al archivo de traduccion
        tipTextLabel.text = NSLocalizedString("MainView.TipText", comment: "Esta es la palabra propina no el valor de la propina que tiene que dejar el usuario")
    }
    
    @IBAction func tipRateChange(_ sender: UISegmentedControl) {
        calculateTipAndTotal()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        calculateTipAndTotal()
    }//delegate y datasour
    
    func calculateTipAndTotal() {
        resetLabels()
        guard let billString = billTextField.text, let billValue = Double(billString) else { return }
        //let tipRatio = (tipSegmentedControl.selectedSegmentIndex + 1) * 5
        let tipRatio = tipSegmentedControl.titleForSegment(at: tipSegmentedControl.selectedSegmentIndex) //obtiene las etiquetas del segmentedControl
        var valorString = ""
        var tip: Double = 0.0
        
        for i in tipRatio! {
            if UInt(String(i)) != nil { //Validacion de poder convertir a Int
                valorString.append(i)
            }
        }
        tip = Double(valorString)! / 100.0 * billValue
        
        let total = billValue + tip
        
        tipLabel.text = currencyFormatter.string(from: NSNumber(value: tip)) // Formato numero
        totalLabel.text = currencyFormatter.string(from: NSNumber(value: total)) // Formato numero
        
        localPriceLabel.text = String(format:"\(selectedCurrency) %.2f", total * currencyConversions[selectedCurrency]!) // Formato de dos decimales
    }
    
    func resetLabels() {
        tipLabel.text = currencyFormatter.string(from: NSNumber(value: 0.00)) // Formato para 0.00
        totalLabel.text = currencyFormatter.string(from: NSNumber(value: 0.00)) // Formato para 0.00
        localPriceLabel.text = "\(selectedCurrency) 0.00"
    }
    // MARK: Picker view Delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    } // Cantidad de columnas en el PickerView
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return availabelCurrencies.count
    } // Cantidad de filas en el PickerView
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return availabelCurrencies[row]
    }// Elementos del PickerView para mostrar
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCurrency = availabelCurrencies[row]
        print("Hemos seleccionado la divisa \(selectedCurrency)")
        calculateTipAndTotal()
    }// Funcion para hacer cuando se selecciona un elemento en el PickerView
    
    //MARK: XMLParserDelegate
    var elementName = ""
    var elementDicName = ""
    var usefulCurrency = ""
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        self.elementName = elementName
        
        if attributeDict["currency"] != nil {
            self.elementDicName = attributeDict["currency"]!
            print("Moneda: \(attributeDict["currency"]!)")
        } else {
            self.elementDicName = ""
        }
        if attributeDict["rate"] != nil {
            self.usefulCurrency = attributeDict["rate"]!
            print("Precio: \(attributeDict["rate"]!)")
            if availabelCurrencies.contains(self.elementDicName) {
                self.currencyConversions[self.elementDicName] = Double(attributeDict["rate"]!)
            }
        } else {
            self.usefulCurrency = ""
        }
    }
}

