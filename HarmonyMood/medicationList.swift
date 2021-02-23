
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

//  medicationList.swift
//  HarmonyMood
//
//  Created by Mauleen Ndlovu on 2/4/21.
//
import SwiftUI
import Combine

/*
struct Medications: Hashable {

    let name: String
    let dosage: String
    
}
*/

struct medicationList: View {
    
 //   @State private var listMedications = [Medications]()
    
    // Array of medication models
    @State var medicationModels: [medicationModel] = []
    
    // check if medication is selected for edit
    @State var selectedMed: Bool = false
     
    // id of selected medication to edit or delete
    @State var selectedMedID: Int64 = 0


    @State private var medicationStartingDate = Date()
    @State private var medicationTimeofDay: Int = 0

    private var timeOfDayOptions = ["🌞 AM", "🌙 PM", "🌓 Both"]
 
    @State private var addMedicationButton = false
    
    @State var name: String = ""
    @State var units: String = ""
    @State var dosage: String = ""
     
    // to go back on the home screen when the user is added
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
     
    
    var body: some View {
        ZStack() {
                VStack {
                    VStack {
                        // navigation link to go to edit user view
                        NavigationLink (destination: editMedicationView(id: self.$selectedMedID), isActive: self.$selectedMed) {
                            EmptyView()
                        }
                    }
                    NavigationView {
                        List (self.medicationModels) { (meds) in
                            Section(header: Text("")) {
                            HStack {
                                VStack (alignment: .leading) {
                                Text(meds.name)
                                    Text("\(meds.dosage) mg").font(.subheadline).foregroundColor(.gray)
                                }
                                
                                // Button to edit medication
                                Button(action: {
                                    
                                   self.selectedMedID = meds.medID
                                    self.selectedMed = true
                                    
                                }, label: {
                                    Image(systemName: "pencil")
                                        .foregroundColor(.black)
                                        .font(.system(size: 33.0))
                                    
                                }).buttonStyle(PlainButtonStyle())
                                
                            
                                // Button that allows user to delete an exisiting medication
                                Button(action: {
                                    
                                    // create db manager instance
                                    let dbManager: DB_Manager = DB_Manager()
                                    
                                    // call delete function
                                    dbManager.deleteMedication(idValue: meds.medID)
                                    self.medicationModels = dbManager.getMeds()
                                    
                                    
                                }) {
                                    Text("➖")
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                }.buttonStyle(PlainButtonStyle())
                            }
                            }
                        }
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
                    .onAppear(perform: {
                        self.medicationModels = DB_Manager().getMeds()
                    })
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
                                   Text("Date: ")
                               }
                           }
                            // "Add" button
                            Section {
                                Button(action: {
                                
                                    // call function to add row in sqlite database
                                    DB_Manager().addMedication(nameValue: self.name, unitsValue: self.units, dosageValue: Int64(self.dosage) ?? 0)
                                     
                                   // self.listMedications.append(Medications(name: self.name, dosage: self.dosage))
                                    self.addMedicationButton.toggle()
                                    
                                 //   print(self.listMedications)
                                    
                                    // Reset Values
                                     self.name = ""
                                    self.dosage = ""
                                }, label: {
                                    Text("Add")
                                })
                            }
                            .onAppear(perform: {
                                self.medicationModels = DB_Manager().getMeds()
                            })
                    } // End of Form
            } // End of .sheet
                    
        }
            
    }
        
}
    
struct medicationList_Previews: PreviewProvider {
    static var previews: some View {
        medicationList()
    }
}
}
