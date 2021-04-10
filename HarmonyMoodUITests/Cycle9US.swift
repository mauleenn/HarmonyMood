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

//  Cycle9US.swift
//  HarmonyMoodUITests
//
//  Created by Mauleen Ndlovu on 4/9/21.
//


import XCTest

class Cycle9US: XCTestCase {

    func testMoodHistoryDateUS1() {
        let app = XCUIApplication()
        app.launch()
        
        let calendarButton = app.toolbars["Toolbar"].buttons["calendar"]
        XCTAssert(calendarButton.exists)
        calendarButton.tap()
     
        // Checking that the mood entry from Saturday 04/10 logged at 12PM exists
         let moodEntryDate = app.tables/*@START_MENU_TOKEN@*/.staticTexts["Saturday, April 10, 2021 at 12:03:38 PM Central Daylight Time"]/*[[".cells[\"Saturday, April 10, 2021 at 12:03:38 PM Central Daylight Time, Hours Slept: 8, minus.circle, Depression: 0, Anxiety: 2, Elevation: 10, Irritability: 0, Notes: It is a good day so far!\"].staticTexts[\"Saturday, April 10, 2021 at 12:03:38 PM Central Daylight Time\"]",".staticTexts[\"Saturday, April 10, 2021 at 12:03:38 PM Central Daylight Time\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
         moodEntryDate.tap()
         XCTAssert(moodEntryDate.exists)
        
        /*
        let tablesQuery = XCUIApplication().tables
        let notesItIsAGoodDaySoFarStaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Notes: It is a good day so far!"]/*[[".cells[\"Saturday, April 10, 2021 at 12:03:38 PM Central Daylight Time, Hours Slept: 8, minus.circle, Depression: 0, Anxiety: 2, Elevation: 10, Irritability: 0, Notes: It is a good day so far!\"].staticTexts[\"Notes: It is a good day so far!\"]",".staticTexts[\"Notes: It is a good day so far!\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        notesItIsAGoodDaySoFarStaticText.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Saturday, April 10, 2021 at 12:03:38 PM Central Daylight Time"]/*[[".cells[\"Saturday, April 10, 2021 at 12:03:38 PM Central Daylight Time, Hours Slept: 8, minus.circle, Depression: 0, Anxiety: 2, Elevation: 10, Irritability: 0, Notes: It is a good day so far!\"].staticTexts[\"Saturday, April 10, 2021 at 12:03:38 PM Central Daylight Time\"]",".staticTexts[\"Saturday, April 10, 2021 at 12:03:38 PM Central Daylight Time\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Hours Slept: 8"]/*[[".cells[\"Saturday, April 10, 2021 at 12:03:38 PM Central Daylight Time, Hours Slept: 8, minus.circle, Depression: 0, Anxiety: 2, Elevation: 10, Irritability: 0, Notes: It is a good day so far!\"].staticTexts[\"Hours Slept: 8\"]",".staticTexts[\"Hours Slept: 8\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Depression: 0"]/*[[".cells[\"Saturday, April 10, 2021 at 12:03:38 PM Central Daylight Time, Hours Slept: 8, minus.circle, Depression: 0, Anxiety: 2, Elevation: 10, Irritability: 0, Notes: It is a good day so far!\"].staticTexts[\"Depression: 0\"]",".staticTexts[\"Depression: 0\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Anxiety: 2"]/*[[".cells[\"Saturday, April 10, 2021 at 12:03:38 PM Central Daylight Time, Hours Slept: 8, minus.circle, Depression: 0, Anxiety: 2, Elevation: 10, Irritability: 0, Notes: It is a good day so far!\"].staticTexts[\"Anxiety: 2\"]",".staticTexts[\"Anxiety: 2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Elevation: 10"]/*[[".cells[\"Saturday, April 10, 2021 at 12:03:38 PM Central Daylight Time, Hours Slept: 8, minus.circle, Depression: 0, Anxiety: 2, Elevation: 10, Irritability: 0, Notes: It is a good day so far!\"].staticTexts[\"Elevation: 10\"]",".staticTexts[\"Elevation: 10\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Irritability: 0"]/*[[".cells[\"Saturday, April 10, 2021 at 12:03:38 PM Central Daylight Time, Hours Slept: 8, minus.circle, Depression: 0, Anxiety: 2, Elevation: 10, Irritability: 0, Notes: It is a good day so far!\"].staticTexts[\"Irritability: 0\"]",".staticTexts[\"Irritability: 0\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

        */
    }
    
    func testCalendarNavigationUS2() {
        let app = XCUIApplication()
        app.launch()
        
        let calendarButton = app.toolbars["Toolbar"].buttons["calendar"]
        XCTAssert(calendarButton.exists)
        calendarButton.tap()
        
        let moodHistoryNavigationBar = app.navigationBars["Mood History"]
        XCTAssert(moodHistoryNavigationBar.exists)
    }
    
    func testMedicationNavigationUS2() {
        
        let app = XCUIApplication()
        app.launch()
        
        let medicationButton = app.toolbars["Toolbar"].buttons["pills"]
        XCTAssert(medicationButton.exists)
        medicationButton.tap()
        
        let medicationsListNavigationBar = app.navigationBars["Medications List"]
        XCTAssert(medicationsListNavigationBar.exists)
    }
    
    func testInfoNavigationUS2() {
        let app = XCUIApplication()
        app.launch()
        
        let infoButton = app.toolbars["Toolbar"].buttons["info.circle"]
        XCTAssert(infoButton.exists)
        infoButton.tap()
        
        let infoNavigationBar = app.navigationBars["Welcome to Harmony Mood!"]
        XCTAssert(infoNavigationBar.exists)
    }
    
    func testSettingsNavigationUS2() {
        
        let app = XCUIApplication()
        app.launch()
        
        let settingsButton = app.toolbars["Toolbar"].buttons["gearshape.2"]
        XCTAssert(settingsButton.exists)
        settingsButton.tap()
        
        let settingsNavigationBar = app.navigationBars["Settings"]
        XCTAssert(settingsNavigationBar.exists)
    }
    
    

}
