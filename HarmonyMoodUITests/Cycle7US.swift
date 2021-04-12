/*
 Copyright 2021 Mauleen Ndlovu
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

//  Cycle7US.swift
//  HarmonyMoodUITests
//
//  Created by Mauleen Ndlovu on 3/14/21.
//

import XCTest

class Cycle7US: XCTestCase {

    // Cycle 7 US:3 - Testing that user enters in values
    // for medication textfields. If they don't, the
    // 'Add' button will be disabled
    func testEmptyTxtFieldMedicationEntry() {
        let app = XCUIApplication()
        app.launch()
        
        // By pressing this button I will get to the second view
        let medicationButton = app.toolbars["Toolbar"].buttons["pills"]
        XCTAssert(medicationButton.exists)
        medicationButton.tap()
        
        let medicationsListNavigationBar = app.navigationBars["Medications"]
        
        let addButton = medicationsListNavigationBar.buttons["➕"]
        XCTAssert(addButton.exists)
        addButton.tap()
        
        let medDosageTxtField = app.tables.cells["Dosage: "]
        medDosageTxtField.tap()
        medDosageTxtField.typeText("100")
        
        // Tests to check that the 'Add' button is not enabled
        // because not all the textfields are filled.
        let addMedicationButton = app.buttons["Add"]
        XCTAssertEqual(addMedicationButton.isEnabled, false)
    }
    
    // Cycle 7 US:5 - Testing that the mood history page
    // exists and the button to get to the page works and
    // exists.
    func testMoodHistoryPage() {
        let app = XCUIApplication()
        app.launch()
        
        // Testing to see if the button exists.
        let calendarButton = app.toolbars["Toolbar"].buttons["calendar"]
        XCTAssert(calendarButton.exists)
        calendarButton.tap()
        
        // Testing to see that the mood history page
        // exists.
        let moodHistoryNavBar = app.navigationBars.staticTexts["Mood History"]
        XCTAssertTrue(moodHistoryNavBar.exists)
    }
    
    // Cycle 7 US:6 - Testing that user enters in values
    // for edit medication textfields. If they don't, the
    // 'Save' button will be disabled
    func testEmptyTxtFieldEditMedication() {
        let app = XCUIApplication()
        app.launch()
        
        // By pressing this button I will get to the second view
        let medicationButton = app.toolbars["Toolbar"].buttons["pills"]
        XCTAssert(medicationButton.exists)
        medicationButton.tap()
        
        let editMedication = app.tables.cells["Ibuprofen, 100 mg, pencil, minus"].buttons["pencil"]
        editMedication.tap()
                
        let medNameTxtField = app.textFields["Medication Name:"]
        medNameTxtField.tap()
        let deleteKey = app.keys["delete"]
        deleteKey.tap()
        deleteKey.tap()
        deleteKey.tap()
        deleteKey.tap()
        deleteKey.tap()
        deleteKey.tap()
        deleteKey.tap()
        deleteKey.tap()
        deleteKey.tap()
        medNameTxtField.typeText("Advil")
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let medDosageTxtField = app.textFields["Dosage:"]
        medDosageTxtField.tap()
        let deleteKey2 = app.keys["Delete"]
        deleteKey2.tap()
        deleteKey2.tap()
        deleteKey2.tap()
        
        // Tests to check that the 'Save' button is not enabled
        // because not all the textfields are filled.
        let saveButton = app.buttons["Save"]
        XCTAssertEqual(saveButton.isEnabled, false)
    }
    
}
