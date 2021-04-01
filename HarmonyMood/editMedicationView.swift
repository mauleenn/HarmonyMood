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

//  editMedicationView.swift
//  HarmonyMood
//
//  Created by Mauleen Ndlovu on 2/23/21.
//

import SwiftUI

struct editMedicationView: View {
    
   // id receiving of user from previous view
   @Binding var id: Int64
    
   // variables to store value from input fields
   @State var name: String = ""
   @State var dosage: String = ""

   // to go back to previous view
   @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
   var body: some View {
    
    NavigationView {
       VStack {
        
        Text("Edit Medication")
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .padding()
            .padding()
        
           // Create medication name field
           TextField("Medication Name:", text: $name)
               .padding(10)
               .background(Color(.systemGray6))
               .cornerRadius(5)
               .disableAutocorrection(true)
            
          
           // Create dosage field, numberpad
           TextField("Dosage:", text: $dosage)
               .padding(10)
               .background(Color(.systemGray6))
               .cornerRadius(5)
               .keyboardType(.numberPad)
               .disableAutocorrection(true)
            
           // Button to update medication
           Button(action: {
               // Call function to update row in sqlite DB
               DB_Manager().updateMedication(idValue: self.id, nameValue: self.name, dosageValue: Int64(self.dosage) ?? 0)

               // go back to home page
               self.mode.wrappedValue.dismiss()
           }, label: {
               Text("Save")
           })
           .foregroundColor(.green)
               .padding(.top, 10)
               .padding(.bottom, 10)
           
           // If any of the textfields are empty, the add button will be disabled and not work
           .disabled(name.isEmpty || dosage.isEmpty)
       } // End of VStack
       // Populate medications's data in fields when view loaded
       .onAppear(perform: {
           // Get data from DB
           let medicationModels: medicationModel = DB_Manager().getMedication(idValue: self.id)
            
           // Populate in text fields
           self.name = medicationModels.name
           self.dosage = String(medicationModels.dosage)
       })
    } .navigationBarTitle("Edit Medication", displayMode: .inline) // End of NavigationView
   } // End of View
}

struct editMedicationView_Previews: PreviewProvider {
    
   // When using @Binding, do this in preview provider
   @State static var medID: Int64 = 0
    
   static var previews: some View {
    editMedicationView(id: $medID)
   }
}
