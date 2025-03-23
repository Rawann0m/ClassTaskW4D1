//
//  ClassTaskW4D1App.swift
//  ClassTaskW4D1
//
//  Created by Rawan on 23/09/1446 AH.
//

import SwiftUI

@main
struct ClassTaskW4D1App: App {
    init() {
        // Call saveAPIKey during app initialization
        saveAPIKey()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    //function ti save the api key
    func saveAPIKey() {
           let apiKey = "fe24dbf8ea434d89a5c230b1e88c8c89" 
           SecureStorage.shared.saveToKeychain(apiKey: apiKey)
       }
}
