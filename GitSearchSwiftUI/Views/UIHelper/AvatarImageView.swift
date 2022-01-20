//
//  AvatarImageView.swift
//  GitSearchSwiftUI
//
//  Created by Константин Чернов on 19.01.2022.
//

import SwiftUI

struct AvatarImageView: View {
    @StateObject var model = AvatarImageViewModel()
    var url: String
    
    init(url: String) {
        self.url = url
    }
    
    var body: some View {
        VStack{
            if model.image == nil {
                ProgressView()
            } else {
                Image(uiImage: model.image!)
                    .resizable()
            }
        }
        .frame(width: 50, height: 50)
        .onAppear(){
            model.fetchImages(url: url)
        }
    }
}
