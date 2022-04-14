//
//  Image+Extensions.swift
//  acmebrowser
//
//  Created by Victor Idongesit on 13/04/2022.
//

import SwiftUI

enum ACMEImage: String {
    case goBack
    case goForward
    case addTab
    case reload
}

extension Image {
    static func from(_ acmeImage: ACMEImage) -> Image {
        return Image(acmeImage.rawValue)
    }
}
