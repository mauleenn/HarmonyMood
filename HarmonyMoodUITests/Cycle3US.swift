//
//  Cycle3US.swift
//  HarmonyMood
//
//  Created by Mauleen Ndlovu on 2/24/21.
//

import XCTest

class Cycle3US: XCTestCase {

    //Cycle 3: Test that the Nav Bar title named "Medications List" exists
    func testInfoPageNavigation() {
        let app = XCUIApplication()
        app.launch()
        
        // By pressing this button I will get to the second view
        let medicationsListLink = app.navigationBars["Tracking Points"].buttons["💊"]
        XCTAssert(medicationsListLink.exists)
        medicationsListLink.tap()


        XCTAssertTrue(app.navigationBars.staticTexts["Medications List"].exists)
    }
    
    //Cycle 3: Test that the Nav Bar title named "Medication List" exists
    func testMedicationListNavigation() {
        let app = XCUIApplication()
        app.launch()
        
        
        // By pressing this button I will get to the second view
        let medicationsListLink = app.navigationBars["Tracking Points"].buttons["💊"]
        XCTAssert(medicationsListLink.exists)
        medicationsListLink.tap()

        
        XCTAssertTrue(app.navigationBars.staticTexts["Medications List"].exists)
    }

}
