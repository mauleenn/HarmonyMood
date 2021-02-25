//
//  Cycle1US.swift
//  HarmonyMood
//
//  Created by Mauleen Ndlovu on 2/24/21.
//

import XCTest

class Cycle1US: XCTestCase {

    
    //Cycle 1: Tests that the Nav Bar title named "Tracking Points" exists
    func testNavBar() {
        let app = XCUIApplication()
        app.launch()
        
        let trackingPointsNavBar = app.navigationBars.staticTexts["Tracking Points"]
        XCTAssertTrue(trackingPointsNavBar.exists)
    }
    
    
    //Cycle 1: Test "Hours Slept" Stepper
    func testHoursSleptStepper() {
        let app = XCUIApplication()
        app.launch()
        
        let hoursSleptStepper = app.otherElements["Hours Slept: 0"]
        hoursSleptStepper.tap(withNumberOfTaps: 3, numberOfTouches: 3) // Should be 3

        app.buttons["Enter"].tap()
        app.alerts["Success!"].buttons["OK"].tap()
    }
    
    
    //Cycle 1: Test "Depression" Text Field
    func testDepressionTxtField() {
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
    
    
    //Cycle 1: Test "Elevation" Text Field
    func testElevationTxtField() {
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
    
    
    //Cycle 1: Test "Anxiety" Text Field
    func testAnxietyTxtField() {
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
    
    
    //Cycle 1: Test "Irritability" Text Field
    func testIrritabilityTxtField() {
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

}
