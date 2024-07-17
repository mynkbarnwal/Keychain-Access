//
//  ViewController.swift
//  Keychain Example
//
//  Created by Mayank Barnwal on 16/07/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addKeychainItem()
        
        retrieveItem()
        
        updateKeychainItem()
        
        retrieveItem()
        
        deleteKeychainItem()
        
        retrieveItem()

    }
    
    func addKeychainItem(){
        // Set username and password
        let username = "mynkbarnwal"
        let password = "1234".data(using: .utf8)!
        // Set attributes
        let attributes: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username,
            kSecValueData as String: password,
        ]
        // Add user
        if SecItemAdd(attributes as CFDictionary, nil) == noErr {
            print("User saved successfully in the keychain")
        } else {
            print("Key chain is not accessible")
        }
    }
    
    func retrieveItem(){
        // Set username of the user you want to find
        let username = "mynkbarnwal"
        // Set query
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true,
        ]
        var item: CFTypeRef?
        // Check if user exists in the keychain
        if SecItemCopyMatching(query as CFDictionary, &item) == noErr {
            // Extract result
            if let existingItem = item as? [String: Any],
               let username = existingItem[kSecAttrAccount as String] as? String,
               let passwordData = existingItem[kSecValueData as String] as? Data,
               let password = String(data: passwordData, encoding: .utf8)
            {
                print(username)
                print(password)
            }
        } else {
            print("No Data found")
        }
    }
    
    func updateKeychainItem(){
        // Set username and new password
        let username = "mynkbarnwal"
        let newPassword = "5678".data(using: .utf8)!
        // Set query
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username,
        ]
        // Set attributes for the new password
        let attributes: [String: Any] = [kSecValueData as String: newPassword]
        // Find user and update
        if SecItemUpdate(query as CFDictionary, attributes as CFDictionary) == noErr {
            print("Password has changed")
        } else {
            print("No Data found")
        }
    }
    
    func deleteKeychainItem(){
        // Set username
        let username = "mynkbarnwal"
        // Set query
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username,
        ]
        // Find user and delete
        if SecItemDelete(query as CFDictionary) == noErr {
            print("User removed successfully from the keychain")
        } else {
            print("No Data found")
        }
    }


}

