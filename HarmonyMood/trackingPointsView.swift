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

struct trackingPointsView: View {
    
    // Private vars for tracking points (not optional)
    @State private var hoursSlept = 0
    @State private var depressedMood = ""
    @State private var elevatedMood = ""
    @State private var anxietyMood = ""
    @State private var irritabilityMood = ""
    
    // Date of mood entry submission
    @State private var date = Date()
    
    // Current days notes (if any, optional field)
    @State private var notes = ""
        
    // To go back on the home screen after submission
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
            NavigationView {
                Form {
                    // Hours slept last night
                    Section(header: Text("Hours Slept Last Night")) {
                        Stepper(value: $hoursSlept, in: 0...24, label: {
                            Text("Hours Slept: \(self.hoursSlept)")
                                .foregroundColor(.black)
                                .font(.system(size: 20))
                                .frame(height: 30)
                        })
                    }
                    .foregroundColor(.blueish)
                    .font(.system(size: 15, weight: .bold))
                    
                    // Depression 0-10
                    Section(header: Text("Depression")) {
                        TextField("Depression 0-10", text: $depressedMood)
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                            .frame(height: 30)
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
                    .foregroundColor(.blueish)
                    .font(.system(size: 15, weight: .bold))
                    
                    // Elevation 0-10
                    Section(header: Text("Elevation")) {
                        TextField("Elevation 0-10", text: $elevatedMood)
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                            .frame(height: 30)
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
                    .foregroundColor(.blueish)
                    .font(.system(size: 15, weight: .bold))
                    
                    // Anxiety 0-10
                    Section(header: Text("Anxiety")) {
                        TextField("Anxiety 0-10", text: $anxietyMood)
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                            .frame(height: 30)
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
                    .foregroundColor(.blueish)
                    .font(.system(size: 15, weight: .bold))
                    
                    // Irritability 0-10
                    Section(header: Text("Irritability")) {
                        TextField("Irritability 0-10", text: $irritabilityMood)
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                            .frame(height: 30)
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
                    .foregroundColor(.blueish)
                    .font(.system(size: 15, weight: .bold))
                    
                    // Today's note (if any, optional field)
                    
                    Section(header: Text("Today's Notes")) {
                        TextEditor(text: $notes)
                            //.padding(.leading, keyboard.currentHeight)
                            .accessibility(identifier: "notes")
                            .font(.system(size: 20, weight: .semibold))
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.black)
                            .frame(height: 100)
                    }
                    .foregroundColor(.blueish)
                    .font(.system(size: 15, weight: .bold))
                    
                    // "Add" button
                    VStack {
                    Button(action: {
                        
                        // Call function to add row in sqlite DB
                        DB_Manager().addMood(hoursSleptValue: self.hoursSlept, depressionValue: self.depressedMood, anxietyValue: self.anxietyMood, elevationValue: self.elevatedMood, irritabilityValue: self.irritabilityMood, notesValue: self.notes, dateValue: self.date)
                        
                        // Values reset after user presses 'Add'
                        self.hoursSlept = 0
                        self.depressedMood = ""
                        self.elevatedMood = ""
                        self.anxietyMood = ""
                        self.irritabilityMood = ""
                        self.notes = ""
                    },
                    label: {
                        ZStack {
                            Text("Save")
                                .foregroundColor(.pastelPink)
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                        }
                        .frame(width: 330.0, height: 45.0)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    })
                    // If any of the textfields are empty, the add button will be disabled and not work
                    .disabled($hoursSlept == nil || depressedMood.isEmpty || elevatedMood.isEmpty || anxietyMood.isEmpty || irritabilityMood.isEmpty ||  irritabilityMood.isEmpty)
                    }
                } // End of form
                // Dismiss keyboard if user drags up/down.
                .gesture(DragGesture().onChanged{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)})
                
                // Title of the page
                .navigationBarTitle("How are you feeling?", displayMode: .large)
                
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        HStack {
                            // Link to get to the "History" page
                            NavigationLink (destination: moodHistoryView(), label: {
                                Image(systemName: "calendar").foregroundColor(.black)
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            })
                            Divider()
                            
                            // Link to get to the "Medications" Page
                            NavigationLink(destination: medicationsListView()) {
                                Image(systemName: "pills").foregroundColor(.black)
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            }
                            Divider()
                            
                            // Link to get to the "Welcome to HarmonyMood" Page
                            NavigationLink(destination: infoView()) {
                                Image(systemName: "info.circle").foregroundColor(.black)
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            }
                            Divider()
                            
                            // Link to get to the "Settings" Page
                            NavigationLink(destination: settingsView()) {
                                Image(systemName: "gearshape.2").foregroundColor(.black)
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            }
                        } // End of HStack
                    } // End of ToolbarItemGroup
                } // End of .toolbar
            } // End of Nav View
            .accentColor( .bluePurple)
    } // End of View
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            trackingPointsView()
        }
    }
}
