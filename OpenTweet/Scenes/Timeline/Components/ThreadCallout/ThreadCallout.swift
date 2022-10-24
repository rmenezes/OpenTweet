//
//  ThreadCallout.swift
//  OpenTweet
//
//  Created by Raul Menezes on 23/10/2022.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import SwiftUI

struct ThreadCallout: View {
    let tweet: Tweet
    var body: some View {
        HStack(spacing: .Spacing.sm) {
            AvatarView(
                url: tweet.avatar,
                size: .small
            )
            
            Text("Show this thread")
                .font(.body)
                .foregroundColor(.Brand.primary)
        }
        .padding(.vertical, .Spacing.xxs)
        .padding(.leading, .Spacing.m)
        .padding(.trailing, .Spacing.sm)
        .background(
            VStack(spacing: .zero) {
                HStack(spacing: .zero) {
                    Rectangle()
                        .fill(Color.System.separator)
                        .frame(width: 2, height: 30, alignment: .top)
                        .padding(.leading, .Spacing.m + .Avatar.small / 2)
                    
                    Spacer()
                }
                
                Spacer()
            }
            .padding(.vertical, -.Spacing.xxs)
            .background(Color.white)
        )
    }
}

struct ThreadCallout_Previews: PreviewProvider {
    static var previews: some View {
        ThreadCallout(tweet: TweetView_Previews.mock)
    }
}
