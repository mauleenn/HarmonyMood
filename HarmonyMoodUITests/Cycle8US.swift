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

//  Cycle8US.swift
//  HarmonyMoodUITests
//
//  Created by Mauleen Ndlovu on 3/31/21.
//

import XCTest

class Cycle8US: XCTestCase {

    func testSettingsTitleUS1() {
        let app = XCUIApplication()
        app.launch()
        
        let settingsButton = app.navigationBars["Tracking Points"].buttons["gearshape.fill"]
        settingsButton.tap()
        
        XCTAssertTrue(app.navigationBars.staticTexts["Settings"].exists)
    }
    
    func testAddNameUS1() {
        let app = XCUIApplication()
        app.launch()
        
        let settingsButton = app.navigationBars["Tracking Points"].buttons["gearshape.fill"]
        settingsButton.tap()

        let nametxtField = app.tables.cells["person.fill, What is your name?"]
        nametxtField.tap()
        nametxtField.typeText("Mauleen")
    }
    
    func testAddPasscodeUS1() {
        let app = XCUIApplication()
        app.launch()
        
        let settingsButton = app.navigationBars["Tracking Points"].buttons["gearshape.fill"]
        settingsButton.tap()
        
        app.tables.switches["Enable Passcode"].tap()
        
        let passcodetxtField = app.tables.cells["****"]
        passcodetxtField.tap()
        passcodetxtField.typeText("3082")
    }
    
    func testAllSettingsUS1() {
        
        let app = XCUIApplication()
        app.launch()
        
        let settingsButton = app.navigationBars["Tracking Points"].buttons["gearshape.fill"]
        settingsButton.tap()
        
        let nametxtField = app.tables.cells["person.fill, What is your name?"]
        nametxtField.tap()
        nametxtField.typeText("Mauleen")
        
        let passcodeToggle = app.tables.switches["Enable Passcode"]
        passcodeToggle.tap()
        
        let passcodetxtField = app.tables.cells["****"]
        passcodetxtField.tap()
        passcodetxtField.typeText("3082")
        
        app.tables.switches["Enabled"].tap()
        
        let notificationsToggle = app.tables/*@START_MENU_TOKEN@*/.switches["Enabled"]/*[[".cells[\"Enabled\"].switches[\"Enabled\"]",".switches[\"Enabled\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        notificationsToggle.tap()
      
        app.buttons["Save"].tap()
    }


}
