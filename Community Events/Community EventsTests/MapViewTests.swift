//
//  MapViewTests.swift
//  Community EventsTests
//
//  Created by Blake Ezechi on 16/03/2023.
//

import XCTest
import CoreLocation
@testable import Community_Events

class MapViewTests: XCTestCase {
    
    
    func testPanelReturningCorrectTitle() {
        
        let filterView = FilterViewController()
        let result = filterView.label.text
        XCTAssertEqual(result, "What event are you looking for?")
    }
    
    func testPinArrayShouldNotBeEmpty() {
        let result = ConstantsParameters.constantsList.count
        XCTAssertEqual(result, 5)
    }
    
    func testIfExpiredEqualsTrue() {
        let result = ConstantsParameters.constantsList[4].expired
        XCTAssertTrue(result)
    }
    
    func testIfRightTitleIsDisplayed() {
        let title = "Volleyball"
        let eventOne = ConstantsParameters.constantsList[0].title
        XCTAssertEqual(eventOne, title)
    }
}
