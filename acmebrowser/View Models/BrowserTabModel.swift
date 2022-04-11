//
//  BrowserTabModel.swift
//  acmebrowser
//
//  Created by Victor Idongesit on 11/04/2022.
//

import Foundation
import WebKit

class BrowserTabModel: ObservableObject {
    @Published var urlString = ""
    @Published var canGoBack = false
    @Published var canGoForward = false
    @Published var canReload = false
    @Published var isLoading = false

    
    let webView: WKWebView
    
    init() {
        webView = WKWebView(frame: .zero)
        loadUrl()
    }
    
    func loadUrl() {
        if urlString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { return }
        if var components = URLComponents(string: urlString){
            components.scheme = "https"
            if let url = components.url {
                let request = URLRequest(url: url)
                urlString = url.absoluteString
                webView.load(request)
            } else {
                searchGoogle(with: urlString)
            }
        } else {
            searchGoogle(with: urlString)
        }
    }
    
    private func searchGoogle(with query: String) {
        if let googleQuery = "https://www.google.com/search?q=\(query)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: googleQuery)
        {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    private func setupBindings() {
        webView.publisher(for: \.canGoBack)
            .assign(to: &$canGoBack)
        webView.publisher(for: \.canGoForward)
            .assign(to: &$canGoForward)
        webView.publisher(for: \.isLoading)
            .assign(to: &$isLoading)
    }
}
