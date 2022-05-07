//
//  ButtonsShowView.swift
//  RetroCalculator
//
//  Created by Maury on 6/05/22.
//

import UIKit

class ButtonsShowView: UIView {
    
    @IBOutlet weak var buttonToView: UIButton!
    
    @IBOutlet weak var imgViewButton: UIImageView!
    
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
        Bundle.main.loadNibNamed("ButtonsShowView", owner: self, options: nil)
        guard let view = UINib(nibName: "ButtonsShowView", bundle: Bundle.main).instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        addSubview(view)
        view.fixInView(self)
    }
    
    // MARK: --------------
        
    func setup(imageName: String) {
        imgViewButton.image = .init(named: imageName)
    }

    @IBAction func clicToButtonView(_ sender: Any) {
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
