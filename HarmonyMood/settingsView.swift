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

//  settingsView.swift
//  HarmonyMood
//
//  Created by Mauleen Ndlovu on 3/22/21.
//

import SwiftUI
import Combine
import UserNotifications

extension Color {
    static let pastelPink = Color("pastelPink")
    static let pastelBlue = Color("pastelBlue")
    static let pastelPurple = Color("pastelPurple")
    static let bgGrey = Color("bgGrey")
}

struct settingsView: View {
    
    @State private var name: String = ""
    @State private var passcode = ""
    
    @AppStorage("notificationsEnabled") var notificationsEnabled: Bool = false
    @AppStorage("passcodeEnabled") var passcodeEnabled: Bool = false
    @State private var showAlert = false
    
    @State var userModels: [userModel] = []
    
    var body: some View {
        
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    HStack{
                        
                        Image(systemName: "person.fill").foregroundColor(.pastelPurple)
                        TextField("What is your name?", text: $name)
                            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                            .background(Color(UIColor.secondarySystemFill))
                            .cornerRadius(4)
                    }
                }
                
                // Four digit passcode
                Section(header: Text("Passcode")) {
                    Toggle("Enable Passcode", isOn: $passcodeEnabled)
                    
                    HStack {
                        TextField("****", text: $passcode)
                            .keyboardType(.numberPad)
                            .onReceive(Just(passcode)) {
                                guard let value = Int($0), 0...10000 ~= value
                                else {
                                    self.passcode = ""
                                    return
                                }
                                self.passcode = String(value)
                            }
                        
                    }
                    
                }
                
                
                Section(header: Text("Notifications")) {
                    Toggle(isOn: $notificationsEnabled) {
                        Text("Enabled")
                    }
                    .onChange(of: notificationsEnabled) {
                        self.scheduleNotifications(state: $0)
                    }
                }
                
                Section {
                    VStack {
                        Button(action: {
                            
                            showAlert = true
                            DB_Manager().addSettings(nameValue: self.name, passcodeValue: Int64(self.passcode) ?? 0, notificationsValue: self.notificationsEnabled)
                        })
                        {
                            Text("Save")
                                .foregroundColor(.pastelPurple)
                        }
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Successfully saved!"))
                    }
                }
               
            } 
            .font(Font.system(size: 15, weight: .medium, design: .serif))
            .navigationBarTitle("Settings")
        }
    }
    
    func scheduleNotifications(state: Bool) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if (success) {
                print("Success")
            }
            else if let error = error {
                print(error.localizedDescription)
            }
        }
        
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        let content = UNMutableNotificationContent()
        content.title = "Hey! It's time to log your mood :)"
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 07
        dateComponents.minute = 20
        
        // Testing/demo for Cycle 8
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}

struct settingsView_Previews: PreviewProvider {
    static var previews: some View {
        
        settingsView()
    }
}
