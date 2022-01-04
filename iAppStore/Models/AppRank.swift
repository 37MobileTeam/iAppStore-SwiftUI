//
//  AppRank.swift
//  iAppStore
//
//  Created by HTC on 2021/12/18.
//  Copyright © 2021 37 Mobile Games. All rights reserved.
//

import Foundation
import SwiftUI

// MARK: - AppRankM
struct AppRankM: Codable {
    let feed: Feed
}

// MARK: - Feed
struct Feed: Codable {
    let author: Author
    let entry: [AppRank]
    let icon, id: Title
    let link: [FeedLink]
    let rights, title, updated: Title
}

// MARK: - Author
struct Author: Codable {
    let name, uri: Title
}

// MARK: - Title
struct Title: Codable {
    let label: String
}

// MARK: - Entry
struct AppRank: Codable {
    let category: Category
    let id: ID
    let imArtist: IMArtist
    let imContentType: IMContentType
    let imImage: [IMImage]
    let imName: Title
    let imPrice: IMPrice
    let imReleaseDate: IMReleaseDate
//    let link: [EntryLink]
    let summary: Title?
    let rights: Title?
    let title: Title
    
    //替换自定义键值名
     enum CodingKeys: String, CodingKey {
         case category, id, rights, summary, title//, link
         case imArtist = "im:artist"
         case imContentType = "im:contentType"
         case imImage = "im:image"
         case imName = "im:name"
         case imPrice = "im:price"
         case imReleaseDate = "im:releaseDate"
     }
}

         
// MARK: - Category
struct Category: Codable {
    let attributes: CategoryAttributes
}

// MARK: - CategoryAttributes
struct CategoryAttributes: Codable {
    let imID, label: String
    let scheme: String
    let term: String
    
    //自定义键值名
     enum CodingKeys: String, CodingKey {
        case label, scheme, term
        case imID = "im:id" //关键字替换
    }
}

// MARK: - ID
struct ID: Codable {
    let attributes: IDAttributes
    let label: String
}

// MARK: - IDAttributes
struct IDAttributes: Codable {
    let imBundleID, imID: String
    
    // 自定义键值名
     enum CodingKeys: String, CodingKey {
        case imID = "im:id"
        case imBundleID = "im:bundleId"
    }
}

// MARK: - IMArtist
struct IMArtist: Codable {
    let attributes: IMArtistAttributes?
    let label: String
}

// MARK: - IMArtistAttributes
struct IMArtistAttributes: Codable {
    let href: String
}

// MARK: - IMContentType
struct IMContentType: Codable {
    let attributes: IMContentTypeAttributes
}

// MARK: - IMContentTypeAttributes
struct IMContentTypeAttributes: Codable {
    let label, term: String
}

// MARK: - IMImage
struct IMImage: Codable {
    let attributes: IMImageAttributes
    let label: String
}

// MARK: - IMImageAttributes
struct IMImageAttributes: Codable {
    let height: String
}

// MARK: - IMPrice
struct IMPrice: Codable {
    let attributes: IMPriceAttributes
    let label: String
}

// MARK: - IMPriceAttributes
struct IMPriceAttributes: Codable {
    let amount, currency: String
}

// MARK: - IMReleaseDate
struct IMReleaseDate: Codable {
    let attributes: Title
    let label: String
}

// MARK: - EntryLink
struct EntryLink: Codable {
    let attributes: PurpleAttributes
    let imDuration: Title?
}

// MARK: - PurpleAttributes
struct PurpleAttributes: Codable {
    let href: String
    let rel, type: String
    let imAssetType, title: String?
}

// MARK: - FeedLink
struct FeedLink: Codable {
    let attributes: FluffyAttributes
}

// MARK: - FluffyAttributes
struct FluffyAttributes: Codable {
    let href: String
    let rel: String
    let type: String?
}

