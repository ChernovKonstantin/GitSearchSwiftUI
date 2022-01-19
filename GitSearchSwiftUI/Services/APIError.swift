//
//  APIError.swift
//  GitSearchSwiftUI
//
//  Created by Константин Чернов on 18.01.2022.
//

import Foundation

enum APIError: Error {
    case urlError
    case responseStatusError
    case dataError
    case dataTaskError
    case decoderError
}
