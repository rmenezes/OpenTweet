//
//  ContentView.swift
//  OpenTweet
//
//  Created by Raul Menezes on 15/10/2022.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import SwiftUI

struct ContentView<ViewModel: ContentViewModeling & ObservableObject>: View {
    @ObservedObject var viewModel: ViewModel
    
    @ViewBuilder
    var body: some View {
        FlexibleView(
            data: viewModel.content,
            spacing: .Spacing.xxs,
            alignment: .leading
        ) {
            makeView(for: $0)
        }
    }
    
    @ViewBuilder
    func makeView(
        for content: TweetContentComponent.ContentPart
    ) -> some View {
        switch content.type {
        case .handle, .hashtag:
            NavigationLink(
                destination: Text(content.text),
                label: {
                    Text(content.text)
                        .font(.body)
                        .bold()
                        .foregroundColor(.Brand.primary)
                }
            )
        case .link:
            Link(
                destination: URL(string: content.text)!,
                label: {
                    Text("\(String(content.text.prefix(15)))...\(String(content.text.suffix(4)))")
                        .bold()
                        .foregroundColor(.Brand.primary)
                }
            )
        case .text:
            Text(content.text)
                .font(.body)
                .foregroundColor(.Brand.primaryText)
        default:
            EmptyView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel(tweet: TweetView_Previews.mock))
    }
}
