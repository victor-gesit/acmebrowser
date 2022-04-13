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
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack(spacing: 10) {
                    HStack {
                        TextField("Enter url",
                                  text: $allModel.currentTab.urlString)
                            .keyboardType(.URL)
                            .autocapitalization(.none)
                            .padding(10)
                        Spacer()
                    }
                    .background(Color.white)
                    .cornerRadius(30)
                    
                    Button("Go", action: {
                        allModel.currentTab.loadUrl()
                    })
                    .foregroundColor(.white)
                    .padding(10)
                    
                    Button("+", action: {
                        allModel.addTab()
                    })
                    .foregroundColor(.white)
                    .padding(10)
                    Button("<", action: {
                        allModel.currentTab.goBack()
                    })
                    .foregroundColor(.white)
                    .padding(10)
                    Button(">", action: {
                        allModel.currentTab.goForward()
                    })
                    .foregroundColor(.white)
                    .padding(10)
                    
                }.padding(10)
                ZStack {
                    ForEach([allModel.currentTab], id: \.id) { tab in
                        if tab.id == allModel.currentTab.id {
                            tab.browserWebView
                        }
                    }
                }
                    .background(.blue)
                HStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(allModel.allTabs, id: \.id) { tab in
                                VStack {
                                    if let url = faviconForPage[tab.id] {
                                        AsyncImage(url: url) { image in
                                            image
                                                .resizable()
                                                .frame(width: 40, height: 40)
                                                .foregroundColor(.white)
                                                .onTapGesture {
                                                    allModel.switchTab(to: tab.id)
                                                }
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        
                                        
                                    }
                                    else {
                                        Text("N")
                                            .cornerRadius(10)
                                            .frame(width: 20, height: 20)
                                            .background(.white)
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
                    .frame(height: 50)
                    
                    Spacer()
                    Button("+", action: {
                        allModel.addTab()
                    })
                    .foregroundColor(.white)
                    .frame(width: 20, height: 20)
                    .padding()
                }
                
            }
        }
    }
}

struct BrowserView_Previews: PreviewProvider {
    static var previews: some View {
        BrowserView()
    }
}
