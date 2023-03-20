//
//  UserLocation.swift
//  Community Events
//
//  Created by Blake Ezechi on 17/03/2023.
//

import Foundation
import MapKit

struct UserLocation {
    let location: CLLocationCoordinate2D
    
    init(location: CLLocationCoordinate2D) {
        self.location = location
    }
}
