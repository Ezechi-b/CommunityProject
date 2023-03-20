//
//  WelcomeViewController.swift
//  Community Events
//
//  Created by Blake Ezechi on 27/02/2023.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var eventLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var charIndex = 0
        eventLabel.text = ""
        let titleText = Constants.appName
        
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * Double(charIndex), repeats: false) { timer in
                self.eventLabel.text?.append(letter)
            }
            charIndex += 1
        }
    }
    
    
}

