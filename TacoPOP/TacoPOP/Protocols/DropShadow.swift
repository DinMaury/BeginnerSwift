//
//  DropShadow.swift
//  TacoPOP
//
//  Created by Maury on 31/05/22.
//

import UIKit

protocol DropShadow {}

extension DropShadow where Self: UIView {
    
    func addDropShadow() {
        
        //Implementation
        layer.shadowColor = .init(gray: 1, alpha: 0.7)
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 5
    }
}
