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

//  trackingPoints.swift
//  HarmonyMood
//
//  Created by Mauleen Ndlovu on 2/4/21.
//

import SwiftUI
import Combine

struct trackingPoints: View {
    
    // Private vars for tracking points
    @State private var hoursSlept = 0;
    @State private var depressedMood = ""
    @State private var elevatedMood = ""
    @State private var anxietyMood = ""
    @State private var irritabilityMood = ""

   
    // Var for "Enter" button
    @State private var enterButtonPress = false
  
    var body: some View {
        VStack {
            NavigationView {
                    Form {
                        // Hours slept last night
                        Section(header: Text("Hours Slept Last Night")) {
                        Stepper(value: $hoursSlept, in: 0...24, label: {
                            Text("Hours Slept: \(self.hoursSlept)")
                                .font(.system(size: 16.5))
                            
                        })
                        }
                        
                        // Depression 0-10
                        Section(header: Text("Depression")) {
                        TextField("Depression 0-10", text: $depressedMood)
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
                            .keyboardType(.phonePad)
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
            
                        // Enter button
                        Button("Enter") {
                            self.enterButtonPress = true
                        }
                        .alert(isPresented: $enterButtonPress) {
                            Alert(title: Text("Success!"), dismissButton: .default(Text("OK")))
                        }                       
                    } // End of Form
                
                //Title of the page
                .navigationBarTitle("Tracking Points", displayMode: .inline)
                .padding()
                .navigationBarItems(
                                        trailing:
                                            HStack {
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
                                            }
                                            )
                
            }
            // End of NavigationView
    
        } // End of Vstack
        
    } // End of View
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
                trackingPoints()
        }
    }
}
