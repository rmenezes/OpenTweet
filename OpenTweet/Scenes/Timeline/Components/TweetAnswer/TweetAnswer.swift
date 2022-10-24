//
//  TweetView.swift
//  OpenTweet
//
//  Created by Raul Menezes on 15/10/2022.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import Kingfisher
import SwiftUI

struct TweetAnswer: View {
    let tweet: Tweet
    var body: some View {
        HStack(alignment: .top) {
            AvatarView(url: tweet.avatar, size: .small)
            
            VStack(
                alignment: .leading,
                spacing: .Spacing.xs
            ) {
                HStack(spacing: .Spacing.xxs) {
                    Text(tweet.author)
                        .font(.headline)
                        .foregroundColor(.Brand.secondaryText)
                    
                    Text(tweet.date, style: .relative)
                        .font(.callout)
                        .foregroundColor(.System.placeholder)
                }
                
                VStack {
                    ContentView(viewModel: ContentViewModel(tweet: tweet))
                    
                    if let images = tweet.images {
                        ImageView(images: images)
                    }
                }
            }
        }
        .padding(.default)
    }
}

struct TweetAnswer_Previews: PreviewProvider {
    static var previews: some View {
        TweetAnswer(tweet: Self.mock)
    }
}
