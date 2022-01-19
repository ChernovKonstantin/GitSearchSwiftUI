//
//  SearchResultsView.swift
//  GitSearchSwiftUI
//
//  Created by Константин Чернов on 18.01.2022.
//

import SwiftUI

struct SearchResultsView: View {
    @StateObject var viewModel = SearchResultsViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.repositories) { repo in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(repo.fullName)
                                .font(.title)
                                .bold()
                                .lineLimit(2)
                            HStack{
                                Image(systemName: "star")
                                Text(String(repo.stargazersCount ?? 0))
                                    .lineLimit(1)
                            }
                        }
                        Spacer()
                        AsyncImage(url: URL(string: repo.owner.avatarUrl ?? "")) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 50, height: 50)
                    }
                }
            }
            .navigationTitle("Search")
            .onAppear() {
                viewModel.fetchRepos()
            }
        }
        
    }
}

struct SearchResultsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsView()
    }
}
