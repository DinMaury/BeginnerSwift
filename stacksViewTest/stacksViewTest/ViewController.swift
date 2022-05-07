//
//  ViewController.swift
//  stacksViewTest
//
//  Created by Maury on 1/05/22.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var imgShowBig: UIImageView!
    
    @IBOutlet weak var labelNameShoe: UILabel!
    
    @IBOutlet weak var labelReference: UILabel!
    
    @IBOutlet weak var labelPrice: UILabel!
    
    @IBOutlet weak var stackViewToShoes: UIStackView!
    
    @IBOutlet weak var stackViewSocial: UIStackView!
    
    @IBOutlet weak var scrollShowHorizontal: UIScrollView!
        
    @IBOutlet var buttonsCustom2: [CustomShowView]!
    
    @IBOutlet var buttonsSocial: [CustomShowView]!
    
    let labelPriceShow: [Double] = [78.00, 83.00, 57.00, 93.00, 62.00]
    let imgSocial: [String] = ["Whatsapp.png", "Facebook.png", "Instagram.png", "Twitter.png"]
    let labelReferenceShow: [String] = ["48372dg American Special", "482750id Limit Edition", "94725kd EU Special Edition", "24853jd Colombia Edition", "83452ej Panama Edition"]
    let showBigImg: [String] = ["chucks.png", "shoes1.png", "shoes3.png", "shoes4.png", "shoes5.png"]
    let showName: [String] = ["Chuck Taylor Shoes", "Name Shoes1", "Name Shoes2", "Name Shoes3", "Name Shoes4"]
    var posShoes = 0 // posicion de la imagen e informacion que muestro to shoes
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //Fuction after load
    override func viewDidAppear(_ animated: Bool) {
        // Informacion Inicial
        imgShowBig.image = .init(named: showBigImg.first ?? "")
        labelReference.text = labelReferenceShow.first
        labelPrice.text = "$ \(labelPriceShow[0])"
        labelNameShoe.text = showName.first
        posShoes = 1
        // Buttons Scroll View
        buttonsCustom2.forEach { item in
            stackViewToShoes.addArrangedSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
            item.widthAnchor.constraint(equalToConstant: 120).isActive = true
            item.isHidden = false
        }
        for i in 0..<showBigImg.count {
            let button = buttonsCustom2[i]
            button.setup(imageName: showBigImg[i])
            button.didTouchCallback = {
                self.imgShowBig.image = .init(named: self.showBigImg[i])
                self.labelReference.text = self.labelReferenceShow[i]
                self.labelPrice.text = "$ \(self.labelPriceShow[i])"
                self.labelNameShoe.text = self.showName[i]
                self.posShoes = i
            }
        }
        // Buttons Social
        buttonsSocial.forEach { item in
            stackViewSocial.addArrangedSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
            item.widthAnchor.constraint(equalToConstant: 45).isActive = true
            item.isHidden = false
        }
        
        for j in 0..<imgSocial.count {
            let buttonSocial = buttonsSocial[j]
            buttonSocial.setup(imageName: imgSocial[j])
            buttonSocial.didTouchCallback = {
                print("You go to \(self.imgSocial[j])")
            }
        }
    }
    
    // Action to buttons

    @IBAction func clicLikeShoe(_ sender: Any) {
        //Organizar la posicion
        print("You Like to Shoes: \(showName[posShoes])")
    }
    
    @IBAction func clicBuyShoe(_ sender: Any) {
        //Organizar la posicion
        print("You wnat Buy to Shoes: \(showName[posShoes])")
        print("Price to: \(labelPriceShow[posShoes])")
    }
}

