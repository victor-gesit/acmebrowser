//
//  BrowserView.swift
//  acmebrowser
//
//  Created by Victor Idongesit on 11/04/2022.
//

import SwiftUI

struct BrowserView: View {
    @StateObject var allModel = BrowserViewModel()
    @State var faviconForPage: [UUID: URL] = [:]
    @State var loadingProgress: Double = 1
    @State var loadingProgressHeight: Double = 4
    @State var canGoBack = false
    @State var canReload = false
    @State var canGoForward = true
    @State var creatingTab = false
    @State var errorOccured = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.from(.appBackground)
            
            VStack {
                HStack {
                    HStack {
                        ZStack(alignment: .leading) {
                            if(allModel.currentTab.urlString.isEmpty) {
                                Text(String.enterUrl)
                                    .foregroundColor(Color.from(.textColor))
                                    .padding(.leading, 10)
                            }
                            
                            TextField("", text: $allModel.currentTab.urlString)
                                .foregroundColor(.black)
                                .disableAutocorrection(true)
                                .keyboardType(.URL)
                                .autocapitalization(.none)
                                .padding(Consts.Home.pagePadding)
                                .keyboardType(.URL)
                                .submitLabel(.go)
                                .onSubmit {
                                    allModel.currentTab.loadUrl()
                                    UIApplication.shared.endEditing()
                                    
                                }
                        }
                        Spacer()
                        Button {
                            allModel.currentTab.reloadPage()
                        } label: {
                            Image.from(.reload)
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: Consts.Home.reloadButton, height: Consts.Home.reloadButton)
                                .foregroundColor(Color.from(canReload ? .progressView : .borders))
                                .frame(width: Consts.Home.buttonWidth, height: Consts.Home.buttonHeight)
                                .padding(Consts.Home.imagePadding)
                        }
                        .onReceive(allModel.currentTab.$canReload) { can in
                            canReload = can
                        }
                    }
                    .background(Color.from(.textFieldBackground))
                    .cornerRadius(Consts.Home.cornerRadius)
                    .overlay(
                        RoundedRectangle(cornerRadius: Consts.Home.cornerRadius)
                            .stroke(Color.from(.borders), lineWidth: Consts.Home.inputFieldBorderWidth)
                    )
                    
                    Button {
                        allModel.currentTab.goBack()
                    } label: {
                        Image.from(.goBack)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color.from(canGoBack ? .navButton : .borders))
                            .frame(width: Consts.Home.buttonWidth, height: Consts.Home.buttonHeight)
                            .padding(Consts.Home.imagePadding)
                    }
                    .disabled(!canGoBack)
                    .onReceive(allModel.currentTab.$canGoBack) { canGo in
                        canGoBack = canGo
                    }
                    
                    Button {
                        allModel.currentTab.goForward()
                    } label: {
                        Image.from(.goForward)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color.from(canGoForward ? .navButton : .borders))
                            .frame(width: Consts.Home.buttonWidth, height: Consts.Home.buttonHeight)
                            .padding(Consts.Home.imagePadding)
                    }
                    .disabled(!canGoForward)
                    .onReceive(allModel.currentTab.$canGoForward) { canGo in
                        canGoForward = canGo
                    }
                    
                }.padding(Consts.Home.pagePadding)
                LoadingProgressView(progressPercentage: $loadingProgress)
                    .onReceive(allModel.currentTab.$estimatedProgress) { progress in
                        loadingProgress = progress
                    }
                
                ZStack {
                    ForEach([allModel.currentTab], id: \.id) { tab in
                        if tab.id == allModel.currentTab.id {
                            tab.browserWebView
                        }
                    }
                    if errorOccured {
                        VStack {
                            Text(String.errorOccured)
                                .foregroundColor(.red)
                                .lineLimit(0)
                        }
                        .background(Color.from(.appBackground))
                    } else if !canReload {
                        VStack {
                            Text(String.newTabString + " \(allModel.currentTab.tabIndex)")
                                .foregroundColor(Color.from(.textColor))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .background(Color.from(.appBackground))
                    }
                }
                .background(Color.from(.appBackground))
                .onReceive(allModel.$creatingTab) { creating in
                    creatingTab = creating
                }
                .onReceive(allModel.currentTab.$errorOcured) { errored in
                    errorOccured = errored
                }
                
                HStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(allModel.allTabs, id: \.id) { tab in
                                VStack {
                                    if let url = faviconForPage[tab.id] {
                                        VStack {
                                            AsyncImage(url: url) { image in
                                                image
                                                    .resizable()
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: Consts.Home.buttonHeight)
                                                            .stroke(Color.from(.progressView), lineWidth: tab.id == allModel.currentTab.id ? Consts.Home.imagePadding : 0)
                                                    )
                                                    .frame(width: Consts.Home.buttonWidth, height: Consts.Home.buttonHeight)
                                                    .cornerRadius(Consts.Home.buttonWidth/2)
                                                    .foregroundColor(.white)
                                                    .onTapGesture {
                                                        allModel.switchTab(to: tab.id)
                                                    }
                                            } placeholder: {
                                                ProgressView()
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: Consts.Home.buttonHeight)
                                                            .stroke(Color.from(.progressView), lineWidth: tab.id == allModel.currentTab.id ? Consts.Home.imagePadding : 0)
                                                    )
                                                    .frame(width: Consts.Home.buttonWidth, height: Consts.Home.buttonHeight)
                                                    .onTapGesture {
                                                        allModel.switchTab(to: tab.id)
                                                    }
                                            }
                                        }
                                        
                                    }
                                    else {
                                        emptyTabView(selected: tab.id == allModel.currentTab.id)
                                            .onTapGesture {
                                                allModel.switchTab(to: tab.id)
                                            }
                                    }
                                }
                                .onReceive(tab.$faviconURL) { newVal in
                                    guard let string = newVal?.absoluteString, !string.isEmpty else { return }
                                    faviconForPage[tab.id] = tab.faviconURL
                                }
                            }
                        }
                    }
                    .frame(height: 40)
                    .padding(.leading, Consts.Home.pagePadding)
                    
                    Spacer()
                    Button {
                        allModel.addTab()
                    } label: {
                        Image.from(.addTab)
                            .resizable()
                            .frame(width: Consts.Home.buttonWidth, height: Consts.Home.buttonHeight)
                            .padding(Consts.Home.imagePadding)
                    }
                    .padding(.trailing, Consts.Home.pagePadding)
                }
            }
        }
        .background(Color.from(.appBackground))
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
    
    func emptyTabView(selected: Bool) -> some View {
        Text(String.newTab)
            .cornerRadius(Consts.Home.buttonHeight/2)
            .frame(width: Consts.Home.buttonWidth, height: Consts.Home.buttonHeight)
            .overlay(
                RoundedRectangle(cornerRadius: Consts.Home.buttonHeight)
                    .stroke(Color.from(.progressView), lineWidth: selected ? Consts.Home.border : 0)
            )
            .background(Color.from(.navButton))
            .foregroundColor(Color.from(.textColor))
            .cornerRadius(Consts.Home.buttonWidth/2)
    }
}

struct BrowserView_Previews: PreviewProvider {
    static var previews: some View {
        BrowserView()
    }
}
