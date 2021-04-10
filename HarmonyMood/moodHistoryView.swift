//
//  moodHistoryView.swift
//  HarmonyMood
//
//  Created by Mauleen Ndlovu on 3/12/21.
//

import SwiftUI

struct moodHistoryView: View {
    
    // Array of mood models
    @State var moodModels: [moodTrackingModel] = []
    
    // Id of selected mood entry to edit or delete
    @State var selectedMoodID: Int64 = 0
    
    // Button to delete mood Entry
    @State private var deleteMoodEntry = false
    
    var body: some View {
        NavigationView {
            List(self.moodModels) { (model) in
                HStack {
                    VStack(alignment: .leading) {
                        
                        // Date
                        Text("\(model.entryDate)")
                            .bold()
                            .foregroundColor(.pastelGreen)
                        
                        Divider()
                        
                        // Hours slept
                        Text("Hours Slept: \(model.hoursSlept)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // Depression
                        Text("Depression: \(model.depression)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // Anxiety
                        Text("Anxiety: \(model.anxiety)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // Elevation
                        Text("Elevation: \(model.elevation)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // Irritability
                        Text("Irritability: \(model.irritability)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // Notes
                        Text("Notes: \(model.notes)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                   
                    // Button that allows user to delete an exisiting mood entry
                    Button(action: {
                        
                        // Create db manager instance
                        let dbManager: DB_Manager = DB_Manager()
                        
                        // Call delete function
                        dbManager.deleteMoodEntry(idValue: model.trackingID)
                        self.moodModels = dbManager.getMood()
                    })
                    {
                        Image(systemName: "minus.circle").foregroundColor(.pastelBlue)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        
                        
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            } // End of List
            .onAppear(perform: {
                self.moodModels = DB_Manager().getMood()
            })
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(Text("Mood History"))
        } // End of Nav View
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                HStack {
                    
                    // Link to get to the "Medications List" Page
                    NavigationLink(destination: medicationListView()) {
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
                }
            }
        }
    }
}

struct moodHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        moodHistoryView()
    }
}
