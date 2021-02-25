//
//  Cycle5US.swift
//  HarmonyMood
//
//  Created by Mauleen Ndlovu on 2/24/21.
//

import XCTest

class Cycle5US: XCTestCase {

    //Cycle 5: Test "Dosage" Text Field
    func testMedDosage() {
        let app = XCUIApplication()
        app.launch()
        
        // By pressing this button I will get to the second view
        let medicationsListLink = app.navigationBars["Tracking Points"].buttons["💊"]
        XCTAssert(medicationsListLink.exists)
        medicationsListLink.tap()

        
        let medicationsListNavigationBar = app.navigationBars["Medications List"]
        
        // Test if "medicationsListNavigationBar" exists
        XCTAssert(medicationsListNavigationBar.exists)
        
        // Test to see if the add button exists, after we check
        // we will press on it and then go to the add medication
        // form
        let addButton = medicationsListNavigationBar.buttons["➕"]
        XCTAssert(addButton.exists)
        addButton.tap()

        // Test that types "100" into the "Medication Dosage"
        // text field. After we type the dosage we will check
        // if we actually did this correctly.
        let medDosageTxtField = app.tables.cells["Dosage: "]
        medDosageTxtField.tap()
        medDosageTxtField.typeText("100")
        
    }
    
    //Cycle 5: Testing "Info" button exists on the "Medications List" page
    func testInfoButton() {
        let app = XCUIApplication()
        app.launch()
        
        // By pressing this button I will get to the second view
        let medicationsListLink = app.navigationBars["Tracking Points"].buttons["💊"]
        XCTAssert(medicationsListLink.exists)
        medicationsListLink.tap()

       
        let medicationsListNavigationBar = app.navigationBars["Medications List"]
        
        // Test if "medicationsListNavigationBar" exists
        XCTAssert(medicationsListNavigationBar.exists)
        
        let infoButton = medicationsListNavigationBar.buttons["ℹ️"]
        XCTAssert(infoButton.exists)
    }
    
    //Cycle 5: Testing "Welcome to Harmony Mood" info page exists
    func testInfoPage() {
    let app = XCUIApplication()
    app.launch()
    
    // By pressing this button I will get to the second view
    let medicationsListLink = app.navigationBars["Tracking Points"].buttons["💊"]
    XCTAssert(medicationsListLink.exists)
    medicationsListLink.tap()

    
    
    let medicationsListNavigationBar = app.navigationBars["Medications List"]
    
    // Test if "medicationsListNavigationBar" exists
    XCTAssert(medicationsListNavigationBar.exists)
    
    // Test if "infoPageButton" exists
    let infoPageButton = medicationsListNavigationBar.buttons["ℹ️"]
    XCTAssert(infoPageButton.exists)
    
    // Test if "Welcome to Harmony Mood!" info page exists
    infoPageButton.tap()
    XCTAssertTrue(app.navigationBars.staticTexts["Welcome to Harmony Mood!"].exists)
    }

    // Testing "Delete" button exists on the "Medications List" page
    func testDeleteButton() {
        let app = XCUIApplication()
        app.launch()
        
        // By pressing this button I will get to the second view
        let medicationsListLink = app.navigationBars["Tracking Points"].buttons["💊"]
        XCTAssert(medicationsListLink.exists)
        medicationsListLink.tap()

       
        let medicationsListNavigationBar = app.navigationBars["Medications List"]
        XCTAssert(medicationsListNavigationBar.exists)  // Test if "medicationsListNavigationBar" exists
    }
    
    
    //Cycle 5: Test "Starting Date"
    func testDatePicker() {
         let app = XCUIApplication()
         app.launch()
      
        // By pressing this button I will get to the second view
        let medicationsListLink = app.navigationBars["Tracking Points"].buttons["💊"]
        XCTAssert(medicationsListLink.exists)
        medicationsListLink.tap()

      
         let medicationsListNavigationBar = app.navigationBars["Medications List"]
      
         // Test if "medicationsListNavigationBar" exists
         XCTAssert(medicationsListNavigationBar.exists)
      
         // Test to see if the add button exists, after we check
         // we will press on it and then go to the add medication
         // form
         let addButton = medicationsListNavigationBar.buttons["➕"]
         XCTAssert(addButton.exists)
         addButton.tap()
        
        let datePicker =  app.tables.datePickers.containing(.other, identifier:"Date Picker").element
        XCTAssertTrue(datePicker.exists)
        datePicker.tap()
    }
    
    //Cycle 5: Test "Time of Day" Buttons (🌞 AM, 🌙 PM, 🌓 Both)
    func testTimeofDayButtons() {
        let app = XCUIApplication()
        app.launch()
     
        // By pressing this button I will get to the second view
        let medicationsListLink = app.navigationBars["Tracking Points"].buttons["💊"]
        XCTAssert(medicationsListLink.exists)
        medicationsListLink.tap()

        let medicationsListNavigationBar = app.navigationBars["Medications List"]
     
        // Test if "medicationsListNavigationBar" exists
        XCTAssert(medicationsListNavigationBar.exists)
     
        // Test to see if the add button exists, after we check
        // we will press on it and then go to the add medication
        // form
        let addButton = medicationsListNavigationBar.buttons["➕"]
        XCTAssert(addButton.exists)
        addButton.tap()

        app.buttons["🌞 AM"].tap()
        app.buttons["🌙 PM"].tap()
        app.buttons["🌓 Both"].tap()
    }
    
    
    //Cycle 5: Testing to see if we added the correct medication
    func testAddingCorrectMedication() {
    let app = XCUIApplication()
    app.launch()
    
    // By pressing this button I will get to the second view
    let medicationsListLink = app.navigationBars["Tracking Points"].buttons["💊"]
    XCTAssert(medicationsListLink.exists)
    medicationsListLink.tap()

    
    let medicationsListNavigationBar = app.navigationBars["Medications List"]
    
    // Test if "medicationsListNavigationBar" exists
    XCTAssert(medicationsListNavigationBar.exists)
    
    // Test to see if the add button exists, after we check
    // we will press on it and then go to the add medication
    // form
    let addButton = medicationsListNavigationBar.buttons["➕"]
    XCTAssert(addButton.exists)
    addButton.tap()
    
    // Test that types "Seroquel" into the "Medication Name"
    // text field.
    let medNameTxtField = app.tables.cells["Medication Name: "]
    medNameTxtField.tap()
    medNameTxtField.typeText("Seroquel")
    
    // Test that what we entered is not equal to "Lamictal"
    let addNewMedTxt = medNameTxtField.value as? String
    XCTAssertNotEqual(addNewMedTxt, "Lamictal")
    }
    
    //Cycle 5: Testing "Add" button exists on the "Medications List" page
    func testAddButton() {
        let app = XCUIApplication()
        app.launch()
        
        // By pressing this button I will get to the second view
        let medicationsListLink = app.navigationBars["Tracking Points"].buttons["💊"]
        XCTAssert(medicationsListLink.exists)
        medicationsListLink.tap()

        
        let medicationsListNavigationBar = app.navigationBars["Medications List"]
        
        // Test if "medicationsListNavigationBar" exists
        XCTAssert(medicationsListNavigationBar.exists)
        
        let addButton = medicationsListNavigationBar.buttons["➕"]
        XCTAssert(addButton.exists)
    }

    //Cycle 5 US:2 Testing adding a new medication on the "Medications List" page
    func testAddingNewMedication() {
        let app = XCUIApplication()
        app.launch()
        
        // By pressing this button I will get to the second view
        let medicationsListLink = app.navigationBars["Tracking Points"].buttons["💊"]
        XCTAssert(medicationsListLink.exists)
        medicationsListLink.tap()

        
        let medicationsListNavigationBar = app.navigationBars["Medications List"]
        XCTAssert(medicationsListNavigationBar.exists)  // Test if "medicationsListNavigationBar" exists
        
        // Test to see if the add button exists, after we check
        // we will press on it and then go to the add medication
        // form
        let addButton = medicationsListNavigationBar.buttons["➕"]
        XCTAssert(addButton.exists)
        addButton.tap()
        
        // Test that types "Seroquel" into the "Medication Name"
        // text field. After we type the medication we will check
        // if we actually did this correctly.
        let medNameTxtField = app.tables.cells["Medication Name: "]
        medNameTxtField.tap()
        medNameTxtField.typeText("Advil")
        XCTAssert(medNameTxtField.exists)
        
        
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        // Test that types "100" into the "Medication Dosage"
        // text field. After we type the dosage we will check
        // if we actually did this correctly.
        let medDosageTxtField = app.tables.cells["Dosage: "]
        medDosageTxtField.tap()
        medDosageTxtField.typeText("100")
        
        // Test to select today's date as starting date
        // After this we check if we did this correctly.
        let datePicker =  app.tables.datePickers.containing(.other, identifier:"Date Picker").element
        XCTAssertTrue(datePicker.exists)
        datePicker.tap()
        
        // After user enters in the medication, they need to press
        // the 'Add' button.
         app.buttons["Add"].tap()
 }
}
