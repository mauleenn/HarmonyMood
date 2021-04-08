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

//  medicationList.swift
//  HarmonyMood
//
//  Created by Mauleen Ndlovu on 2/4/21.
//
import SwiftUI
import Combine
import SwiftUICharts

struct medicationListView: View {
    
    // Array of medication models
    @State var medicationModels: [medicationModel] = []
    
    // Check if medication is selected for edit
    @State var selectedMed: Bool = false
    
    // Id of selected medication to edit or delete
    @State var selectedMedID: Int64 = 0
    
    @State var name: String = ""
    @State var units: String = ""
    @State var dosage: String = ""
    
    // Button to add medication
    @State private var addMedicationButton = false
    
    // To go back on the home screen when the medication is added
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    var body: some View {
        VStack {
            VStack {
                // Navigation link to go to edit medication view
                NavigationLink (destination: editMedicationView(id: self.$selectedMedID), isActive: self.$selectedMed) {
                    EmptyView()
                }
            }
            NavigationView {
                List (self.medicationModels) { (meds) in
                    HStack {
                        VStack (alignment: .leading) {
                            Text(meds.name)
                            Text("\(meds.dosage) mg").font(.subheadline).foregroundColor(.gray)
                        }
                        
                        // Button to edit medication
                        Button(action: {
                            
                            self.selectedMedID = meds.medID
                            self.selectedMed = true
                            
                        },
                        label: {
                            Image(systemName: "pencil")
                                .foregroundColor(.black)
                                .font(.system(size: 33.0))
                            
                        })
                        .buttonStyle(PlainButtonStyle())
                        
                        // Button that allows user to delete an exisiting medication
                        Button(action: {
                            
                            // Create db manager instance
                            let dbManager: DB_Manager = DB_Manager()
                            
                            // Call delete function
                            dbManager.deleteMedication(idValue: meds.medID)
                            self.medicationModels = dbManager.getMeds()
                        })
                        {
                            Text("➖")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        }
                        .buttonStyle(PlainButtonStyle())
                    } // End of HStack
                } // End of List
                .onAppear(perform: {
                    self.medicationModels = DB_Manager().getMeds()
                })
                .listStyle(InsetGroupedListStyle())
                .navigationBarTitle(Text("Medications List"))
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        HStack {
                            // Link to get to the "History" page
                            NavigationLink (destination: moodHistoryView(), label: {
                                Image(systemName: "calendar").foregroundColor(.black)
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            })
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
                        }
                    }
                }
            } // End of NavView
            .sheet(isPresented: $addMedicationButton) {
                Form {
                    
                    // Medication name
                    Section(header: Text("Information")) {
                        HStack {
                            if name.isEmpty {
                                Text("Name: ").foregroundColor(Color(UIColor.lightGray))
                                    .font(.system(size: 20))
                                    .frame(height: 64)
                            }
                            TextField("", text: $name)
                                .font(.system(size: 20))
                                .frame(height: 64)
                        }
                        }
                        
                        // Medication dosage
                        HStack {
                            if dosage.isEmpty {
                                Text("Dosage: ").foregroundColor(Color(UIColor.lightGray))
                                    .font(.system(size: 20))
                                    .frame(height: 64)
                            }
                            TextField("", text: $dosage)
                                .font(.system(size: 20))
                                .frame(height: 64)
                                .keyboardType(.numberPad)
                        }
                        }
                    }
                    // "Add" button
                    Section {
                        Button(action: {
                            
                            // Call function to add row in sqlite DB
                            DB_Manager().addMedication(nameValue: self.name, unitsValue: self.units, dosageValue: Int64(self.dosage) ?? 0)
                            
                            self.addMedicationButton.toggle()
                            
                            // Reset Values
                            self.name = ""
                            self.dosage = ""
                        }
                        , label: {
                            Text("")
                        })
                        // If any of the textfields are empty, the add button will be disabled and not work
                        .disabled(name.isEmpty || dosage.isEmpty)
                    }
                } // End of Form
                .onDisappear(perform: {
                    self.medicationModels = DB_Manager().getMeds()
                })
            } // End of .sheet
            
        } // End of VStack
        

    
    struct medicationList_Previews: PreviewProvider {
        static var previews: some View {
            medicationListView()
        }
    }

