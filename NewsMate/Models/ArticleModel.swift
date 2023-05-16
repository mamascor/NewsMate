//
//  ArticleModel.swift
//  NewsMate
//
//  Created by Marco Mascorro on 5/16/23.
//

import Foundation

struct NewsResponse: Codable {
    let articles : [Article]
}

struct Article: Codable {
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
}


struct Source: Decodable {
    let name: String
}



