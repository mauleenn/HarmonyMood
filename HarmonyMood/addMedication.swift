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

//  addMedication.swift
//  HarmonyMood
//
//  Created by Mauleen Ndlovu on 2/4/21.
//

import SwiftUI
import Combine

struct addMedication: View {
    
       @State private var medicationName: String = ""
       @State private var medicationDosage: String = ""
       @State private var medicationUnits: String = ""

       @State private var medicationStartingDate = Date()
       @State private var medicationTimeofDay: Int = 0
       @State private var mgUnit: Int = 0

       private var timeOfDayOptions = ["🌞 AM", "🌙 PM", "🌓 Both"]
       private var medicationUnit = ["mg"]
    
       @State private var enterButtonPress = false
   
       var body: some View {
               Form {
                   // Medication name, dosage, unit, and time of day
                   Section(header: Text("Information")) {
                       TextField("Medication Name", text: $medicationName)
                    
                       // Medication dosage
                       TextField("Dosage", text: $medicationDosage)
                        .keyboardType(.numberPad)
                        .onReceive(Just(medicationDosage)) {
                            guard !$0.isEmpty else {
                            self.medicationDosage = ""
                            return
                            }
                            if let value = Int($0.filter(\.isWholeNumber)) {
                               self.medicationDosage = String(value)
                               }
                          }
                    
                    // Medication unit is mg
                    Picker("Units", selection: $mgUnit) {
                        ForEach(0..<medicationUnit.count) {
                            Text(self.medicationUnit[$0])
                        }
                    }
                    
                    // Medication can be taken in the morning, evening, or both
                    Picker("Time of Day", selection: $medicationTimeofDay) {
                        ForEach(0..<timeOfDayOptions.count) {
                            Text(self.timeOfDayOptions[$0])
                        }
                       }.pickerStyle( SegmentedPickerStyle())
                   }

                    // Starting date of medication
                   Section(header: Text("Starting Date")) {
                       DatePicker(selection: $medicationStartingDate, in: ...Date(), displayedComponents: .date) {
                           Text("Date")
                       }
                   }
                   
                // "Enter" button
                Section {
                    Button("Save") {
                        self.enterButtonPress = true
                    }
                    .alert(isPresented: $enterButtonPress) {
                        Alert(title: Text("Successfully Added💊"), dismissButton: .default(Text("OK")))
                    }
                }
                
                // Link to "Welcome to Harmony Mood!" info page
                NavigationLink(destination: infoPage()) {
                                  Text("Welcome to Harmony Mood!")
                }
                // Title of page
               }.navigationBarTitle("Add New Medication")
       }
   }


struct medicationTrackingPoint_Previews: PreviewProvider {
    static var previews: some View {
        addMedication()
    }
}
