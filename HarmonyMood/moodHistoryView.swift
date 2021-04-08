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
    
    var body: some View {
        
        VStack {
            List(self.moodModels) { (model) in
                VStack {
                    
                    // Date
                    Text("\(model.entryDate)")
                        .bold()
                        .foregroundColor(.teal)
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
                .background(Color (UIColor.systemGroupedBackground))
            }
        }
        .onAppear(perform: {
            self.moodModels = DB_Manager().getMood()
        })
        
        .navigationBarTitle("Mood History", displayMode: .inline)
    }
}


struct moodHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        moodHistoryView()
    }
}
