//
//  CustomShowView.swift
//  stacksViewTest
//
//  Created by Jhonatan Pulgarin Arias on 3/05/22.
//

import UIKit

class CustomShowView: UIView {
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var buttonView: UIButton!
        
    var didTouchCallback: (() -> Void)?
    
    // MARK: - Obligatorio en todos los XIBs
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        //we 're going to do stuff here
        Bundle.main.loadNibNamed("CustomShowView", owner: self, options: nil)
        guard let view = UINib(nibName: "CustomShowView", bundle: Bundle.main).instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        addSubview(view)
        view.fixInView(self)
    }
    
    // MARK: --------------
        
    func setup(imageName: String) {
        imgView.image = .init(named: imageName)
    }
    
    
    @IBAction func didTouch(_ sender: Any) {
        didTouchCallback?()
    }
}

extension UIView {
    func fixInView(_ parentView: UIView) -> Void{
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            topAnchor.constraint(equalTo: parentView.topAnchor),
            trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
            bottomAnchor.constraint(equalTo: parentView.bottomAnchor)
        ])
    }
}
