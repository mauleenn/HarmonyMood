//
//  DB_Manager.swift
//  HarmonyMood
//  SQLite_Database
//
//  Created by Mauleen Ndlovu on 2/22/21.
//

import Foundation
import SQLite

class DB_Manager {
    
//SQLite instance
private var db: Connection!

// Table instance
private var meds: Table!


// Columns instances of table
private var medID: Expression<Int64>!
private var name: Expression<String>!
private var dosage: Expression<Int64>!

    
    
init () {
    do {
        // path of document directory
        let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
        
        // Creating DB connection
        db = try Connection("/Users/mauleenndlovu/Desktop/HarmonyMood/medsList.sqlite3")
        
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
        // set the value to true, so it will not attempt to create the table again
        UserDefaults.standard.set(true, forKey: "is_db_created")
    }
     
}

catch {
    // show error message if any
    print(error.localizedDescription)
}
 
} // end of init
    
public func addMedication(nameValue: String, unitsValue: String, dosageValue: Int64) {
    do {
        try db.run(meds.insert(name <- nameValue, dosage <- dosageValue))
        
    }
    catch {
            print(error.localizedDescription)
        }
    }
    
    
    // return array of user models
public func getMeds() -> [medicationModel] {
         
        // create empty array
    var medicationsModel: [medicationModel] = []
     
        // get all users in descending order
        meds = meds.order(medID.desc)
     
        // exception handling
        do {
     
            // loop through all users
            for meds in try db.prepare(meds) {
     
                // create new model in each loop iteration
                let medicationModels: medicationModel = medicationModel()
     
                // set values in model from database
                medicationModels.medID = meds[medID]
                medicationModels.name = meds[name]
                medicationModels.dosage = meds[dosage]
     
                // append in new array
                medicationsModel.append(medicationModels)
            }
        } catch {
            print(error.localizedDescription)
        }
     
        // return array
        return medicationsModel
    }
    
    // get single user data
    public func getMedication(idValue: Int64) -> medicationModel {
     
        // create an empty object
        let medicationModels: medicationModel = medicationModel()
         
        // exception handling
        do {
     
            // get user using ID
            let med: AnySequence<Row> = try db.prepare(meds.filter(medID == idValue))
     
            // get row
            try med.forEach({ (rowValue) in
     
                // set values in model
                medicationModels.medID = try rowValue.get(medID)
                medicationModels.name = try rowValue.get(name)
                medicationModels.dosage = try rowValue.get(dosage)
            })
        } catch {
            print(error.localizedDescription)
        }
     
        // return model
        return medicationModels
    }

    // function to update medication
    public func updateMedication(idValue: Int64, nameValue: String, dosageValue: Int64) {
        do {
            // get user using ID
            let med: Table = meds.filter(medID == idValue)
             
            // run the update query
            try db.run(med.update(name <- nameValue, dosage <- dosageValue))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // function to delete user
    public func deleteMedication(idValue: Int64) {
        do {
            // get user using ID
            let med: Table = meds.filter(medID == idValue)
             
            // run the delete query
            try db.run(med.delete())
        } catch {
            print(error.localizedDescription)
        }
    }

    
    
}
