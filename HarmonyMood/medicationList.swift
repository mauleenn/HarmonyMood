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

struct medicationList: View {
    
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
                        // Navigation link to go to edit user view
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
                        .navigationBarItems(leading:
                                                HStack {
                                                    Button(action: {
                                                    self.addMedicationButton.toggle()
                                                }, label: {
                                                    Text("➕")
                                                        .font(.title)
                                                })
                                                },
                                            trailing:
                                                    // Link to get to the "Welcome to HarmonyMood" Page
                                                    NavigationLink(destination: infoPage()) {
                                                        Text("ℹ️")
                                                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                                    })
                    }
                    .sheet(isPresented: $addMedicationButton) {
                        Form {
                            
                            // Medication name
                            Section(header: Text("Information")) {
                            HStack {
                                Text("Medication Name: ")
                                TextField("", text: self.$name)
                            }
                              
                            // Medication dosage
                            HStack {
                                Text("Dosage: ")
                                TextField("", text: self.$dosage)
                                    .keyboardType(.numberPad)
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
                                    Text("Add")
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

    }
    
struct medicationList_Previews: PreviewProvider {
    static var previews: some View {
        medicationList()
    }
}
}
