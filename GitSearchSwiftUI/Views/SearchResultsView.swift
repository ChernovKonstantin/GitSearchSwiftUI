//
//  SearchResultsView.swift
//  GitSearchSwiftUI
//
//  Created by Константин Чернов on 18.01.2022.
//

import SwiftUI

struct SearchResultsView: View {
    @StateObject var viewModel = SearchResultsViewModel()
    @State private var searchText = ""
    private var searchTimer: Timer?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.repositories) { repo in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(repo.fullName)
                                .font(.title3)
                                .bold()
                                .lineLimit(1)
                            HStack{
                                Image(systemName: "star")
                                Text(String(repo.stargazersCount ?? 0))
                                    .lineLimit(1)
                            }
                        }
                        Spacer()
                        AvatarImageView(url: repo.owner.avatarUrl ?? "")
                    }
                    .onAppear() {
                        if viewModel.repositories.last == repo,
                           viewModel.canLoadMore {
                            if searchText.isEmpty {
                                viewModel.fetchRepos()
                            } else {
                                viewModel.fetchRepos(withName: searchText)
                            }
                        }
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Search")
            .onAppear() {
                viewModel.fetchRepos()
            }
            .onChange(of: searchText) {newValue in
                    viewModel.fetchRepos(withName: newValue, searchPerformed: true)
            }
        }
        
    }
}

struct SearchResultsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsView()
    }
}
