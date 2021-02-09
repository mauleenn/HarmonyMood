/*
 Copyright 2020 Mauleen Ndlovu
 
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

//  HarmonyMoodUITests.swift
//  HarmonyMoodUITests
//
//  Created by Mauleen Ndlovu on 10/14/20.

import XCTest

class HarmonyMoodUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    // Tests that the Nav Bar title named "Tracking Points" exists
    func testNavBar() {
        let app = XCUIApplication()
        app.launch()
        
        let trackingPointsNavBar = app.navigationBars.staticTexts["Tracking Points"]
        XCTAssertTrue(trackingPointsNavBar.exists)
    }
    
    
    // Test "Hours Slept" Stepper
    func testHoursSleptStepper() {
        let app = XCUIApplication()
        app.launch()
        
        let hoursSleptStepper = app.otherElements["Hours Slept: 0"]
        hoursSleptStepper.tap(withNumberOfTaps: 3, numberOfTouches: 3) // Should be 3

        app.buttons["Enter"].tap()
        app.alerts["Success!"].buttons["OK"].tap()
    }
    
    
    // Test "Depression" Text Field
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
    
    
    // Test "Elevation" Text Field
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
    
    
    // Test "Anxiety" Text Field
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
    
    
    // Test "Irritability" Text Field
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
    
     
    // Test that the Nav Bar title named "Medication List" exists
    func testMedicationListNavigation() {
        let app = XCUIApplication()
        app.launch()
        
        
        // By pressing this button I will get to the second view
        let medicationsListLink = app.tables/*@START_MENU_TOKEN@*/.buttons["Medications List"]/*[[".cells[\"Add Medication\"].buttons[\"Add Medication\"]",".buttons[\"Add Medication\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssert(medicationsListLink.exists)
        medicationsListLink.tap()
        
        XCTAssertTrue(app.navigationBars.staticTexts["Medications List"].exists)
    }
    
    // Test that the Nav Bar title named "Medications List" exists
    func testInfoPageNavigation() {
        let app = XCUIApplication()
        app.launch()
        
        // By pressing this button I will get to the second page
        let medicationsListLink = app.tables/*@START_MENU_TOKEN@*/.buttons["Medications List"]/*[[".cells[\"Add Medication\"].buttons[\"Add Medication\"]",".buttons[\"Add Medication\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssert(medicationsListLink.exists)
        medicationsListLink.tap()

        XCTAssertTrue(app.navigationBars.staticTexts["Medications List"].exists)
    }
    
    // Test "Dosage" Text Field
    func testMedDosage() {
        let app = XCUIApplication()
        app.launch()
        
        // By pressing this button I will get to the second view
        let medicationsListLink = app.tables/*@START_MENU_TOKEN@*/.buttons["Medications List"]/*[[".cells[\"Add Medication\"].buttons[\"Add Medication\"]",".buttons[\"Add Medication\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
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
    
    // Testing "Info" button exists on the "Medications List" page
    func testInfoButton() {
        let app = XCUIApplication()
        app.launch()
        
        // By pressing this button I will get to the second view
        let medicationsListLink = app.tables/*@START_MENU_TOKEN@*/.buttons["Medications List"]/*[[".cells[\"Add Medication\"].buttons[\"Add Medication\"]",".buttons[\"Add Medication\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssert(medicationsListLink.exists)
        medicationsListLink.tap()
       
        let medicationsListNavigationBar = app.navigationBars["Medications List"]
        
        // Test if "medicationsListNavigationBar" exists
        XCTAssert(medicationsListNavigationBar.exists)
        
        let infoButton = medicationsListNavigationBar.buttons["ℹ️"]
        XCTAssert(infoButton.exists)
    }
    
    // Testing "Welcome to Harmony Mood" info page exists
    func testInfoPage() {
    let app = XCUIApplication()
    app.launch()
    
    // By pressing this button I will get to the second view
    let medicationsListLink = app.tables/*@START_MENU_TOKEN@*/.buttons["Medications List"]/*[[".cells[\"Add Medication\"].buttons[\"Add Medication\"]",".buttons[\"Add Medication\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
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
    
    // Testing "Add" button exists on the "Medications List" page
    func testAddButton() {
        let app = XCUIApplication()
        app.launch()
        
        // By pressing this button I will get to the second view
        let medicationsListLink = app.tables/*@START_MENU_TOKEN@*/.buttons["Medications List"]/*[[".cells[\"Add Medication\"].buttons[\"Add Medication\"]",".buttons[\"Add Medication\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssert(medicationsListLink.exists)
        medicationsListLink.tap()
        
        let medicationsListNavigationBar = app.navigationBars["Medications List"]
        
        // Test if "medicationsListNavigationBar" exists
        XCTAssert(medicationsListNavigationBar.exists)
        
        let addButton = medicationsListNavigationBar.buttons["➕"]
        XCTAssert(addButton.exists)
    }
    
    // Testing adding a new medication on the "Medications List" page
    func testAddingNewMedication() {
        let app = XCUIApplication()
        app.launch()
        
        // By pressing this button I will get to the second view
        let medicationsListLink = app.tables/*@START_MENU_TOKEN@*/.buttons["Medications List"]/*[[".cells[\"Add Medication\"].buttons[\"Add Medication\"]",".buttons[\"Add Medication\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
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
        // text field. After we type the medication we will check
        // if we actually did this correctly.
        let medNameTxtField = app.tables.cells["Medication Name: "]
        medNameTxtField.tap()
        medNameTxtField.typeText("Seroquel")
        XCTAssert(medNameTxtField.exists)
        
        
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        // Test that types "100" into the "Medication Dosage"
        // text field. After we type the dosage we will check
        // if we actually did this correctly.
        let medDosageTxtField = app.tables.cells["Dosage: "]
        medDosageTxtField.tap()
        medDosageTxtField.typeText("100")
        
        // Click on "Units" button which is automatically set to mg.
        // Click on "🌞 AM" as time of day.
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Units"].tap()
        app.buttons["🌞 AM"].tap()
        
        // Test to select today's date as starting date
        // After this we check if we did this correctly.
        let datePicker =  app.tables.datePickers.containing(.other, identifier:"Date Picker").element
        XCTAssertTrue(datePicker.exists)
        datePicker.tap()
        
        // After user enters in the medication, they need to press
        // the 'Add' button.
         app.buttons["Add"].tap()
 }
    
    // Testing to see if we added the correct medication
    func testAddingCorrectMedication() {
    let app = XCUIApplication()
    app.launch()
    
    // By pressing this button I will get to the second view
    let medicationsListLink = app.tables/*@START_MENU_TOKEN@*/.buttons["Medications List"]/*[[".cells[\"Add Medication\"].buttons[\"Add Medication\"]",".buttons[\"Add Medication\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
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
    app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
    
    // Test that what we entered is not equal to "Lamictal"
    let addNewMedTxt = medNameTxtField.value as? String
    XCTAssertNotEqual(addNewMedTxt, "Lamictal")
    }
    
    // Testing "Delete" button exists on the "Medications List" page
    func testDeleteButton() {
        let app = XCUIApplication()
        app.launch()
        
        // By pressing this button I will get to the second view
        let medicationsListLink = app.tables/*@START_MENU_TOKEN@*/.buttons["Medications List"]/*[[".cells[\"Add Medication\"].buttons[\"Add Medication\"]",".buttons[\"Add Medication\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssert(medicationsListLink.exists)
        medicationsListLink.tap()
       
        let medicationsListNavigationBar = app.navigationBars["Medications List"]
        
        // Test if "medicationsListNavigationBar" exists
        XCTAssert(medicationsListNavigationBar.exists)
        
        let deleteButton = medicationsListNavigationBar.buttons["➖"]
        XCTAssert(deleteButton.exists)
    }
    
  // Test "Units" button
    func testMedicationUnit() {
         let app = XCUIApplication()
         app.launch()
         
         // By pressing this button I will get to the second view
         let medicationsListLink = app.tables/*@START_MENU_TOKEN@*/.buttons["Medications List"]/*[[".cells[\"Add Medication\"].buttons[\"Add Medication\"]",".buttons[\"Add Medication\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
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
        
        app.buttons["Units"].tap()
    }
    
   
    // Test "Starting Date"
    func testDatePicker() {
         let app = XCUIApplication()
         app.launch()
      
         // By pressing this button I will get to the second view
         let medicationsListLink = app.tables/*@START_MENU_TOKEN@*/.buttons["Medications List"]/*[[".cells[\"Add Medication\"].buttons[\"Add Medication\"]",".buttons[\"Add Medication\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
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
    
    
    // Test "Time of Day" Buttons (🌞 AM, 🌙 PM, 🌓 Both)
    func testTimeofDayButtons() {
        let app = XCUIApplication()
        app.launch()
     
        // By pressing this button I will get to the second view
        let medicationsListLink = app.tables/*@START_MENU_TOKEN@*/.buttons["Medications List"]/*[[".cells[\"Add Medication\"].buttons[\"Add Medication\"]",".buttons[\"Add Medication\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
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
        
        app.buttons["Add"].tap()
    }
 
}
 
