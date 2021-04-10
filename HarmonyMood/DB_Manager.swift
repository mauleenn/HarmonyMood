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

//  DB_Manager.swift
//  HarmonyMood
//  SQLite_Database
//
//  Created by Mauleen Ndlovu on 2/22/21.
//

import Foundation
import SQLite

class DB_Manager {
    
    // SQLite instance
    private var db: Connection!
    
    // Table instances
    private var meds: Table!
    private var users: Table!
    private var trackingPoints: Table!
    
    // Columns instances of medications table
    private var medID: Expression<Int64>!
    private var name: Expression<String>!
    private var dosage: Expression<Int64>!
    
    // Columns instances of users table
    private var userID: Expression<Int64>!
    private var userName: Expression<String>!
    public var passcode: Expression<Int64>!
    public var enableNotifications: Expression<Bool>!
    
    // Columns instances of tracking points table
    private var trackingID: Expression<Int64>!
    private var hoursSlept: Expression<Int>!
    private var depression: Expression<String>!
    private var elevation: Expression<String>!
    private var anxiety: Expression<String>!
    private var irritability: Expression<String>!
    private var notes: Expression<String>!
    private var entryDate: Expression<Date>!
    
    init () {
        do {
            // Path of document directory
            let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
             
             // creating database connection
             db = try Connection("\(path)/harmonyMoodDB.sqlite3")
            
            
            // Creating table objects
            meds = Table("medications")
            trackingPoints = Table("moods")
            users = Table("users")
            
            // Instances for medications table
            medID = Expression<Int64>("id")
            name = Expression<String>("name")
            dosage = Expression<Int64>("dosage")
            
            // Instances for moods table
            trackingID = Expression<Int64>("trackingID")
            hoursSlept = Expression<Int>("hoursSlept")
            depression = Expression<String>("depression")
            elevation = Expression<String>("dosage")
            anxiety = Expression<String>("anxiety")
            irritability = Expression<String>("irritability")
            notes = Expression<String>("notes")
            entryDate = Expression<Date>("entryDate")
            
            userID = Expression<Int64>("userID")
            userName = Expression<String>("userName")
            passcode = Expression<Int64>("passcode")
            enableNotifications = Expression<Bool>("enableNotifications")
            
            
            // Creating the meds table (if it doesn't already exist)
            try db.run(meds.create(ifNotExists: true) { (t) in
                t.column(medID, primaryKey: true)
                t.column(name)
                t.column(dosage)
                
            })
            
            // Creating the moods table (if it doesn't already exist)
            try db.run(trackingPoints.create(ifNotExists: true) { (t) in
                t.column(trackingID, primaryKey: true)
                t.column(hoursSlept)
                t.column(depression)
                t.column(elevation)
                t.column(anxiety)
                t.column(irritability)
                t.column(notes)
                t.column(entryDate)
            })
            
            // Creating the users table (if it doesn't already exist)
            try db.run(users.create(ifNotExists: true) { (t) in
                t.column(userID, primaryKey: true)
                t.column(userName)
                t.column(passcode)
                t.column(enableNotifications)
            })
            
        }
        catch {
            // Show error message (if any)
            print(error.localizedDescription)
        }
        
    } // End of init
    
    
    // Function to add medication
    public func addMedication(nameValue: String, unitsValue: String, dosageValue: Int64) {
        do {
            try db.run(meds.insert(name <- nameValue, dosage <- dosageValue))
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    
    // Function to return array of medication models
    public func getMeds() -> [medicationModel] {
        
        // Create empty array
        var medicationsModel: [medicationModel] = []
        
        // Get all meds in ascending order
        meds = meds.order(medID.asc)
        
        // Exception handling
        do {
            // Loop through all medications
            for meds in try db.prepare(meds) {
                // Create new model in each loop iteration
                let medicationModels: medicationModel = medicationModel()
                
                // Set values in model from DB
                medicationModels.medID = meds[medID]
                medicationModels.name = meds[name]
                medicationModels.dosage = meds[dosage]
                
                // Append in new array
                medicationsModel.append(medicationModels)
            }
        }
        catch {
            print(error.localizedDescription)
        }
        
        // Return array
        return medicationsModel
    }
    
    
    // Get single medication data
    public func getMedication(idValue: Int64) -> medicationModel {
        
        // Create an empty object
        let medicationModels: medicationModel = medicationModel()
        
        // Exception handling
        do {
            // Get med using ID
            let med: AnySequence<Row> = try db.prepare(meds.filter(medID == idValue))
            
            // Get row
            try med.forEach({ (rowValue) in
                
                // Set values in model
                medicationModels.medID = try rowValue.get(medID)
                medicationModels.name = try rowValue.get(name)
                medicationModels.dosage = try rowValue.get(dosage)
            })
        }
        catch {
            print(error.localizedDescription)
        }
        
        // Return model
        return medicationModels
    }
    
    
    // Function to update medication
    public func updateMedication(idValue: Int64, nameValue: String, dosageValue: Int64) {
        do {
            // Get medication using ID
            let med: Table = meds.filter(medID == idValue)
            
            // Run the update query
            try db.run(med.update(name <- nameValue, dosage <- dosageValue))
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    
    // Function to delete medication
    public func deleteMedication(idValue: Int64) {
        do {
            // Get medication using ID
            let med: Table = meds.filter(medID == idValue)
            
            // Run the delete query
            try db.run(med.delete())
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    
    // Function to add moods
    public func addMood(hoursSleptValue: Int, depressionValue: String, anxietyValue: String, elevationValue: String, irritabilityValue: String, notesValue: String, dateValue: Date) {
        
        do {
            try db.run(trackingPoints.insert(hoursSlept <- hoursSleptValue, depression <- depressionValue, elevation <- elevationValue, anxiety <- anxietyValue, irritability <- irritabilityValue, notes <- notesValue, entryDate <- dateValue))
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    
    // Function to delete mood entry
    public func deleteMoodEntry(idValue: Int64) {
        do {
            // Get medication using ID
            let moods: Table = trackingPoints.filter(trackingID == idValue)
            
            // Run the delete query
            try db.run(moods.delete())
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    // Function to update mood entry
    public func updateMoodEntry(idValue: Int64, hoursSleptValue: Int, depressionValue: String, anxietyValue: String, elevationValue: String, irritabilityValue: String, notesValue: String) {
        do {
            // Get mood entry using ID
            let moods: Table = trackingPoints.filter(trackingID == idValue)
            
            // Run the update query
            try db.run(moods.update(hoursSlept <- hoursSleptValue, depression <- depressionValue, elevation <- elevationValue, anxiety <- anxietyValue, irritability <- irritabilityValue, notes <- notesValue))
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    
    // Function to get mood
    public func getMood() -> [moodTrackingModel] {
        
        var moodModels: [moodTrackingModel] = []
        
        // List the most recent history first
        trackingPoints = trackingPoints.order(trackingID.desc)
        
        do {
            // Loop through all moods
            for mood in try db.prepare(trackingPoints) {
                
                // create new model in each loop iteration
                let moodModel: moodTrackingModel = moodTrackingModel()
                
                // set values in model from DB
                moodModel.trackingID = mood[trackingID]
                moodModel.hoursSlept = mood[hoursSlept]
                moodModel.depression = mood[depression]
                moodModel.anxiety = mood[anxiety]
                moodModel.elevation = mood[elevation]
                moodModel.irritability = mood[irritability]
                moodModel.notes = mood[notes]
                moodModel.entryDate = mood[entryDate]
                
                // Append in new array
                moodModels.append(moodModel)
            }
        }
        catch {
            print(error.localizedDescription)
        }
        
        // Return array
        return moodModels
    }
    
    
    // Function to get settings
    public func getSettings() -> [userModel] {
        
        var userModels: [userModel] = []
        
        // List the most recent history first
        users = users.order(userID.desc)
        
        do {
            // Loop through all moods
            for users in try db.prepare(users) {
                
                // create new model in each loop iteration
                let user_Model: userModel = userModel()
                
                // set values in model from DB
                user_Model.userID = users[userID]
                user_Model.userName = users[userName]
                user_Model.enableNotifications = users[enableNotifications]
                
                // Append in new array
                userModels.append(user_Model)
            }
        }
        catch {
            print(error.localizedDescription)
        }
        
        // Return array
        return userModels
    }
    
    
    // Function to add name, passcode, and notifications to settings
    public func addSettings(nameValue: String, passcodeValue: Int64, notificationsValue: Bool) {
        do {
            try db.run(users.insert(userName <- nameValue, passcode <- passcodeValue, enableNotifications <- notificationsValue))
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
