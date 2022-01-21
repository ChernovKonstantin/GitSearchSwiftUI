//
//  APIService.swift
//  GitSearchSwiftUI
//
//  Created by Константин Чернов on 18.01.2022.
//

import Foundation
import UIKit

struct APIService {
    let urlString: String
    
    func makeRequest<T:Decodable>() async throws -> T {
        guard let url = URL(string: urlString) else { throw APIError.urlError }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw APIError.responseStatusError }
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                return decodedData
            } catch {
                throw APIError.decoderError
            }
        } catch {
            throw APIError.dataTaskError
        }
    }
    
    func loadImage() async throws -> UIImage {
        guard let url = URL(string: urlString) else { throw APIError.urlError }
            let (data, response) = try await URLSession.shared.data(from: url)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw APIError.responseStatusError }
            guard let image = UIImage(data: data) else { throw APIError.imageDataError }
            return image
    }
}
