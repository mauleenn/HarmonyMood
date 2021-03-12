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
    
// Columns instances of tracking points table
private var trackingID: Expression<Int64>!
private var depression: Expression<String>!
private var elevation: Expression<String>!
private var anxiety: Expression<String>!
private var irritability: Expression<String>!
private var notes: Expression<String>!

    init () {
        do {
            // Path of document directory
            let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            
            // Creating DB connection
            db = try Connection("/Users/mauleenndlovu/Desktop/HarmonyMood/harmonyMoodDB.sqlite3")
            
            // Creating table object
            meds = Table("medications")
            
            // Create instances of each column
            medID = Expression<Int64>("id")
            name = Expression<String>("name")
            dosage = Expression<Int64>("dosage")

            
            if (!UserDefaults.standard.bool(forKey: "is_db_created")) {
                
                // If not, then create the table
                try db.run(meds.create { (t) in
                    t.column(medID, primaryKey: true)
                    t.column(name)
                    t.column(dosage)

            })
            // Set the value to true, so it will not attempt to create the table again
            UserDefaults.standard.set(true, forKey: "is_db_created")
        }
         
    }

    catch {
        // Show error message (if any)
        print(error.localizedDescription)
    }
     
    } // End of init
    
        
    public func addMedication(nameValue: String, unitsValue: String, dosageValue: Int64) {
        do {
            try db.run(meds.insert(name <- nameValue, dosage <- dosageValue))
            
        }
            catch {
                print(error.localizedDescription)
            }
        }

        // Return array of medication models
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
            } catch {
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
            } catch {
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
            } catch {
                print(error.localizedDescription)
            }
        }

        
        
    }
