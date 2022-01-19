//
//  SearchResultsViewModel.swift
//  GitSearchSwiftUI
//
//  Created by Константин Чернов on 18.01.2022.
//

import Foundation
import UIKit

class SearchResultsViewModel: ObservableObject {
    @Published var repositories: [RepositoryObject] = []
    
    func fetchRepos() {
        let apiService = APIService(urlString: "https://api.github.com/search/repositories?per_page=5&sort=forks&page=1&q=swift&order=desc")
        apiService.makeRequest() { (result: Result<SearchResults, APIError>) in
            switch result {
            case .success(let searchResult):
                DispatchQueue.main.async {
                    self.repositories = searchResult.items
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
