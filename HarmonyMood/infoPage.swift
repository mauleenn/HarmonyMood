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

//  infoPage.swift
//  HarmonyMood
//
//  Created by Mauleen Ndlovu on 2/4/21.
//

import SwiftUI

struct infoPage: View {
    
    // Application version number
    @State private var versionNumber: Double = 1.0
    
    var body: some View {
        Form {
           // Version #
            Section(header: Text("Version").foregroundColor(.red)) {
                Text("1.0").font(.system(size: 13, weight: .light, design: .rounded))
                .font(.subheadline)
            }
            
            // Version #
             Section(header: Text("What is Harmony Mood?").foregroundColor(.red)) {
                 Text("Harmony Mood is a platform for individuals to track their mood and improve their overall well-being. With Harmony Mood, users can better understand and better manage their moods. Harmony Mood creates a safe space for users to share and feel their feelings. Welcome to Harmony Mood, happy tracking :)").font(.system(size: 13, weight: .light, design: .rounded))
                 .font(.subheadline)
             }
            
            // Medication
            Section(header: Text("Medication").foregroundColor(.red)) {
                Text("Adding a new medication is quite simple on Harmony Mood. All you need to do is to add the name and the dosage. Once your new medication is added, it will be added to the list of exisiting ones. You can also delete and modify any medication on the list.").font(.system(size: 13, weight: .light, design: .rounded))
                    .font(.subheadline)
            }
            
            // Tracking Mood
            Section(header: Text("Tracking Mood").foregroundColor(.red)) {
                Text("To get started, simply start entering your daily moods. You can enter how many hours you slept last night, your depression, elevation, anxiety, and irritability on a scale from 0-10, and any notes for the day.").font(.system(size: 13, weight: .light, design: .rounded))
                    .font(.subheadline)
            }
            
            // Information
            Section(header: Text("⚠️").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)) {
                Text("If you are experiencing a medical emergency, call 911 or your local emergency number immediately.").font(.system(size: 13, weight: .light, design: .rounded))
                    .font(.subheadline)
            }

         // Title of page
        }.navigationBarTitle("Welcome to Harmony Mood!", displayMode: .inline)
}
}

struct infoPage_Previews: PreviewProvider {
    static var previews: some View {
        infoPage()
    }
}
