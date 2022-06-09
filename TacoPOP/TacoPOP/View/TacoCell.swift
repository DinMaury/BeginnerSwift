//
//  TacoCell.swift
//  TacoPOP
//
//  Created by Maury on 31/05/22.
//

import UIKit

class TacoCell: UICollectionViewCell, NibLoadableView, Shakeable {

    @IBOutlet weak var tacoImage: UIImageView!
    @IBOutlet weak var tacoLabel: UILabel!
    
    var taco: Taco?
    
    func configureCell(taco: Taco) {
        
        if let name = taco.proteinId?.rawValue {
            tacoImage.image = .init(named: name)
            tacoLabel.text = taco.productName
        }
        //tacoImage.frame = .init(x: 0, y: 0, width: 95, height: 75)
        //tacoLabel.frame = .init(x: 0, y: 75, width: 95, height: 20)
    }
}
