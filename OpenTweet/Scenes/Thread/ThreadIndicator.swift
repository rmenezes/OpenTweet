//
//  ThreadIndicator.swift
//  OpenTweet
//
//  Created by Raul Menezes on 23/10/2022.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import SwiftUI

struct ThreadIndicator: View {
    let tweet: Tweet
    let nextTweet: Tweet?
    let previousTweet: Tweet?
    let firstTweet: Tweet?
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: .zero) {
                HStack(alignment: .top, spacing: .zero) {
                    // If tweet is an answer to the original tweet and there's no replies to it, we don't render anything
                    if tweet.inReplyTo == firstTweet?.id && nextTweet?.inReplyTo == firstTweet?.id {
                        EmptyView()
                    } else if tweet.id == nextTweet?.inReplyTo && tweet.inReplyTo == previousTweet?.id {
                        // Middle thread
                        Rectangle()
                            .fill(Color.System.separator)
                            .frame(width: 2, height: proxy.size.height)
                            .padding(.leading, .Spacing.sm + .Avatar.small / 2)
                        Spacer()
                    } else if tweet.inReplyTo == previousTweet?.id {
                        // Last thread without answer
                        Rectangle()
                            .fill(Color.System.separator)
                            .frame(width: 2, height: 30)
                            .padding(.leading, .Spacing.sm + .Avatar.small / 2)
                        Spacer()
                    } else if tweet.id == nextTweet?.inReplyTo {
                        // Top thread
                        Rectangle()
                            .fill(Color.System.separator)
                            .frame(
                                width: 2,
                                height: proxy.size.height - .Spacing.m,
                                alignment: .bottom
                            )
                            .padding(.leading, .Spacing.sm + .Avatar.small / 2)
                            .padding(.top, .Spacing.m)
                        Spacer()
                    } else {
                        EmptyView()
                    }
                }
                
                Spacer()
            }
        }
    }
}
