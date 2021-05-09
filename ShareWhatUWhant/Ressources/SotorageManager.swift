//
//  SotorageManager.swift
//  ShareWhatUWhant
//
//  Created by Moussa SOW on 23/04/2021.
//


import FirebaseStorage

public class StorageManager {
    static let shared = StorageManager()
    
    private let bucket = Storage.storage().reference()
    // MARK: - Public
    public enum IGStorageManagerError: Error {
        case failureToDownload
    }
    public func unploadUserPost(model: UserPost, completion: (Result<URL, Error>) -> Void) {
        
    }
    
    public func downloadImage(with reference: String, completion: @escaping (Result<URL, IGStorageManagerError>) -> Void) {
        bucket.child(reference).downloadURL { (url, error) in
            guard let url = url, error == nil else {
                completion(.failure(.failureToDownload))
                return
            }
            completion(.success(url))
        }
    }
}
