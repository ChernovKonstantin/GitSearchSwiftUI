//
//  AvatarImageViewModel.swift
//  GitSearchSwiftUI
//
//  Created by Константин Чернов on 19.01.2022.
//

import Foundation
import UIKit

class AvatarImageViewModel: ObservableObject {
    @Published var image: UIImage?
    
    func fetchImages(url: String) {
        let apiService = APIService(urlString: "")
        apiService.loadImages(urlString: url) { [weak self] (result: Result<UIImage, APIError>) in
            switch result {
            case .success(let searchResult):
                DispatchQueue.main.async {
                    self?.image = searchResult
                }
            case .failure(let error):
                self?.image = UIImage(systemName: "photo")!
                print(error)
            }
        }
    }
}
