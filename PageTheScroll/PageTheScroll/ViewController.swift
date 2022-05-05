//
//  ViewController.swift
//  PageTheScroll
//
//  Created by Maury on 29/04/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    var images = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //scrollView.backgroundColor = .purple
                
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var contentWidth: CGFloat = 0.0
        let scrollViewWidth = scrollView.frame.width
        for x in 0...2 {
                        
            let image = UIImage(named: "icon\(x).png")
            let imageView = UIImageView(image: image)
            images.append(imageView)
            
            scrollView.addSubview(imageView)
            imageView.frame = CGRect(x: (scrollViewWidth / 2) - 75 + contentWidth, y: 75, width: 150, height: 150) //Position and size to each image
            
            contentWidth += scrollViewWidth
        }
        
        //scrollView.contentSize = CGSize(width: contentWidth, height: view.frame.size.height) //Permite el scroll en todos los sentidos
        
        scrollView.clipsToBounds = false
        
        scrollView.contentSize = CGSize(width: contentWidth, height: scrollView.frame.height) //Permite solo el scroll horizontal

    }


}

