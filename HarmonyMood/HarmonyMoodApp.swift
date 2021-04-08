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

//  HarmonyMoodApp.swift
//  HarmonyMood
//
//  Created by Mauleen Ndlovu on 10/14/20.

import SwiftUI

@main
struct HarmonyMoodApp: App {
    var body: some Scene {
        WindowGroup {
            trackingPointsView()
            }
    }
}

struct HarmonyMoodApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
