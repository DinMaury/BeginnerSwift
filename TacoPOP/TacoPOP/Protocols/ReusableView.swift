//
//  ReusableView.swift
//  TacoPOP
//
//  Created by Maury on 4/06/22.
//

import UIKit

protocol ReusableView: AnyObject {}

extension ReusableView where Self: UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
