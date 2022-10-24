//
//  ImageView.swift
//  OpenTweet
//
//  Created by Raul Menezes on 23/10/2022.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import SwiftUI
import Kingfisher

struct ImageView: View {
    private var columns: [GridItem]
    private let images: [String]
    @State private var width: CGFloat?
    @State private var selectedImage: Int = 0
    @State private var isPresented: Bool = false
    
    init(
        images: [String]
    ) {
        self.images = images
        columns = {
            let repeating: Int
            
            if images.count >= 2 {
                repeating = 2
            } else {
                repeating = 1
            }
            
            return Array(
                repeating: GridItem(
                    .flexible(minimum: 100, maximum: 300),
                    spacing: .Spacing.xxs
                ), count: repeating
            )
        }()
    }
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: .Spacing.xxs) {
            ForEach(images.prefix(4).indices, id: \.self) { index in
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.System.placeholder)
                    .frame(height: 150)
                    .overlay(
                        KFImage
                            .url(URL(string: images[index]))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .foregroundColor(.System.placeholder)
                            .frame(height: 150)
                            .background(Color.System.placeholder)
                            .cornerRadius(4)
                            .allowsHitTesting(false)
                        , alignment: .topTrailing
                    )
                    .id(index)
                    .clipped()
                    .overlay(
                        Group {
                            if images.count > 4 && index == 3 {
                                Rectangle()
                                    .fill(Color.System.placeholder.opacity(0.3))
                                    .overlay(
                                        Text("+\(images.count - (index + 1))")
                                            .foregroundColor(Color.white)
                                            .font(.title)
                                            .bold(),
                                        alignment: .center
                                    )
                            }
                        }
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.System.separator, lineWidth: 1)
                    )
                    .onTapGesture {
                        selectedImage = index
                        isPresented.toggle()
                    }
            }
        }
        .sheet(isPresented: $isPresented) {
            GalleryView(activeIndex: $selectedImage, images: images)
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(images: [
            "https://cms-cdn.thesolesupplier.co.uk/2021/12/air-jordan-1-high-og-yellow-toe-taxi-555088-711-1_w900.jpeg"
        ])
    }
}
