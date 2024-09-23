//
//  UserDefaultsManager.swift
//  Givy
//
//  Created by Max on 12.08.2024.
//


import Foundation
import UIKit

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    private init() {}
    
    // MARK: - Keys
    private let userInputKey = "userInput"
    private let lastScreenKey = "lastScreen"
    private let emailKey = "email"
    private let passwordKey = "password"
    private let imageKey = "savedImage"
    
    private let textPen = "savedTextPen"
    
    // MARK: - User Input
    func saveUserInput(_ input: String) {
        UserDefaults.standard.set(input, forKey: userInputKey)
    }
    
    func getUserInput() -> String? {
        return UserDefaults.standard.string(forKey: userInputKey)
    }
    
    // MARK: - Last Screen
    func saveLastScreen(_ screenName: String) {
        UserDefaults.standard.set(screenName, forKey: lastScreenKey)
    }
    
    func getLastScreen() -> String? {
        return UserDefaults.standard.string(forKey: lastScreenKey)
    }
    
    
    // MARK: - Email and Password
    func saveEmail(_ email: String) {
        UserDefaults.standard.set(email, forKey: emailKey)
    }
    
    func getEmail() -> String? {
        return UserDefaults.standard.string(forKey: emailKey)
    }
    
    func savePassword(_ password: String) {
        UserDefaults.standard.set(password, forKey: passwordKey)
    }
    
    func getPassword() -> String? {
        return UserDefaults.standard.string(forKey: passwordKey)
    }
    
    // MARK: - Clear Data
    func clearUserInput() {
        UserDefaults.standard.removeObject(forKey: userInputKey)
    }
    
    func clearLastScreen() {
        UserDefaults.standard.removeObject(forKey: lastScreenKey)
    }
    
    func clearEmail() {
        UserDefaults.standard.removeObject(forKey: emailKey)
    }
    
    func clearPassword() {
        UserDefaults.standard.removeObject(forKey: passwordKey)
    }
    
    // MARK: - Image
    func saveImage(_ image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            UserDefaults.standard.set(imageData, forKey: imageKey)
        }
    }
    
    func getImage() -> UIImage? {
        if let imageData = UserDefaults.standard.data(forKey: imageKey) {
            return UIImage(data: imageData)
        }
        return nil
    }
    
    func saveTextPen(_ text: String) {
        UserDefaults.standard.set(text, forKey: textPen)
    }
}
