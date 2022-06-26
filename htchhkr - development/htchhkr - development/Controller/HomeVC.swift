//
//  HomeVC.swift
//  htchhkr - development
//
//  Created by Maury on 20/06/22.
//

import UIKit
import MapKit

class HomeVC: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var actionButton: RoundedShadowButton!
    @IBOutlet weak var actionButtonWidthConstraint: NSLayoutConstraint!
    
    var delegate: CenterVCDelegate?
    var isCollapsed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
    }

    @IBAction func actionButtonPressed(_ sender: Any) {
        isCollapsed.toggle()
        actionButton.animateButton(shouldLoad: true, withMessage: nil,widthConstraint: actionButtonWidthConstraint)
    }
}

