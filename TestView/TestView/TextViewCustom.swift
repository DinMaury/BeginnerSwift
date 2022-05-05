//
//  TextViewCustom.swift
//  TestView
//
//  Created by Jhonatan Pulgarin Arias on 4/05/22.
//

import UIKit

class TextViewCustom: UIView {
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializate()
    }
    
    private func initializate() {
        Bundle.main.loadNibNamed("TextViewCustom", owner: self, options: nil)
    }
    
    override func awakeFromNib() {
        guard let view = UINib(nibName: "TextViewCustom", bundle: Bundle.main).instantiate(withOwner: nil, options: nil)[0] as? UIView else {
            return
        }
//        guard let view = R.nib.activateCardTextField.firstView(owner: self) else {
//            return
//        }
        addSubview(view)
        view.fixInView(self)
    }
}


extension UIView {
    func fixInView(_ parentView: UIView) -> Void{
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
