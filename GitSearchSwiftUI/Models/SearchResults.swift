//
//  SearchResults.swift
//  GitSearchSwiftUI
//
//  Created by Константин Чернов on 18.01.2022.
//

import Foundation

struct SearchResults: Codable {
    var totalCount: Int
    var incompleteResults: Bool
    var items: [RepositoryObject]
    
    enum CodingKeys: String, CodingKey {
        case items
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
    }
}
