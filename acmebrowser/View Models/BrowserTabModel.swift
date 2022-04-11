//
//  BrowserTabModel.swift
//  acmebrowser
//
//  Created by Victor Idongesit on 11/04/2022.
//

import Foundation

class BrowserTabModel: ObservableObject {
    @Published var urlString = ""
    @Published var canGoBack = false
    @Published var canGoForward = false
    @Published var canReload = false
}
