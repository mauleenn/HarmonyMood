//
//  Cycle1US.swift
//  HarmonyMood
//
//  Created by Mauleen Ndlovu on 2/24/21.
//

import XCTest

class Cycle1US: XCTestCase {
    
    //US1:1 - Test "Hours Slept" Stepper
    func US1TestHoursSleptStepper() {
        let app = XCUIApplication()
        app.launch()
        
        let hoursSleptStepper = app.otherElements["Hours Slept: 0"]
        hoursSleptStepper.tap(withNumberOfTaps: 3, numberOfTouches: 3) // Should be 3

        // Test has been deprecated due to US7:2
        app.buttons["Add"].tap()
        app.alerts["Success!"].buttons["OK"].tap()
    }
    
    // US1:2 - Test "Depression" Text Field
    func US2TestDepressionTxtField() {
        let app = XCUIApplication()
        app.launch()
        
        let depressionTxtField = app.textFields["Depression 0-10"]

        // Test if "depressionTxtField" element exists
        XCTAssert(depressionTxtField.exists)
        
        // Test: User types "1" into text field, test to check
        // that value entered is = 1 and not 3.
        depressionTxtField.tap()
        depressionTxtField.typeText("1")
        let depressionTxt = depressionTxtField.value as? String
        XCTAssertNotEqual(depressionTxt, "3")
        XCTAssertEqual(depressionTxt, "1")
    }
    
    
    // US1:2 - Test "Elevation" Text Field
    func US2TestElevationTxtField() {
        let app = XCUIApplication()
        app.launch()
        
        let elevationTxtField = app.textFields["Elevation 0-10"]
        
        // Test if "elevationTxtField" element exists
        XCTAssert(elevationTxtField.exists)
        
        // Test: User types "4" into text field, test to check
        // that value entered is = 4 and not 3.
        elevationTxtField.tap()
        elevationTxtField.typeText("4")
        let elevationTxt = elevationTxtField.value as? String
        XCTAssertNotEqual(elevationTxt, "3")
        XCTAssertEqual(elevationTxt, "4")
    }
    
    
    // US1:2 - Test "Anxiety" Text Field
    func US2TestAnxietyTxtField() {
        let app = XCUIApplication()
        app.launch()
    
        let anxietyTxtField = app.textFields["Anxiety 0-10"]
        
        // Test if "anxietyTxtField" element exists
        XCTAssert(anxietyTxtField.exists)

        // Test: User types "9" into text field, test to check
        // that value entered is = 9 and not 5.
        anxietyTxtField.tap()
        anxietyTxtField.typeText("9")
        let anxietyTxt = anxietyTxtField.value as? String
        XCTAssertNotEqual(anxietyTxt, "5")
        XCTAssertEqual(anxietyTxt, "9")
    }
    
    
    // US1:2 - Test "Irritability" Text Field
    func US2TestIrritabilityTxtField() {
        let app = XCUIApplication()
        app.launch()
        
        let irritabilityTxtField = app.textFields["Irritability 0-10"]
        
        // Test if "irritabilityTxtField" element exists
        XCTAssert(irritabilityTxtField.exists)

        // Test: User types "10" into text field, test to check
        // that value entered is = 10 and not 6.
        irritabilityTxtField.tap()
        irritabilityTxtField.typeText("10")
        let irritabilityTxt = irritabilityTxtField.value as? String
        XCTAssertNotEqual(irritabilityTxt, "6")
        XCTAssertEqual(irritabilityTxt, "10")
    }
    
    // US1:2 - Tests that the Nav Bar title named "Tracking Points" exists
    func US2TestNavBar() {
        let app = XCUIApplication()
        app.launch()
        
        let trackingPointsNavBar = app.navigationBars.staticTexts["Tracking Points"]
        XCTAssertTrue(trackingPointsNavBar.exists)
    }
}
