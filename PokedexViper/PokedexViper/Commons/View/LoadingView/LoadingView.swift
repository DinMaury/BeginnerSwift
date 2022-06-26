//
//  LoadingView.swift
//  PokedexViper
//
//  Created by Maury on 25/06/22.
//

import UIKit

final class LoadingView: UIView {
    
    //MARK: - Views
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Initis
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
}

//MARK: - Publics
extension LoadingView {
    
    func showLoading() {
        activityIndicator.startAnimating()
    }
}

//MARK: - Privates
private extension LoadingView {
    
    private func commonInit(){
        
        guard let viewToAdd = Bundle.main.loadNibNamed(LoadingView.identifier, owner: self, options: nil),
              let contenView = viewToAdd.first as? UIView else { return }
        
        addSubview(contenView)
        contenView.anchorTo(parentView: self)
    }
}
