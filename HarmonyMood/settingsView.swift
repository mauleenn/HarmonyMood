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

// Additional colors
extension Color {
    static let pastelPink = Color("pastelPink")
    static let pastelBlue = Color("pastelBlue")
    static let pastelPurple = Color("pastelPurple")
    static let bgGrey = Color("bgGrey")
    static let teal = Color("teal")
}

struct settingsView: View {
    
    @State private var name: String = ""
    @State private var passcode = ""
    
    @AppStorage("notificationsEnabled") var notificationsEnabled: Bool = false
    @AppStorage("passcodeEnabled") var passcodeEnabled: Bool = false
    @State private var showAlert = false
    
    // ObservedObj for TextFieldManager() Class which
    // only allows for a four digit passcode
    @ObservedObject var textFieldManager = TextFieldManager()
    
    // Navigation bar title color is "teal"
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(named: "teal") ?? .black]
    }
    
    var body: some View {
        
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    ZStack(alignment: .leading) {
                        
                        if name.isEmpty {
                            Text("What is your name?").foregroundColor(Color(UIColor.lightGray))
                                .font(.system(size: 20))
                                .frame(height: 64)
                        }
                        TextField("", text: $name)
                            .font(.system(size: 20))
                            .frame(height: 64)
                    }
                }
                
                // Four digit passcode
                Section(header: Text("Passcode")) {
                    Toggle(isOn: $passcodeEnabled) {
                        Text("Enable Passcode?").foregroundColor(Color(UIColor.lightGray))
                            .font(.system(size: 20))
                            .frame(height: 64)
                    }
                    
                    ZStack(alignment: .leading) {
                        
                        if textFieldManager.passcode.isEmpty {
                            Text("Passcode:").foregroundColor(Color(UIColor.lightGray))
                                .font(.system(size: 20))
                                .frame(height: 64)
                        }
                        SecureField("", text: $textFieldManager.passcode)
                            .keyboardType(.numberPad)
                            .font(.system(size: 20))
                            .frame(height: 64)
                    }
                }
                
                Section(header: Text("Notifications")) {
                    Toggle(isOn: $notificationsEnabled) {
                        Text("Enable Notifications?").foregroundColor(Color(UIColor.lightGray))
                            .font(.system(size: 20))
                            .frame(height: 64)
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
                            ZStack {
                                Text("Save")
                                    .foregroundColor(.pastelPink)
                                    .font(.system(size: 20))
                                    .fontWeight(.semibold)
                            }
                            .frame(width: 330.0, height: 45.0)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            //.padding(.vertical)
                        }
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Successfully saved!"))
                    }
                }
            } 
            .font(Font.system(size: 15, weight: .medium, design: .serif))
            .navigationBarTitle("Settings")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    HStack {
                        // Link to get to the "History" page
                        NavigationLink (destination: moodHistoryView(), label: {
                            Image(systemName: "calendar").foregroundColor(.black)
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        })
                        Divider()
                        
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
                    }
                }
            }
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
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    
    struct settingsView_Previews: PreviewProvider {
        static var previews: some View {
            
            settingsView()
        }
    }
}
