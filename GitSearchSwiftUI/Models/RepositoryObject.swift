//
//  RepositoryObject.swift
//  GitSearchSwiftUI
//
//  Created by Константин Чернов on 18.01.2022.
//

import Foundation

struct RepositoryObject: Codable, Identifiable {
    var id = UUID().uuidString
    
    var fullName: String
    var repDescription: String?
    var owner: Owner
    var updatedAt: String?
    var createdAt: String?
    var forksCount: Int?
    var language: String?
    var stargazersCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case owner, language
        case fullName = "full_name"
        case repDescription = "description"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case forksCount = "forks_count"
        case stargazersCount = "stargazers_count"
    }
}
