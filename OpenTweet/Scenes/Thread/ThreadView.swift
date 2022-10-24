//
//  ThreadView.swift
//  OpenTweet
//
//  Created by Raul Menezes on 23/10/2022.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import SwiftUI

struct ThreadView<ViewModel: ThreadViewModeling & ObservableObject>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: .zero) {
                let first = viewModel.tweets.first
                let last = viewModel.tweets.last
                
                ForEach(viewModel.tweets.indices, id: \.self) { index in
                    let previousTweet = viewModel.tweets[safe: index - 1]
                    let tweet = viewModel.tweets[index]
                    let nextTweet = viewModel.tweets[safe: index + 1]
                    
                    VStack(alignment: .leading, spacing: .zero) {
                        if index == 0 {
                            TweetView(tweet: tweet)
                            
                            Divider()
                        } else {
                            TweetAnswer(tweet: tweet)
                                .background(
                                    ThreadIndicator(
                                        tweet: tweet,
                                        nextTweet: nextTweet,
                                        previousTweet: previousTweet,
                                        firstTweet: first
                                    )
                                )
                        }
                    }
                    
                    if last != tweet && tweet.inReplyTo == first?.id && nextTweet?.inReplyTo != tweet.id {
                        Divider()
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Image("twitter-logo")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ThreadView_Previews: PreviewProvider {
    static var previews: some View {
        ThreadView(viewModel: ViewModel())
    }
}
