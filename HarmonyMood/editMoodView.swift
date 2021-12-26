//
//  editMoodView.swift
//  HarmonyMood
//
//  Created by Mauleen Ndlovu on 11/18/21.
//

import SwiftUI
import Combine

struct editMoodView: View {
    
    // id receiving of med from previous view
    @Binding var id: Int64
    
    // variables to store value from input fields
    @State var hoursSlept: String = ""
    @State var depression: String = ""
    @State var elevation: String = ""
    @State var anxiety: String = ""
    @State var irritability: String = ""
    @State var notes: String = ""
    @State var entryDate: String = ""
    
    
    // to go back to previous view
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    
    var body: some View {
        
        VStack {
            
            Text("Edit Medication")
                .font(.system(size: 40, weight: .semibold))
                .foregroundColor(.teal)
                .padding()
                .padding()
            
            // Hours slept last night
            TextField("Hours Slept:", text: $hoursSlept)
                .font(.system(size: 20, weight: .semibold))
                .frame(height: 64)
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .disableAutocorrection(true)
                .foregroundColor(.black)
                .keyboardType(.numberPad)
                .onReceive(Just(hoursSlept)) {
                    guard let value = Int($0), 0...24 ~= value
                    else {
                        self.hoursSlept = ""
                        return
                    }
                    self.hoursSlept = String(value)
                }
            
                // Depression 0-10
                TextField("Depression 0-10", text: $depression)
                    .font(.system(size: 20, weight: .semibold))
                    .frame(height: 64)
                    .background(Color(.systemGray6))
                    .cornerRadius(5)
                    .disableAutocorrection(true)
                    .foregroundColor(.black)
                    .keyboardType(.numberPad)
                    .onReceive(Just(depression)) {
                        guard let value = Int($0), 0...10 ~= value
                        else {
                            self.depression = ""
                            return
                        }
                        self.depression = String(value)
                    }
            
                // Elevation 0-10
                TextField("Elevation 0-10", text: $elevation)
                    .font(.system(size: 20, weight: .semibold))
                    .frame(height: 64)
                    .background(Color(.systemGray6))
                    .cornerRadius(5)
                    .disableAutocorrection(true)
                    .foregroundColor(.black)
                    .keyboardType(.numberPad)
                    .onReceive(Just(elevation)) {
                        guard let value = Int($0), 0...10 ~= value
                        else {
                            self.elevation = ""
                            return
                        }
                        self.elevation = String(value)
                    }
            
                // Anxiety 0-10
                TextField("Anxiety 0-10", text: $anxiety)
                    .font(.system(size: 20, weight: .semibold))
                    .frame(height: 64)
                    .background(Color(.systemGray6))
                    .cornerRadius(5)
                    .disableAutocorrection(true)
                    .foregroundColor(.black)
                .keyboardType(.numberPad)
                    .onReceive(Just(anxiety)) {
                        guard let value = Int($0), 0...10 ~= value
                        else {
                            self.anxiety = ""
                            return
                        }
                        self.anxiety = String(value)
                    }
            
            // Irritability 0-10
                TextField("Irritability 0-10", text: $irritability)
                    .font(.system(size: 20, weight: .semibold))
                    .frame(height: 64)
                    .background(Color(.systemGray6))
                    .cornerRadius(5)
                    .disableAutocorrection(true)
                    .foregroundColor(.black)
                    .keyboardType(.numberPad)
                    .onReceive(Just(irritability)) {
                        guard let value = Int($0), 0...10 ~= value
                        else {
                            self.irritability = ""
                            return
                        }
                        self.irritability = String(value)
                    }
            
            
            // Create notes field
            Section(header: Text("Today's Notes")) {
                TextEditor(text: $notes)
                    .font(.system(size: 20, weight: .semibold))
                    .background(Color(.systemGray6))
                    .cornerRadius(5)
                    .disableAutocorrection(true)
                    .foregroundColor(.black)
                    .accessibility(identifier: "notes")
                    .multilineTextAlignment(.leading)
                    .frame(height: 100)
            }
            .foregroundColor(.black)
            .font(.system(size: 20))
            
            // Button to update medication
            Button(action: {
                // Call function to update row in sqlite DB
                DB_Manager().updateMoodEntry(idValue: self.id, hoursSleptValue: Int(Int64(self.hoursSlept) ?? 0), depressionValue: self.depression, anxietyValue: self.anxiety, elevationValue: self.elevation, irritabilityValue: self.irritability, notesValue: self.notes)
                // go back to home page
                self.mode.wrappedValue.dismiss()
            }, label: {
                Text("Save")
                    .foregroundColor(.pastelPink)
                    .font(.system(size: 25))
                    .fontWeight(.semibold)
            })
            .foregroundColor(.green)
            .padding(.top, 10)
            .padding(.bottom, 10)
            
            
        } // End of VStack
        .onAppear(perform: {
            // Get data from DB
            let moodModels: moodTrackingModel = DB_Manager().getSingleMood(idValue: self.id)
            
            // Populate in text fields
            self.depression = moodModels.depression
            self.elevation = moodModels.elevation
            self.anxiety = moodModels.anxiety
            self.irritability = moodModels.irritability
            self.depression = moodModels.depression
        })
    } // End of VStack
    // Populate medications's data in fields when view loaded
} // End of View

struct editMoodView_Previews: PreviewProvider {
    
    // When using @Binding, do this in preview provider
    @State static var trackingID: Int64 = 0
    
    static var previews: some View {
        editMoodView(id: $trackingID)
    }
}
