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
    
    var body: some View {
        NavigationView {
            VStack {
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
                            if let image = viewModel.cachedAvatars[repo.id] {
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 40, height: 40)
                            } else {
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                            }
                        }
                        .task {
                            await viewModel.fetchImage(for: repo.owner.avatarUrl!, userID: repo.id)
                            if viewModel.repositories.last == repo,
                               viewModel.canLoadMore {
                                if searchText.isEmpty {
                                    await viewModel.fetchRepos()
                                } else {
                                    await viewModel.fetchRepos(withName: searchText)
                                }
                            }
                        }
                    }
                }
                .searchable(text: $searchText)
                .navigationTitle("Search")
                .task {
                    await viewModel.fetchRepos()
                }
                .onChange(of: searchText) {newValue in
                    Task {
                        await viewModel.fetchRepos(withName: newValue, searchPerformed: true)
                    }
                }
                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(1.5)
                }
            }
        }
        
    }
}

struct SearchResultsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsView()
    }
}
