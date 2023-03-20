//
//  ConstantsParameters.swift
//  Community Events
//
//  Created by Blake Ezechi on 15/03/2023.
//

import CoreLocation

struct ConstantsParameters {
    static var constantsList = [Constants(title: "Volleyball",
                                          date: "20/06/2023",
                                          location: "Northlands Park",
                                          coordinate: CLLocationCoordinate2D(latitude: 51.5758803344746,
                                                                             longitude: 0.4976933254567531),
                                          expired: false),
                                Constants(title: "Football Match",
                                          date: "18/06/2023",
                                          location: "Gloucester Park",
                                          coordinate: CLLocationCoordinate2D(latitude: 51.57766533668046,
                                                                             longitude: 0.45268855614121045),
                                          expired: false),
                                Constants(title: "5k Run",
                                          date: "07/07/2023",
                                          location: "Northlands Park",
                                          coordinate: CLLocationCoordinate2D(latitude: 51.549550035616925,
                                                                             longitude: 0.4467800877064759),
                                          expired: false),
                                Constants(title: "Swimming",
                                          date: "10/05/2023" ,
                                          location: "Wickford Memorial Park",
                                          coordinate: CLLocationCoordinate2D(latitude: 51.61996778323418,
                                                                             longitude: 0.5338082277940184),
                                          expired: false),
                                Constants(title: "Baking",
                                          date: "01/01/2023",
                                          location: "Festival Leisure Park",
                                          coordinate: CLLocationCoordinate2D(latitude: 51.58612590734672,
                                                                             longitude: 0.462283037324271),
                                          expired: true)]
}
