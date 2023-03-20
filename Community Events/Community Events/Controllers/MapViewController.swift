//
//  MapViewController.swift
//  Community Events
//
//  Created by Blake Ezechi on 14/03/2023.
//

import UIKit
import MapKit
import CoreLocation
import FloatingPanel
import Firebase
import FirebaseFirestore

class MapViewController: UIViewController, MKMapViewDelegate, SearchDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var locationStack: UIStackView!
    @IBOutlet weak var subtitleTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var map: MKMapView!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        locationStack.isHidden = true
    }
    
    var locations = [MKPointAnnotation]()
    var filterView = ConstantsParameters.constantsList
    let db = Firestore.firestore()
    var subtitleText: String?
    var lat: CLLocationDegrees?
    var long: CLLocationDegrees?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        subtitleTextField.delegate = self
        
        addCustomPin()
        let searchVC = FilterViewController()
        searchVC.delegate = self
        let panel = FloatingPanelController()
        panel.set(contentViewController: searchVC)
        panel.addPanel(toParent: self)
        
        
        map.setRegion(MKCoordinateRegion(
            center: ConstantsParameters.constantsList[0].coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.1,
                                   longitudeDelta: 0.1)),
                      animated: true)
        
        let longPressRecogniser = UILongPressGestureRecognizer(target: self, action: #selector(self.handleTap(_:))) //new
        longPressRecogniser.minimumPressDuration = 0.5
                map.addGestureRecognizer(longPressRecogniser)
        
        
        }
    
    func addCustomPin() {
        let pin = MKPointAnnotation()
        pin.coordinate = ConstantsParameters.constantsList[0].coordinate
        pin.title = ConstantsParameters.constantsList[0].title
        pin.subtitle = """
        Date: \(ConstantsParameters.constantsList[0].date)
        Start Time: 15:00
        Location: \(ConstantsParameters.constantsList[0].location)
        Description: A volleyball game against the other borough
                    to see who's best and who ever comes out victorious
                    wins a cash price
        Contact: communityVolley@hotmail.co.uk
        Expired: \(ConstantsParameters.constantsList[0].expired)
        """
        let pinTwo = MKPointAnnotation()
        pinTwo.coordinate = ConstantsParameters.constantsList[1].coordinate
        pinTwo.title = ConstantsParameters.constantsList[1].title
        pinTwo.subtitle = """
        Date: \(ConstantsParameters.constantsList[1].date)
        Start Time: 17:00
        Location: \(ConstantsParameters.constantsList[1].location)
        Description: A 11 vs 11 football match. Come and showcase
                    your football talent. The winning team will
                    receive a £1000 cash price. Contact the email
                    below to register your interest.
        Contact: communitySoccer@hotmail.co.uk
        Expired: \(ConstantsParameters.constantsList[1].expired)
        """
        
        let pinThree = MKPointAnnotation()
        pinThree.coordinate = ConstantsParameters.constantsList[2].coordinate
        pinThree.title = ConstantsParameters.constantsList[2].title
        pinThree.subtitle = """
        Date: \(ConstantsParameters.constantsList[2].date)
        Start Time: 12:00
        Location: \(ConstantsParameters.constantsList[2].location)
        Description: Calling out all fitness enthusiasts. Put your
                    fitness to the test with a 5k run. The person
                    who is able to complete the run in the fastest
                    time will receive a cash prize
        Contact: communityRun@hotmail.co.uk
        Expired: \(ConstantsParameters.constantsList[2].expired)
        """
        
        let pinFour = MKPointAnnotation()
        pinFour.coordinate = ConstantsParameters.constantsList[3].coordinate
        pinFour.title = ConstantsParameters.constantsList[3].title
        pinFour.subtitle = """
        Date: \(ConstantsParameters.constantsList[3].date)
        Start Time: 13:00
        Location: \(ConstantsParameters.constantsList[3].location)
        Description: This is for any anyone who is learning to
                    swim. We will teach you the ropes
        Contact: communitySwimming@hotmail.co.uk
        Expired: \(ConstantsParameters.constantsList[3].expired)
        """
        
        let pinFive = MKPointAnnotation()
        pinFive.coordinate = ConstantsParameters.constantsList[4].coordinate
        pinFive.title = ConstantsParameters.constantsList[4].title
        pinFive.subtitle = """
        Date: \(ConstantsParameters.constantsList[4].date)
        Start Time: 10:00
        Location: \(ConstantsParameters.constantsList[4].location)
        Description: We are baking cakes and giving the profit
                    to charity
        Contact: communityBaking@hotmail.co.uk
        Expired: \(ConstantsParameters.constantsList[4].expired)
        """
        let arrPin = [pin, pinTwo, pinThree, pinFour, pinFive]
        locations = arrPin
        map.showAnnotations(arrPin, animated: true)
        
        for test in locations {
            if test.subtitle?.contains("true") == true {
                map.removeAnnotation(test)
            }
        }
        
    }
    
    //Map
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {  //makes sure the pin is not the users current location
            return nil
        }
        
        var annotationView = map.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        if annotationView == nil {
            // Create the view
            annotationView = MKAnnotationView(annotation: annotation,
                                              reuseIdentifier: "custom")
            annotationView?.canShowCallout = true
            
        }
        else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = UIImage(named: "Pin")
        
        let subtitleView = UILabel()
        subtitleView.font = subtitleView.font.withSize(12)
        subtitleView.numberOfLines = 0
        subtitleView.text = annotation.subtitle!
        annotationView!.detailCalloutAccessoryView = subtitleView
        
        
        return annotationView
    }
    
    func filterViewController(_ vc: FilterViewController, didSelectLocationWith coordinates: CLLocationCoordinate2D?) {
        guard let coordinates = coordinates else {
            return
        }
        
        for test in locations {
            if test.subtitle?.contains("true") == true {
                map.removeAnnotation(test)
            }
        }

        let pin = MKPointAnnotation()
        pin.coordinate = coordinates
        map.addAnnotation(pin)
        
        map.setRegion(MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.01,
                                                                                     longitudeDelta: 0.01)),
                      animated: true)
        
    }
    
    
    @objc func handleTap(_ gestureReconizer: UILongPressGestureRecognizer)         {
            let location = gestureReconizer.location(in: map)
            let coordinate = map.convert(location,toCoordinateFrom: map)
            subtitleText = subtitleTextField.text
            
            // Add annotation:
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            lat = coordinate.latitude
            long = coordinate.longitude
            annotation.subtitle = subtitleText
            map.addAnnotation(annotation)
            
        }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location:CLLocationCoordinate2D = manager.location!.coordinate
        lat = location.latitude
        long = location.longitude
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        subtitleTextField.text = ""
    }
    
}
