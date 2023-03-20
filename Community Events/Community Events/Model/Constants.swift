//
//  Constants.swift
//  Community Events
//
//  Created by Blake Ezechi on 14/03/2023.
//

import UIKit
import MapKit
import CoreLocation

struct Constants {
    static let appName = "Community Event"
    static let registerSegue = "RegisterToMap"
    static let loginSegue = "LoginToMap"
    var title: String
    var date: String
    var location: String
    var coordinate: CLLocationCoordinate2D
    var expired: Bool
    
    init(title: String, date: String, location: String, coordinate: CLLocationCoordinate2D, expired: Bool) {
        self.title = title
        self.date = date
        self.location = location
        self.coordinate = coordinate
        self.expired = expired
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let titleField = "title"
        static let locationField = "location"
        static let dateField = "date"
    }
}
