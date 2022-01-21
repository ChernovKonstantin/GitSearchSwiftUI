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
    @Published var cachedAvatars: [String: UIImage] = [:]
    @Published var isLoading = false
    
    private var currentPage = 1
    private(set) var canLoadMore = true
    private var searchTimer: Timer?
    
    func fetchRepos(withName: String = "", searchPerformed: Bool = false) async {
        let searchText = withName.isEmpty ? "swift" : withName
        if searchPerformed { currentPage = 1 }
        searchTimer?.invalidate()
        let seconds = searchPerformed ? 0.75 : 0
        let apiService = APIService(urlString: "https://api.github.com/search/repositories" + "?per_page=30&sort=stars&page=\(currentPage)&q=\(searchText)&order=desc")
        searchTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(seconds), repeats: false) { _ in
            self.isLoading = true
            Task {
                do {
                    let response: SearchResults = try await apiService.makeRequest()
                    DispatchQueue.main.async {
                        if searchPerformed {
                            self.repositories = response.items
                        } else {
                            self.repositories.append(contentsOf: response.items)
                        }
                        self.isLoading = false
                    }
                    self.currentPage += 1
                } catch  {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func fetchImage(for url: String, userID: String) async {
        guard cachedAvatars[userID] == nil else { return }
        let apiService = APIService(urlString: url)
        do {
            let image = try await apiService.loadImage()
            DispatchQueue.main.async {
                self.cachedAvatars[userID] = image
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
