//
//  chartView.swift
//  HarmonyMood
//
//  Created by Mauleen Ndlovu on 11/18/21.
//

import SwiftUI
import SwiftUICharts

struct chartView: View {
    
    // Array of mood models
    @State var moodModels: [moodTrackingModel] = []
    
    // Check if medication is selected for edit
    @State var selectedMood: Bool = false
    
    // Id of selected mood entry to edit or delete
    @State var selectedMoodID: Int64 = 0
    
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                LineView(data: moodModels.map { Double($0.hoursSlept) }, title: "Hours Slept", legend: "Hours Slept Per Night")
                LineView(data: moodModels.map { Double($0.depression)! }, title: "Depression", legend: "Depression")
                LineView(data: moodModels.map { Double($0.elevation)! }, title: "Elevation", legend: "Elevation")
                
                    //BarChartView(data: ChartData(values: moodModels.map {($0.depression, $0.elevation, $0.anxiety, $0.irritability)}), title: "Ages", legend: "username", form: ChartForm.large)
                
                
                
                /*
                 
                 public var trackingID: Int64 = 0
                 public var hoursSlept: Int = 0
                 public var depression: String = ""
                 public var elevation: String = ""
                 public var anxiety: String = ""
                 public var irritability: String = ""
                 public var notes: String = ""
                 public var entryDate = Date()
                 */
                
                   }
                   // load data in user models array
                   .onAppear(perform: {
                       self.moodModels = DB_Manager().getMood()
                   })
                   .padding()
                   .navigationBarTitle("Chart")
               }
        }
    }


struct chartView_Previews: PreviewProvider {
    static var previews: some View {
        chartView()
    }
}


import Foundation
let mtm : [moodTrackingModel] = []
let usrs = mtm.map { ($0.depression, $0.elevation, $0.anxiety, $0.irritability) }
