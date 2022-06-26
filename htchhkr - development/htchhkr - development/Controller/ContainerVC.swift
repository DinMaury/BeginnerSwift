//
//  ContainerVC.swift
//  htchhkr - development
//
//  Created by Maury on 24/06/22.
//

import UIKit
import QuartzCore

enum SlideOutState {
    case collapsed
    case leftPanelExpanded
}

enum ShowWhichVC {
    case homeVC
}

var showVC: ShowWhichVC = .homeVC

class ContainerVC: UIViewController {
    
    var homeVC: HomeVC?
    var leftVC: LeftSidePanelVC?
    var centerControler: UIViewController?
    var currentState: SlideOutState = .collapsed
    
    var isHidden = false
    let centerPanelExpandedOffset: CGFloat = 160

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCenter(screen: showVC)
    }
    
    func initCenter(screen: ShowWhichVC) {
        
        var presentingController: UIViewController
        
        showVC = screen
        
        if homeVC == nil {
            
            homeVC = UIViewController.homeVC()
            homeVC?.delegate = self
        }
        
        presentingController = homeVC!
        
        if let con = centerControler {
            con.view.removeFromSuperview()
            con.removeFromParent()
        }
        
        centerControler = presentingController
        view.addSubview(centerControler?.view ?? UIView())
        addChildSidePanelViewController(centerControler as! LeftSidePanelVC )
        centerControler?.didMove(toParent: self)
    }
}

extension ContainerVC: CenterVCDelegate {
    
    func toggleLeftPanel() {
        let notAlreadyExpanded = (currentState != .leftPanelExpanded)
        
        if notAlreadyExpanded {
            
            addLeftPanelViewController()
        }
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
    }
    
    func addLeftPanelViewController() {
        if leftVC == nil {
            leftVC = UIViewController.leftViewController()
            addChildSidePanelViewController(leftVC!)
        }
    }
    
    func addChildSidePanelViewController(_ sidePanelController: LeftSidePanelVC) {
        view.insertSubview(sidePanelController.view, at: 0)
        addChildSidePanelViewController(sidePanelController)
        sidePanelController.didMove(toParent: self)
    }
    
    func animateLeftPanel(shouldExpand: Bool) {
        if shouldExpand {
            isHidden = !isHidden
            //animateStatusBar()
            //setupWhiteCoverView()
            currentState = .leftPanelExpanded
            
        } else {
            isHidden = !isHidden
            //animateStatusBar()
            
            //hideWhiteCoverView()
        }
    }
    
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        
    }
}

private extension UIViewController /*UIStoryboard*/{
    
    class func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    class func leftViewController() -> LeftSidePanelVC? {
        let leftSidePanelVC = LeftSidePanelVC()
        return leftSidePanelVC // Prensentar el XIB
    }
    
    class func homeVC() -> HomeVC? {
        return mainStoryboard().instantiateViewController(identifier: "HomeVC") as? HomeVC
    }
}
