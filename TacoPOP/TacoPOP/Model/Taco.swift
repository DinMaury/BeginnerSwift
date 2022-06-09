//
//  Taco.swift
//  TacoPOP
//
//  Created by Maury on 31/05/22.
//

import Foundation

enum TacoShell: Int {
    case Flour = 1
    case Corn = 2
}

enum TacoProtein: String {
    case Beef = "Beef"
    case Chicken = "Chicken"
    case Brisket = "Brisket"
    case Fish = "Fish"
}

enum TacoCondiment: Int {
    case Loaded = 1
    case Plain = 2
}

struct Taco {
    
    private(set) var id: Int?
    private(set) var productName: String?
    private(set) var shellId: TacoShell?
    private(set) var proteinId: TacoProtein?
    private(set) var condimentId: TacoCondiment?
    
    init(id: Int, productName: String, shellId: Int, proteinId: Int, condimentId: Int) {
        
        self.id = id
        self.productName = productName
        
        // Taco shell
        switch shellId {
        case 2:
            self.shellId = TacoShell.Corn
        default:
            self.shellId = TacoShell.Flour
        }
        
        // Taco protein
        switch proteinId {
        case 2:
            self.proteinId = TacoProtein.Chicken
        case 3:
            self.proteinId = TacoProtein.Brisket
        case 4:
            self.proteinId = TacoProtein.Fish
        default:
            self.proteinId = TacoProtein.Beef
        }
        
        // Taco condiment
        switch condimentId {
        case 2:
            self.condimentId = TacoCondiment.Plain
        default:
            self.condimentId = TacoCondiment.Loaded
        }
    }
}
