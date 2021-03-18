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

//  trackingPoints.swift
//  HarmonyMood
//
//  Created by Mauleen Ndlovu on 2/4/21.
//

import SwiftUI
import Combine

struct trackingPoints: View {
    
    // Private vars for tracking points (not optional)
    @State private var hoursSlept = 0
    @State private var depressedMood = ""
    @State private var elevatedMood = ""
    @State private var anxietyMood = ""
    @State private var irritabilityMood = ""
    
    // Current days notes (if any, optional field)
    @State private var notes = ""
    
    

    // Var for "Add" button
    @State private var addEntryButton = false
    
    // To go back on the home screen after submission
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
  
    var body: some View {
        VStack {
            NavigationView {
                    Form {
                        // Hours slept last night
                        Section(header: Text("Hours Slept Last Night")) {
                        Stepper(value: $hoursSlept, in: 0...24, label: {
                            Text("Hours Slept: \(self.hoursSlept)")
                                .cornerRadius(2)
                                .font(.system(size: 16.5))
                        })
                        }
                        
                        // Depression 0-10
                        Section(header: Text("Depression")) {
                        TextField("Depression 0-10", text: $depressedMood)
                            .cornerRadius(2)
                            .keyboardType(.numberPad)
                            .onReceive(Just(depressedMood)) {
                                guard let value = Int($0), 0...10 ~= value
                                else {
                                    self.depressedMood = ""
                                    return
                                }
                                self.depressedMood = String(value)
                            }
                        }
                        
                        // Elevation 0-10
                        Section(header: Text("Elevation")) {
                        TextField("Elevation 0-10", text: $elevatedMood)
                            .cornerRadius(2)
                            .keyboardType(.numberPad)
                            .onReceive(Just(elevatedMood)) {
                                guard let value = Int($0), 0...10 ~= value
                                else {
                                    self.elevatedMood = ""
                                    return
                                }
                                self.elevatedMood = String(value)
                            }
                        }
                        
                        // Anxiety 0-10
                        Section(header: Text("Anxiety")) {
                        TextField("Anxiety 0-10", text: $anxietyMood)
                            .cornerRadius(2)
                            .keyboardType(.numberPad)
                            .onReceive(Just(anxietyMood)) {
                                guard let value = Int($0), 0...10 ~= value
                                else {
                                    self.anxietyMood = ""
                                    return
                                }
                                self.anxietyMood = String(value)
                            }
                        }
                        
                        // Irritability 0-10
                        Section(header: Text("Irritability")) {
                        TextField("Irritability 0-10", text: $irritabilityMood)
                            .cornerRadius(2)
                            .keyboardType(.numberPad)
                            .onReceive(Just(irritabilityMood)) {
                                guard let value = Int($0), 0...10 ~= value
                                else {
                                    self.irritabilityMood = ""
                                    return
                                }
                                self.irritabilityMood = String(value)
                            }
                        }
                        
                        // Today's note (if any, optional field)
                        Section(header: Text("Today's Notes")) {
                        TextEditor(text: $notes)
                            .accessibility(identifier: "notes")
                            .font(.system(size: 15, weight: .semibold))
                            .multilineTextAlignment(.leading)
                            .frame(height: 100)
                            .background(
                                Rectangle()
                                    .foregroundColor(Color.gray.opacity(0.1))
                                    .clipped()
                            )
                            .cornerRadius(2)
                        }
            
                        // "Add" button
                        Button(action: {
                            
                            // Call function to add row in sqlite DB
                            DB_Manager().addMood(hoursSleptValue: self.hoursSlept, depressionValue: self.depressedMood, anxietyValue: self.anxietyMood, elevationValue: self.elevatedMood, irritabilityValue: self.irritabilityMood, notesValue: self.notes)
                    
                            // Values reset after user presses 'Add'
                            self.hoursSlept = 0
                            self.depressedMood = ""
                            self.elevatedMood = ""
                            self.anxietyMood = ""
                            self.irritabilityMood = ""
                            self.notes = ""
                        },
                        label: {
                            Text("Add")
                        })
                        // If any of the textfields are empty, the add button will be disabled and not work
                        .disabled($hoursSlept == nil || depressedMood.isEmpty || elevatedMood.isEmpty || anxietyMood.isEmpty || irritabilityMood.isEmpty ||  irritabilityMood.isEmpty)
                      
                    }
                   // End of Form
                
                // Title of the page
                .navigationBarTitle("Tracking Points", displayMode: .inline)
                .padding()
                .navigationBarItems(
                                        trailing:
                                            HStack {
                                                
                                                // Link to get to the "History" page
                                                NavigationLink (destination: moodHistoryView(), label: {
                                                    Text("📅")
                                                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                                })
                                                // Link to get to the "Medications List" Page
                                                NavigationLink(destination: medicationList()) {
                                                    Text("💊")
                                                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                                }
                                                
                                                // Link to get to the "Welcome to HarmonyMood" Page
                                                NavigationLink(destination: infoPage()) {
                                                    Text("ℹ️")
                                                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                                }
                                            } // End of HStack
                                    )
                
                } // End of NavigationView
    
        } // End of Vstack
        
    } // End of View
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
                trackingPoints()
        }
    }
}
