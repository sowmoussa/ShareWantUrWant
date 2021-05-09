//
//  models.swift
//  ShareWhatUWhant
//
//  Created by Moussa SOW on 25/04/2021.
//

import Foundation



public enum UserPostType {
    case photo, video
}

enum Gender {
    case male, female
}

struct User {
    let username: String
    let bio: String
    let name: (first: String, last: String)
    let birthday: Date
    let gender: Gender
    let counts: UserCount
    let joinDate: Date
}

struct UserCount {
    let follower: Int
    let following: Int
    let post: Int
}
public struct UserPost {
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postUrl: URL // photo, video
    let caption: String?
    let likeCount: [PostLikes]
    let comments: [PostComment]
    let createdDate: Date
    let taggedUsers: [String]
}

public struct CommentLike {
    let username: String
    let commentIdentifier: String
}

public struct PostComment {
    let identifier: String
    let username: String
    let text: String
    let createdComment: Date
    let likes: [CommentLike]
}

public struct PostLikes {
    let username: String
    let postIdentifier: String
}
