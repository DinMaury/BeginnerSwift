//
//  RoundedShadowButton.swift
//  htchhkr - development
//
//  Created by Maury on 21/06/22.
//

import UIKit

class RoundedShadowButton: UIButton {

    var originalSize: CGRect?
    
    func setupView() {
        
        originalSize = self.frame
        
        self.layer.cornerRadius = 5.0
        self.layer.shadowRadius = 10.0
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize.zero
    }
    
    override func awakeFromNib() {
        setupView()
    }
    
    func animateButton(shouldLoad: Bool, withMessage message: String?, widthConstraint: NSLayoutConstraint) {
        
        let spinner = UIActivityIndicatorView()
        spinner.style = UIActivityIndicatorView.Style.large
        spinner.color = UIColor.darkGray
        spinner.alpha = 0.0
        spinner.hidesWhenStopped = true
        spinner.tag = 21
        
        if shouldLoad {
            
            self.addSubview(spinner)
            
            self.setTitle("", for: .normal)
            UIView.animate(withDuration: 0.2, animations: {
                
                let diametroCircle = self.frame.height
                widthConstraint.constant = diametroCircle
                self.layoutIfNeeded()
                self.layer.cornerRadius = self.frame.height / 2
                
            }, completion: { (finished) in
                
                if finished == true {
                    
                    spinner.startAnimating()
                    spinner.center = CGPoint(x: self.frame.width / 2 + 1, y: self.frame.width / 2 + 1)
                    UIView.animate(withDuration: 0.2, animations: {
                        spinner.alpha = 1.0
                    })
                }
            })
            
            self.isUserInteractionEnabled = false
            
        } else {
            
            self.isUserInteractionEnabled = true
            
            for subview in self.subviews {
                
                if subview.tag == 21 {
                    
                    subview.removeFromSuperview()
                }
            }
            
            UIView.animate(withDuration: 0.2, animations: {
                
                self.layer.cornerRadius = 5.0
                self.frame = self.originalSize!
                self.setTitle(message, for: .normal)
            })
        }
    }

}
