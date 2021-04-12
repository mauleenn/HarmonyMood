//
//  Cycle5US.swift
//  HarmonyMood
//
//  Created by Mauleen Ndlovu on 2/24/21.
//

import XCTest

class Cycle5US: XCTestCase {
    
    // US5:1 - Testing "Info" button exists and that
    // users can access it.
    func testInfoButton() {
        let app = XCUIApplication()
        app.launch()
        
        // Link to Medications page
        let medicationButton = app.toolbars["Toolbar"].buttons["pills"]
        XCTAssert(medicationButton.exists)
        medicationButton.tap()
        
        let infoButton = app.toolbars["Toolbar"].buttons["info.circle"]
        XCTAssert(infoButton.exists)
        infoButton.tap()
        
        XCTAssertTrue(app.navigationBars.staticTexts["Welcome to Harmony Mood!"].exists)
    }
    
    // US5:2 - Test "Dosage" Text Field
    func testMedDosage() {
        let app = XCUIApplication()
        app.launch()
        
        // Link to Medications page
        let medicationButton = app.toolbars["Toolbar"].buttons["pills"]
        XCTAssert(medicationButton.exists)
        medicationButton.tap()
        
        
        let medicationsListNavigationBar = app.navigationBars["Medications"]
        
        // Test if "medicationsListNavigationBar" exists
        XCTAssert(medicationsListNavigationBar.exists)
        
        // Test to see if the add button exists, after we check
        // we will press on it and then go to the add medication
        // form
        let addButton = medicationsListNavigationBar.buttons["➕"]
        addButton.tap()
        
        // Test that types "100" into the "Medication Dosage"
        // text field. After we type the dosage we will check
        // if we actually did this correctly.
        let medDosageTxtField = app.tables.cells["Dosage: "]
        medDosageTxtField.tap()
        medDosageTxtField.typeText("100")
        
    }
    // US5:2 - Testing to see if we added the correct medication
    func testestAddingCorrectMedication() {
        let app = XCUIApplication()
        app.launch()
        
        // Link to Medications page
        let medicationButton = app.toolbars["Toolbar"].buttons["pills"]
        XCTAssert(medicationButton.exists)
        medicationButton.tap()
        
        
        let medicationsListNavigationBar = app.navigationBars["Medications"]
        
        // Test to see if the add button exists, after we check
        // we will press on it and then go to the add medication
        // form
        let addButton = medicationsListNavigationBar.buttons["➕"]
        addButton.tap()
        
        // Test that types "Seroquel" into the "Medication Name"
        // text field.
        let medNameTxtField = app.tables.cells["Medication Name: "]
        medNameTxtField.tap()
        medNameTxtField.typeText("Seroquel")
        
        // Test that types "100" into the "Medication Dosage"
        // text field.
        let medDosageTxtField = app.tables.cells["Dosage: "]
        medDosageTxtField.tap()
        medDosageTxtField.typeText("100")
        
        // After user enters in the medication, they need to press
        // the 'Add' button.
        app.buttons["Add"].tap()
        
        // Test that what we entered is not equal to "Lamictal"
        let addNewMedTxt = medNameTxtField.value as? String
        XCTAssertNotEqual(addNewMedTxt, "Lamictal")
    }
    
    // US5:2 - Testing adding a new medication on the "Medications" page
    func testAddingNewMedication() {
        let app = XCUIApplication()
        app.launch()
        
        // Link to Medications page
        let medicationButton = app.toolbars["Toolbar"].buttons["pills"]
        XCTAssert(medicationButton.exists)
        medicationButton.tap()
        
        
        let medicationsListNavigationBar = app.navigationBars["Medications"]
        
        // Test to see if the add button exists, after we check
        // we will press on it and then go to the add medication
        // form
        let addButton = medicationsListNavigationBar.buttons["➕"]
        addButton.tap()
        
        // Test that types "Seroquel" into the "Medication Name"
        // text field.
        let medNameTxtField = app.tables.cells["Medication Name: "]
        medNameTxtField.tap()
        medNameTxtField.typeText("Advil")
        
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        // Test that types "100" into the "Medication Dosage"
        // text field.
        let medDosageTxtField = app.tables.cells["Dosage: "]
        medDosageTxtField.tap()
        medDosageTxtField.typeText("100")
        
        // After user enters in the medication, they need to press
        // the 'Add' button.
        app.buttons["Add"].tap()
    }
    
    // US5:4 - Test to delete a medication
    func testDeleteButton() {
        let app = XCUIApplication()
        app.launch()
        
        // Link to Medications page
        let medicationButton = app.toolbars["Toolbar"].buttons["pills"]
        XCTAssert(medicationButton.exists)
        medicationButton.tap()
        
        let editMedication = app.tables.cells["Advil, 600 mg, pencil, minus"].buttons["minus"]
        editMedication.tap()
    }
}
