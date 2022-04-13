//
//  BrowserTabModel.swift
//  acmebrowser
//
//  Created by Victor Idongesit on 11/04/2022.
//

import Foundation
import WebKit

class BrowserTabModel: ObservableObject {
    @Published var urlString = "Victor Idongesit GitHub"
    @Published var canGoBack = false
    @Published var canGoForward = false
    @Published var canReload = false
    @Published var isLoading = false
    @Published var faviconURL: URL?
    let tabIndex: Int
    
    let browserWebView: BrowserWebView
    let id = UUID()
    
    init(tabIndex: Int) {
        self.tabIndex = tabIndex
        let wkWebView = WKWebView(frame: .zero)
        browserWebView = BrowserWebView(webView: wkWebView)
        loadUrl()
    }
    
    func loadUrl() {
        if urlString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { return }
        if let secureUrlString = urlString.secureURLString,
           urlString.isValidURL,
           let url = URL(string: secureUrlString)
        {
            let request = URLRequest(url: url)
            browserWebView.webView.load(request)
            faviconURL = url.faviconUrlString
        } else {
            searchGoogle(with: urlString)
        }
    }
    
    private func searchGoogle(with query: String) {
        if let googleQuery = query.googleQueryString,
           let url = URL(string: googleQuery)
        {
            faviconURL = url.searchFaviconUrlString
            let request = URLRequest(url: url)
            browserWebView.webView.load(request)
        }
    }
    
    private func setupBindings() {
        browserWebView.webView.publisher(for: \.canGoBack)
            .assign(to: &$canGoBack)
        browserWebView.webView.publisher(for: \.canGoForward)
            .assign(to: &$canGoForward)
        browserWebView.webView.publisher(for: \.isLoading)
            .assign(to: &$isLoading)
    }
    
    func goBack() {
        browserWebView.webView.goBack()
    }
    
    func goForward() {
        browserWebView.webView.goForward()
    }
}
