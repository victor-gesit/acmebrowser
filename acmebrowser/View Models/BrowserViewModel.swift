//
//  BrowserViewModel.swift
//  acmebrowser
//
//  Created by Victor Idongesit on 11/04/2022.
//

import SwiftUI

class BrowserViewModel: ObservableObject {
    @Published var allTabs: [BrowserTabModel] = []
    @Published var selectedTab: UUID
    @Published var currentTab: BrowserTabModel
    var tabsDict: [UUID: BrowserTabModel] = [:]
    var tabCount = 0
    
    init() {
        self.tabCount = 1
        let defaultTab = BrowserTabModel(tabIndex: tabCount)
        tabsDict = [defaultTab.id: defaultTab]
        self.currentTab = defaultTab
        self.selectedTab = defaultTab.id
        allTabs = tabsDict.values.sorted(by: { $0.tabIndex < $1.tabIndex })
    }
    
    func addTab() {
        tabCount += 1
        let newTab = BrowserTabModel(tabIndex: tabCount)
        tabsDict[newTab.id] = newTab
        allTabs = tabsDict.values.sorted(by: { $0.tabIndex < $1.tabIndex })
        currentTab = newTab
    }
    
    func switchTab(to id: UUID) {
        guard let tab = tabsDict[id] else {
            return
        }
        currentTab = tab
    }
    
    func deleteTab() {
        
    }
}
