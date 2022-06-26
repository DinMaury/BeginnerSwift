//
//  CenterVCDelegate.swift
//  htchhkr - development
//
//  Created by Maury on 24/06/22.
//

import Foundation

protocol CenterVCDelegate {
    
    func toggleLeftPanel()
    func addLeftPanelViewController()
    func animateLeftPanel(shouldExpand: Bool)
}
