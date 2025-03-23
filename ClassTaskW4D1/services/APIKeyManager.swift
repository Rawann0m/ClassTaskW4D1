//
//  APIKeyManager.swift
//  ClassTaskW4D1
//
//  Created by Rawan on 23/09/1446 AH.
//
import Foundation

// MARK: - API Key Manager
class APIKeyManager {
    static let shared = APIKeyManager()
    
    func getAPIKey() -> String {
        // fetching from Keychain
        if let keychainKey = SecureStorage.shared.getFromKeychain() {
            return keychainKey
        }
        
        return "No_API_Key_Found"
    }
}
