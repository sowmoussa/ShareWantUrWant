//
//  AuthManager.swift
//  ShareWhatUWhant
//
//  Created by Moussa SOW on 23/04/2021.
//

import FirebaseAuth

public class AuthManager {
    static let shared = AuthManager()
    
    // MARK: - Public
    
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        /*
         * Check if username is avalaible
         * email is available
         */
        DatabaseManager.shared.cancreateNewUser(with: email, username: username) {
            canCreate in
            if canCreate {
                Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                    guard error == nil, authResult != nil else {
                        // firebase can't
                        completion(false)
                        return
                    }
                    // user created
                    DatabaseManager.shared.insertNewUser(with: email, username: username) { (success) in
                        if success {
                            completion(true)
                            return
                        }else{
                            completion(false)
                            return
                        }
                    }
                }
            }else{
                // id dont exist
                completion(false)
            }
        }
    }
    
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
        if let email = email {
            // email log in
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        } else if let username = username {
            // username log in
            
            /*Auth.auth().signIn(username: username, password: password) { (authResult, error) in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }*/
        }
    }
    
    public func logOut(completion: (Bool)->Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        } catch {
            print(error)
            completion(false)
            return
        }
    }
}
