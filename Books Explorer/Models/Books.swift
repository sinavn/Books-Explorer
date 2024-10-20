//
//  Books.swift
//  Books Explorer
//
//  Created by Sina Vosough Nia on 7/29/1403 AP.
//

import Foundation

struct Books : Codable {
    let items: [Book]?
}

struct Book : Codable , Identifiable , Hashable {
    static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: String
    let selfLink: String?
    let volumeInfo: BookInfo
}

struct BookInfo : Codable , Hashable {
    let title:String?
    let subtitle: String?
    let authors: [String]?
    let publisher, publishedDate, description: String?
    let pageCount: Int?
    let categories: [String]?
    let averageRating: Double?
    let ratingsCount: Int?
    let contentVersion: String?
    let imageLinks: ImageLinks?
    let language: String?
    let previewLink: String?
    let infoLink: String?
    let canonicalVolumeLink: String?
}

struct ImageLinks : Codable , Hashable{
    let smallThumbnail, thumbnail: String?
}




