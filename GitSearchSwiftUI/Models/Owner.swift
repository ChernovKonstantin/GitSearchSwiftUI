//
//  Owner.swift
//  GitSearchSwiftUI
//
//  Created by Константин Чернов on 18.01.2022.
//

import Foundation
import UIKit

struct Owner: Codable {
    var avatarUrl: String?
    var image: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
    }
}
