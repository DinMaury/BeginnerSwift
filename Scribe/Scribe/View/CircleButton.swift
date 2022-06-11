//
//  CircleButton.swift
//  Scribe
//
//  Created by Maury on 9/06/22.
//

import UIKit

@IBDesignable

class CircleButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 30.0 {
        didSet{
            setupView()
        }
    }
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = cornerRadius
    }

}
