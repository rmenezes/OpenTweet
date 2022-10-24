//
//  GalleryView.swift
//  OpenTweet
//
//  Created by Raul Menezes on 23/10/2022.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import SwiftUI
import Kingfisher

struct GalleryView: View {
    @Binding var activeIndex: Int
    let images: [String]
    var body: some View {
        TabView(selection: $activeIndex) {
            ForEach(images.indices, id: \.self) { index in
                KFImage
                    .url(URL(string: images[index]))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.System.placeholder)
                    .id(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .background(Color.black)
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView(activeIndex: .constant(0), images: [])
    }
}
