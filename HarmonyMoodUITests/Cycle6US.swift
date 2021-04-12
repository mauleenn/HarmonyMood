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

//  Cycle6US.swift
//  HarmonyMood
//
//  Created by Mauleen Ndlovu on 2/24/21.
//

import XCTest

class Cycle6US: XCTestCase {
    
    
    // Cycle 6 US:1
    func testnavigationToMedicationListView() {
        let app = XCUIApplication()
        app.launch()
        
        // Link to Medications page
        let medicationButton = app.toolbars["Toolbar"].buttons["pills"]
        XCTAssert(medicationButton.exists)
        medicationButton.tap()
    }
    
    // Cycle 6 US:2
    func testnavigationToInfoPageView() {
        let app = XCUIApplication()
        app.launch()
        
        // Link to Info page
        let infoButton = app.toolbars["Toolbar"].buttons["info.circle"]
        XCTAssert(infoButton.exists)
        infoButton.tap()
    }
}
