//
//  AvatarView.swift
//  OpenTweet
//
//  Created by Raul Menezes on 15/10/2022.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import Kingfisher
import SwiftUI

struct AvatarView: View {
    enum Size: String {
        case medium
        case small
    }
    
    let url: String?
    let size: Size
    
    var body: some View {
        Circle()
            .foregroundColor(.System.placeholder)
            .overlay(
                KFImage
                    .url(URL(string: url.orEmpty))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.System.placeholder)
                    .frame(
                        width: size == .medium ? .Avatar.medium : .Avatar.small,
                        height: size == .medium ? .Avatar.medium : .Avatar.small
                    )
                    .clipShape(Circle())
            )
            .frame(
                width: size == .medium ? .Avatar.medium : .Avatar.small,
                height: size == .medium ? .Avatar.medium : .Avatar.small
            )
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(url: "http://rmenezes.me", size: .small)
    }
}
