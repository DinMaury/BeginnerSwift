//
//  NibLoadableView.swift
//  TacoPOP
//
//  Created by Maury on 4/06/22.
//

import UIKit

protocol NibLoadableView: AnyObject {}

extension NibLoadableView where Self: UIView {
    
    static var nibName: String {
        return String(describing: self)
    }
}
