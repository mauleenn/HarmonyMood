//
//  TextFieldManager.swift
//  HarmonyMood
//
//  Created by Mauleen Ndlovu on 4/2/21.
//

import SwiftUI

class TextFieldManager: ObservableObject {
    
    let passcodeCharacterLimit = 4
    
    @Published var passcode = "" {
        didSet {
            if passcode.count > passcodeCharacterLimit {
                passcode = String(passcode.prefix(passcodeCharacterLimit))
            }
        }
    }
}
