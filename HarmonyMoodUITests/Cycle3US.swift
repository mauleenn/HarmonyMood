//
//  Cycle3US.swift
//  HarmonyMood
//
//  Created by Mauleen Ndlovu on 2/24/21.
//

import XCTest

class Cycle3US: XCTestCase {

    // US3:3 - Test that the Nav Bar title named "Medications List" exists
    func US3TestInfoPageNavigation() {
        let app = XCUIApplication()
        app.launch()
        
        // By pressing this button I will get to the second view
        let medicationsListLink = app.navigationBars["Tracking Points"].buttons["💊"]
        XCTAssert(medicationsListLink.exists)
        medicationsListLink.tap()


        XCTAssertTrue(app.navigationBars.staticTexts["Medications List"].exists)
    }
    
    // US3:3 - Test that the Nav Bar title named "Medication List" exists
    func US3TestMedicationListNavigation() {
        let app = XCUIApplication()
        app.launch()
        
        
        // By pressing this button I will get to the second view
        let medicationsListLink = app.navigationBars["Tracking Points"].buttons["💊"]
        XCTAssert(medicationsListLink.exists)
        medicationsListLink.tap()

        
        XCTAssertTrue(app.navigationBars.staticTexts["Medications List"].exists)
    }

}
