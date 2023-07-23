//
//  UserData.swift
//  Ern3st
//
//  Created by Muhammad Ali on 16/12/2022.
//

import Foundation
class UserData: Codable{
    var username: String
    var userEmail: String
    var userPassword:String
    var userId:String
    var userHeight: Int
    init(username: String, userEmail: String, userPassword: String, userId: String, userHeight: Int) {
        self.username = username
        self.userEmail = userEmail
        self.userPassword = userPassword
        self.userId = userId
        self.userHeight = userHeight
    }
    
    func saveUserDataToDefaults(){
        let user = UserData(username: username, userEmail: userEmail, userPassword: userPassword, userId: userId, userHeight: userHeight)
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Note
            let data = try encoder.encode(user)

            // Write/Set Data
            UserDefaults.standard.set(data, forKey: "userdata")

        } catch {
            print("Unable to Encode Note (\(error))")
        }
        
    }
    
}
