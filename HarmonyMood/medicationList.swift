
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

struct Medications: Hashable {

    let name: String
    let dosage: String
    
}

struct medicationList: View {
    
    @State private var listMedications = [Medications]()
    
    @State private var medicationName: String = ""
    @State private var medicationDosage: String = ""
    @State private var medicationUnits: String = ""

    @State private var medicationStartingDate = Date()
    @State private var medicationTimeofDay: Int = 0
    @State private var mgUnit: Int = 0

    private var timeOfDayOptions = ["🌞 AM", "🌙 PM", "🌓 Both"]
    private var medicationUnit = ["mg"]
 
    @State private var addMedicationButton = false
    
    
    var body: some View {
        ZStack() {
                VStack {
                    NavigationView {
                        List {
                            ForEach(listMedications, id: \.self) { medication in
                                Section(header: Text("")) {
                                    
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(medication.name);
                                            Text(medication.dosage).font(.subheadline).foregroundColor(.gray)
                                        }
                                    }
                                }
                            }
                            .onDelete(perform: delete)
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
                                                    // Button that allows user to delete an exisiting medication
                                                    Button(action: {
                                                        EditButton()
                                                    }) {
                                                        Text("➖")
                                                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                                    }
                                                },
                                            trailing:
                                                    // Link to get to the "Welcome to HarmonyMood" Page
                                                    NavigationLink(destination: infoPage()) {
                                                        Text("ℹ️")
                                                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                                    }
                                                    
                                                )
                    }.sheet(isPresented: $addMedicationButton) {
                        Form {
                            // Medication name
                            Section(header: Text("Information")) {
                            HStack {
                                Text("Medication Name: ")
                                TextField("", text: self.$medicationName)
                                
                            }
                              
                            // Medication dosage
                            HStack {
                                Text("Dosage: ")
                                TextField("", text: self.$medicationDosage)
                                    .keyboardType(.numberPad)
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
                            // "Add" button
                            Section {
                            Button(action: {
                                self.listMedications.append(Medications(name: self.medicationName, dosage: self.medicationDosage))
                                self.addMedicationButton.toggle()
                                
                                print(self.listMedications)
                                
                                // Reset Values
                                 self.medicationName = ""
                                self.medicationDosage = ""
                            }, label: {
                                Text("Add")
                            })
                            }
                    } // End of Form
            } // End of .sheet
                    
        }
            
    }
        
}
    
    // Allows users to swipe to delete a medication
    func delete(at offsets: IndexSet) {
        listMedications.remove(atOffsets: offsets)
    }
    
struct medicationList_Previews: PreviewProvider {
    static var previews: some View {
        medicationList()
    }
}
}
