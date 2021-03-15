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
        NavigationView {
            VStack {
                List(self.moodModels) { (model) in
                    VStack {
                        Text("Hours Slept: \(model.hoursSlept)")
                        Text("Depression: \(model.depression)")
                        Text("Anxiety: \(model.anxiety)")
                        Text("Elevation: \(model.elevation)")
                        Text("Irritability: \(model.irritability)")
                        Text("Notes: \(model.notes)")
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                    .background(Color (UIColor.systemGroupedBackground))
                    
                }
        }
        .onAppear(perform: {
            self.moodModels = DB_Manager().getMood()
        })
        }
        .navigationBarTitle("History", displayMode: .inline)
    }
}


struct moodHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        moodHistoryView()
    }
}
