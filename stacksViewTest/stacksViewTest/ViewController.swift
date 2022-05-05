//
//  ViewController.swift
//  stacksViewTest
//
//  Created by Maury on 1/05/22.
//

import UIKit

class ButtonShow: UIView {
    
    private lazy var imageView = UIImageView()
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(didTouch), for: .touchUpInside)
        return button
    }()
    
    var didTouchCallback: (() -> Void)?
    
    init() {
        super.init(frame: .zero)
        addSubViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews() {
        addSubview(imageView)
        addSubview(button)
    }
    
    private func setupConstraints() { //Posicion de imagenes y botones
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: topAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func setup(imageName: String) {
        imageView.image = .init(named: imageName)
    }
    
    @objc private func didTouch() {
        didTouchCallback?()
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var imgShowBig: UIImageView!
    
    @IBOutlet weak var labelNameShoe: UILabel!
    
    @IBOutlet weak var labelReference: UILabel!
    
    @IBOutlet weak var labelPrice: UILabel!
    
    //Prueba de visibilidad
    @IBOutlet weak var stackViewToShoes: UIStackView!
    
    @IBOutlet weak var scrollShowHorizontal: UIScrollView!
        
    //Buttons ScrollView
    @IBOutlet weak var buttonShoes1: UIButton!
    @IBOutlet weak var buttonShoes2: UIButton!
    @IBOutlet weak var buttonShoes3: UIButton!
    @IBOutlet weak var buttonShoes4: UIButton!
    @IBOutlet weak var buttonShoes5: UIButton!
    
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet var buttonsCustom2: [CustomShowView]!
    
    var buttonsCustom: [ButtonShow] = [
        .init(),
        .init(),
        .init(),
        .init(),
        .init()
    ]
    
    let labelPriceShow: [Double] = [78.00, 83.00, 57.00, 93.00, 62.00]
    let labelReferenceShow: [String] = ["48372dg American Special", "482750id Limit Edition", "94725kd EU Special Edition", "24853jd Colombia Edition", "83452ej Panama Edition"]
    let showBigImg: [String] = ["chucks.png", "shoes1.png", "shoes3.png", "shoes4.png", "shoes5.png"]
    let showName: [String] = ["Chuck Taylor Shoes", "Name Shoes1", "Name Shoes2", "Name Shoes3", "Name Shoes4"]
    var posShoes = 0 // posicion de la imagen que estoy mostrando
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stackViewToShoes.arrangedSubviews.forEach {
            $0.removeFromSuperview()
            $0.isHidden = true
        }
    }
    
    //Fuction after load
    override func viewDidAppear(_ animated: Bool) {

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
    }
    
    // Action tu buttons scroll
    // Codigo innecesario por otro metodo de uso
    @IBAction func clicShoes1(_ sender: Any) {
        posShoes = 1
        imgShowBig.image = .init(named: showBigImg[posShoes])
        labelReference.text = labelReferenceShow[posShoes]
        labelPrice.text = "$ \(labelPriceShow[posShoes])"
        labelNameShoe.text = showName[posShoes]
        
    }
    @IBAction func clicChuks(_ sender: Any) {
        posShoes = 0
        imgShowBig.image = .init(named: showBigImg[posShoes])
        imgShowBig.image = .init(named: showBigImg[posShoes])
        labelReference.text = labelReferenceShow[posShoes]
        labelPrice.text = "$ \(labelPriceShow[posShoes])"
        labelNameShoe.text = showName[posShoes]
    }
    @IBAction func clicShoes2(_ sender: Any) {
        posShoes = 2
        imgShowBig.image = .init(named: showBigImg[posShoes])
        imgShowBig.image = .init(named: showBigImg[posShoes])
        labelReference.text = labelReferenceShow[posShoes]
        labelPrice.text = "$ \(labelPriceShow[posShoes])"
        labelNameShoe.text = showName[posShoes]
    }
    @IBAction func clicShoes3(_ sender: Any) {
        posShoes = 3
        imgShowBig.image = .init(named: showBigImg[posShoes])
        imgShowBig.image = .init(named: showBigImg[posShoes])
        labelReference.text = labelReferenceShow[posShoes]
        labelPrice.text = "$ \(labelPriceShow[posShoes])"
        labelNameShoe.text = showName[posShoes]
    }
    @IBAction func clicShoes4(_ sender: Any) {
        posShoes = 4
        imgShowBig.image = .init(named: showBigImg[posShoes])
        imgShowBig.image = .init(named: showBigImg[posShoes])
        labelReference.text = labelReferenceShow[posShoes]
        labelPrice.text = "$ \(labelPriceShow[posShoes])"
        labelNameShoe.text = showName[posShoes]
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
    
    // Action to buttons social media
    
    @IBAction func clicToWhatsapp(_ sender: Any) {
        print("You go to Whatsapp")
    }
    @IBAction func clicToFacebook(_ sender: Any) {
        print("You go to Facebook")
    }
    @IBAction func clicToInstagram(_ sender: Any) {
        print("You go to Instagram")
    }
    @IBAction func clicToTwitter(_ sender: Any) {
        print("You go to Twitter")
    }
}

