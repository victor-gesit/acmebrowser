//
//  BrowserViewModel.swift
//  acmebrowser
//
//  Created by Victor Idongesit on 11/04/2022.
//

import SwiftUI

class BrowserViewModel: ObservableObject {
    @Published var currentTab: BrowserTabModel = BrowserTabModel()
    @Published var allTabs: [BrowserTabModel] = []
}
