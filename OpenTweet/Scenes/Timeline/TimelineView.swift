//
//  TimelineView.swift
//  OpenTweet
//
//  Created by Raul Menezes on 15/10/2022.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import SwiftUI

struct TimelineView<ViewModel: TimelineViewModeling & ObservableObject>: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    let last = viewModel.data.last
                    
                    ForEach(viewModel.data.indices, id: \.self) { index in
                        let tweet = viewModel.data[index]
                        NavigationLink(
                            destination: ThreadView(viewModel: ThreadViewModel(tweet)),
                            label: {
                                VStack(alignment: .leading) {
                                    TweetView(tweet: tweet.value)
                                    
                                    if let firstAvatar = tweet.children.first {
                                        ThreadCallout(tweet: firstAvatar.value)
                                    }
                                }
                                .background(
                                    HStack(spacing: .zero) {
                                        if tweet.children.count > 0 {
                                            Rectangle()
                                                .fill(Color.System.separator)
                                                .frame(width: 2)
                                                .frame(maxHeight: .infinity)
                                                .padding(.top, .Spacing.m)
                                                .padding(.leading, .Spacing.m + .Avatar.small / 2)
                                            
                                            Spacer()
                                        } else {
                                            EmptyView()
                                        }
                                    }
                                )
                            }
                        )
                        
                        if last != tweet {
                            Divider()
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
        .onAppear(perform: viewModel.onAppear)
    }
}

struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView(viewModel: ViewModel())
    }
}
