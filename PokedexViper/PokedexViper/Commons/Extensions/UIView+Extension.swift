//
//  UIView+Extension.swift
//  PokedexViper
//
//  Created by Maury on 25/06/22.
//

import UIKit

extension UIView {
    
    static var identifier: String {
        
        String(describing: Self.self)
    }
    
    func anchorTo(parentView: UIView){
        translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(self)
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            topAnchor.constraint(equalTo: parentView.topAnchor),
            trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
            bottomAnchor.constraint(equalTo: parentView.bottomAnchor)
        ])
    }
    
}
