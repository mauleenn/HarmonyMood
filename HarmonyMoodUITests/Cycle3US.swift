//
//  Cycle3US.swift
//  HarmonyMood
//
//  Created by Mauleen Ndlovu on 2/24/21.
//

import XCTest

class Cycle3US: XCTestCase {

    // US3:3 - Test that the Nav Bar title named "Welcome to Harmony Mood!" exists
    func testInfoPageNavigation() {
        let app = XCUIApplication()
        app.launch()
        
        // Link to Info page
        let infoButton = app.toolbars["Toolbar"].buttons["info.circle"]
        XCTAssert(infoButton.exists)
        infoButton.tap()


        XCTAssertTrue(app.navigationBars.staticTexts["Welcome to Harmony Mood!"].exists)
    }
    
    // US3:3 - Test that the Nav Bar title named "Medication List" exists
    func testMedicationListNavigation() {
        let app = XCUIApplication()
        app.launch()
        
        // Link to Medications List page
        let medicationButton = app.toolbars["Toolbar"].buttons["pills"]
        XCTAssert(medicationButton.exists)
        medicationButton.tap()

        XCTAssertTrue(app.navigationBars.staticTexts["Medications List"].exists)
    }

}
