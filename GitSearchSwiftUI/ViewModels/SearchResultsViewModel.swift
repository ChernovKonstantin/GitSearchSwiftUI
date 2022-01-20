//
//  SearchResultsViewModel.swift
//  GitSearchSwiftUI
//
//  Created by Константин Чернов on 18.01.2022.
//

import Foundation
import UIKit
import SwiftUI

class SearchResultsViewModel: ObservableObject {
    @Published var repositories: [RepositoryObject] = []
    var cachedAvatars: [String: Image] = [:]
    private var currentPage = 1
    private(set) var canLoadMore = true
    private var searchTimer: Timer?
    
    func fetchRepos(withName: String = "", searchPerformed: Bool = false) {
        let searchText = withName.isEmpty ? "swift" : withName
        if searchPerformed { currentPage = 1 }
        searchTimer?.invalidate()
        let seconds = searchPerformed ? 0.75 : 0
        let apiService = APIService(urlString: "https://api.github.com/search/repositories" + "?per_page=30&sort=stars&page=\(currentPage)&q=\(searchText)&order=desc")
        searchTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(seconds), repeats: false) { _ in
            apiService.makeRequest() { [weak self] (result: Result<SearchResults, APIError>) in
                switch result {
                case .success(let searchResult):
                    DispatchQueue.main.async {
                        if searchPerformed {
                            self?.repositories = searchResult.items
                        } else {
                            self?.repositories.append(contentsOf: searchResult.items)
                        }
                    }
                    if searchResult.items.count < searchResult.totalCount {
                        self?.currentPage += 1
                        self?.canLoadMore = true
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
