//
//  Cycle7US.swift
//  HarmonyMoodUITests
//
//  Created by Mauleen Ndlovu on 3/14/21.
//

import XCTest

class Cycle7US: XCTestCase {

    // Cycle 7 US:1 - Testing mood entry persistence
   func US1TestMoodEntryPersistence() {
        let app = XCUIApplication()
        app.launch()
     
        // By pressing this button I will get to the second view
        let medicationsListLink = app.navigationBars["Tracking Points"].buttons["💊"]
        XCTAssert(medicationsListLink.exists)
        medicationsListLink.tap()
    }

    // Cycle 7 US:2 - Testing that user enters in values
    // for mood textfields. If they don't, the 'Add' button
    // will be disabled
   func US2TestEmptyTxtFieldMoodEntry() {
        let app = XCUIApplication()
        app.launch()
    
        let hoursSleptStepper = app.otherElements["Hours Slept: 0"]
        hoursSleptStepper.tap(withNumberOfTaps: 3, numberOfTouches: 3) // Should be 3
    
        let elevationTxtField = app.textFields["Elevation 0-10"]
        elevationTxtField.tap()
        elevationTxtField.typeText("7")
        
        let anxietyTxtField = app.textFields["Anxiety 0-10"]
        anxietyTxtField.tap()
        anxietyTxtField.typeText("4")
    
        let irritabilityTxtField = app.textFields["Irritability 0-10"]
        irritabilityTxtField.tap()
        irritabilityTxtField.typeText("0")
        app.tables.staticTexts["IRRITABILITY"].swipeUp()

        // Tests to check that the 'Add' button is not enabled
        // because not all the textfields are filled.
        let addMoodButton = app.buttons["Add"]
        XCTAssertEqual(addMoodButton.isEnabled, false)
    }
    
    // Cycle 7 US:3 - Testing that user enters in values
    // for medication textfields. If they don't, the
    // 'Add' button will be disabled
   func US3TestEmptyTxtFieldMedicationEntry() {
        let app = XCUIApplication()
        app.launch()
    
        // By pressing this button I will get to the second view
        let medicationsListLink = app.navigationBars["Tracking Points"].buttons["💊"]
        XCTAssert(medicationsListLink.exists)
        medicationsListLink.tap()
    
        let medicationsListNavigationBar = app.navigationBars["Medications List"]
    
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
    
    // Cycle 7 US:4 - Testing mood entry persistence
   func US4TestAddingNotes() {
        let app = XCUIApplication()
        app.launch()
    
        let hoursSleptStepper = app.otherElements["Hours Slept: 0"]
        hoursSleptStepper.tap(withNumberOfTaps: 3, numberOfTouches: 3) // Should be 3
        
        let depressionTxtField = app.textFields["Depression 0-10"]
        depressionTxtField.tap()
        depressionTxtField.typeText("0")

        let elevationTxtField = app.textFields["Elevation 0-10"]
        elevationTxtField.tap()
        elevationTxtField.typeText("7")
        
        let anxietyTxtField = app.textFields["Anxiety 0-10"]
        anxietyTxtField.tap()
        anxietyTxtField.typeText("4")

        let irritabilityTxtField = app.textFields["Irritability 0-10"]
        irritabilityTxtField.tap()
        irritabilityTxtField.typeText("0")
    
        

        let notesTxtField = app.textViews[" "]
        notesTxtField.tap()
        notesTxtField.typeText("Please work")
     
    }
    
    // Cycle 7 US:5 - Testing that the mood history page
    // exists and the button to get to the page works and
    // exists.
    func US5TestMoodHistoryPage() {
        let app = XCUIApplication()
        app.launch()
        
        // Testing to see if the button exists
        let moodHistoryButton = app.navigationBars["Tracking Points"].buttons["📅"]
        XCTAssertTrue(moodHistoryButton.exists)
        moodHistoryButton.tap()
        
        // Testing to see that the mood history page
        // exists
        let moodHistoryNavBar = app.navigationBars.staticTexts["History"]
        XCTAssertTrue(moodHistoryNavBar.exists)
    }
    
    // Cycle 7 US:6 - Testing that user enters in values
    // for edit medication textfields. If they don't, the
    // 'Save' button will be disabled
   func US6TestEmptyTxtFieldEditMedication() {
        let app = XCUIApplication()
        app.launch()
    
        // By pressing this button I will get to the second view
        let medicationsListLink = app.navigationBars["Tracking Points"].buttons["💊"]
        XCTAssert(medicationsListLink.exists)
        medicationsListLink.tap()
    
        let editMedication = app.tables.cells["Ibuprofen, 100 mg, pencil, ➖"].buttons["pencil"]
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
