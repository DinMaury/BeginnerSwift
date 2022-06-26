//
//  LeftSidePanelVC.swift
//  htchhkr - development
//
//  Created by Maury on 24/06/22.
//

import UIKit

class LeftSidePanelVC: UIViewController {
    
    @IBInspectable override var restorationIdentifier: String? {
        didSet{
            setupView()
            
        }
    }
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func setupView() {
        self.restorationIdentifier = restorationIdentifier
    }
}
