//
//  editMedicationView.swift
//  HarmonyMood
//  SQLite_Database
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
        
           // create name field
           TextField("Medication Name: ", text: $name)
               .padding(10)
               .background(Color(.systemGray6))
               .cornerRadius(5)
               .disableAutocorrection(true)
            
          
           // create age field, number pad
           TextField("Dosage: ", text: $dosage)
               .padding(10)
               .background(Color(.systemGray6))
               .cornerRadius(5)
               .keyboardType(.numberPad)
               .disableAutocorrection(true)
            
           // button to update user
           Button(action: {
               // call function to update row in sqlite database
               DB_Manager().updateMedication(idValue: self.id, nameValue: self.name, dosageValue: Int64(self.dosage) ?? 0)

               // go back to home page
               self.mode.wrappedValue.dismiss()
           }, label: {
               Text("Save")
           })
           .foregroundColor(.green)
               .padding(.top, 10)
               .padding(.bottom, 10)
       } // End of VStack
       // populate user's data in fields when view loaded
       .onAppear(perform: {
        
           // get data from database
           let medicationModels: medicationModel = DB_Manager().getMedication(idValue: self.id)
            
           // populate in text fields
           self.name = medicationModels.name
           self.dosage = String(medicationModels.dosage)
       })
    } // End of NavigationView
   } // End of View
}

struct editMedicationView_Previews: PreviewProvider {
    
   // when using @Binding, do this in preview provider
   @State static var medID: Int64 = 0
    
   static var previews: some View {
    editMedicationView(id: $medID)
   }
}
