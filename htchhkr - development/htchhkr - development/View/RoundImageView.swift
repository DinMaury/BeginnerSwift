//
//  RoundImageView.swift
//  htchhkr - development
//
//  Created by Maury on 20/06/22.
//

import UIKit

class RoundImageView: UIImageView {
    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }

}
