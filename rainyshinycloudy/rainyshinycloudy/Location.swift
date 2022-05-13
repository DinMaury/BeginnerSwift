//
//  Location.swift
//  rainyshinycloudy
//
//  Created by Maury on 13/05/22.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}
    var latitude: Double!
    var longitude: Double!
}
