//
//  Untitled.swift
//  ClassTaskW4D1
//
//  Created by Rawan on 23/09/1446 AH.
//
import Foundation

// MARK: - Secure Storage Manager
/// This class securely stores and retrieves API keys using Apple's Keychain Services API.
class SecureStorage {
    
    /// Singleton instance to ensure a single access point for Keychain operations.
    static let shared = SecureStorage()
    
    // MARK: - Save API Key to Keychain
    func saveToKeychain(apiKey: String, service: String = "NewsAPIKey") {
        let data = apiKey.data(using: .utf8) // Convert API key to Data
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword, // 🔹 Keychain Item Type (Generic Password)
            kSecAttrService as String: service, // 🔹 Unique Service Identifier
            kSecValueData as String: data! // 🔹 Store API Key as Data
        ]
        
        SecItemDelete(query as CFDictionary) // ✅ Delete existing entry (if exists)
        SecItemAdd(query as CFDictionary, nil) // ✅ Add new entry to Keychain
    }
    
    // MARK: - Retrieve API Key from Keychain

    func getFromKeychain(service: String = "NewsAPIKey") -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword, // 🔹 Search for Generic Password Type
            kSecAttrService as String: service, // 🔹 Identify stored API key
            kSecReturnData as String: kCFBooleanTrue!, // 🔹 Request the stored data
            kSecMatchLimit as String: kSecMatchLimitOne // 🔹 Fetch only one matching result
        ]
        
        var dataTypeRef: AnyObject?
        
        // ✅ Try fetching the API key from Keychain
        if SecItemCopyMatching(query as CFDictionary, &dataTypeRef) == noErr,
           let data = dataTypeRef as? Data {
            return String(data: data, encoding: .utf8) // Convert Data to String
        }
        
        return nil // ❌ Return nil if key is not found
    }
}

