//
//  Post.swift
//  AliensAtHome
//
//  Created by MAC Consultant on 8/9/19.
//  Copyright © 2019 Aldo. All rights reserved.
//

import Foundation

//Model to handle date obtained from API
struct RedditBase: Codable {
    let kind: String
    let data: ResponseData
}

struct ResponseData: Codable {
    let children: [Post]
    let after: String?
    let before: String?
}

struct Post: Codable {
    let kind: String
    let data: PostData
}

struct PostData: Codable {
    let preview: Preview?
    let id: String?
    let author: String?
    let url: String?
    let numComments: Int?
    let title: String
    let createdUTC: Int?
    let thumbnailHeight: Int?
    let thumbnailWidth: Int?
    let thumbnail: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case thumbnailHeight = "thumbnail_height"
        case numComments = "num_comments"
        case thumbnailWidth = "thumbnail_width"
        case createdUTC = "created_utc"
        case name, thumbnail, preview, id, author, url, title
    }
}

struct Preview: Codable {
    let images: [Image]
    let enabled: Bool
}

struct Image: Codable {
    let source: Source
    let resolutions: [Source]
    let id: String
}

struct Source: Codable {
    let url: String
    let width, height: Int
}
