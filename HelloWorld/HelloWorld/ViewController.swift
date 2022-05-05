//
//  ViewController.swift
//  HelloWorld
//
//  Created by Maury on 24/04/22.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var TitleHello: UIImageView!
    
    @IBOutlet weak var WelcomeButton: UIButton!
    
    @IBOutlet weak var Fondo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        TitleHello.isHidden = true
        WelcomeButton.isHidden = false
        Fondo.isHidden = true
    }

    @IBAction func PressButton(_ sender: Any) {
        TitleHello.isHidden = false
        WelcomeButton.isHidden = true
        Fondo.isHidden = false
    }
    
}

