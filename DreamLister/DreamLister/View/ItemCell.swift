//
//  ItemCell.swift
//  DreamLister
//
//  Created by Maury on 19/05/22.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var thumbimg: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    
    func configureCell(item: Item) {
        
        thumbimg.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thumbimg.heightAnchor.constraint(equalToConstant: 150),
            thumbimg.widthAnchor.constraint(equalTo: thumbimg.heightAnchor)
        ])
        titleLabel.text = item.title
        priceLabel.text = "$\(item.price)"
        detailsLabel.text = item.details
        thumbimg.image = item.toImage?.image as? UIImage
    }

}
