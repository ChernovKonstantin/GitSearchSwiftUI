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
    
    func makeRequest<T:Decodable>(completion: @escaping (Result<T,APIError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.urlError))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let responseStatus = response as? HTTPURLResponse, responseStatus.statusCode == 200 else {
                completion(.failure(.responseStatusError))
                return
            }
            guard error == nil else {
                completion(.failure(.dataTaskError))
                return
            }
            guard let data = data else {
                completion(.failure(.dataError))
                return
            }
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decoderError))
            }
        }
        .resume()
    }
    
    func loadImages(urlString: String, completion: @escaping (Result<UIImage,APIError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.urlError))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let responseStatus = response as? HTTPURLResponse, responseStatus.statusCode == 200 else {
                completion(.failure(.responseStatusError))
                return
            }
            guard error == nil else {
                completion(.failure(.dataTaskError))
                return
            }
            guard let data = data else {
                completion(.failure(.dataError))
                return
            }
                let image = UIImage(data: data)
            guard let image = image else { return }
                completion(.success(image))
        }
        .resume()
    }
}
