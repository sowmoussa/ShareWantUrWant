//
//  DatabaseManager.swift
//  ShareWhatUWhant
//
//  Created by Moussa SOW on 23/04/2021.
//

import FirebaseDatabase

public class DatabaseManager {
    static let shared = DatabaseManager()
    private let databse = Database.database().reference()
    // MARK: - Public
    
    /// Check if username and email is available
    /// - Parameters
    ///   - email: String representing email
    ///   - username: String representing username
    public func cancreateNewUser(with email: String, username: String, completion: (Bool) -> Void) {
        completion(true)
    }
    
    /// Put user in bdd
    /// - Parameters
    ///   - email: String representing email
    ///   - username: String representing username
    public func insertNewUser(with email:String, username:String, completion: @escaping (Bool)->Void) {
        databse.child(email.safeDatabaseKey()).setValue(["username":username]) { (error, _) in
            if error == nil {
                completion(true)
                return
            }else{
                completion(false)
                return
            }
        }
    }
    
    private func saveKey() {
        
    }
}
