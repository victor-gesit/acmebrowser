//
//  BrowserTabModel.swift
//  acmebrowser
//
//  Created by Victor Idongesit on 11/04/2022.
//

import Foundation
import WebKit
import Combine

class BrowserTabModel: NSObject, ObservableObject {
    @Published var urlString = ""
    @Published var canGoBack = false
    @Published var canGoForward = false
    @Published var canReload = false
    @Published var isLoading = false
    @Published var estimatedProgress: Double = 0
    @Published var errorOcured = false
    @Published var completed = true
    @Published var faviconURL: URL?
    
    private var cancellables: [AnyCancellable] = []
    private var estimatedProgressObserver: NSKeyValueObservation?
    private var canGoBackObserver: NSKeyValueObservation?
    private var canGoForwardObserver: NSKeyValueObservation?
    let tabIndex: Int
    
    let browserWebView: BrowserWebView
    let id = UUID()
    
    init(tabIndex: Int) {
        self.tabIndex = tabIndex
        let wkWebView = WKWebView(frame: .zero)
        browserWebView = BrowserWebView(webView: wkWebView)
        super.init()
        browserWebView.webView.navigationDelegate = self
        loadUrl()
        setupObservers()
    }
    
    private func setupObservers() {
        estimatedProgressObserver = browserWebView.webView.observe(\.estimatedProgress, options: [.new]) { [weak self] webView, prog in
            self?.estimatedProgress = prog.newValue ?? 0
        }
        
        canGoBackObserver = browserWebView.webView.observe(\.canGoBack, options: [.new]) { [weak self] webView, canGBack in
            self?.canGoBack = canGBack.newValue ?? false
        }
        
        canGoForwardObserver = browserWebView.webView.observe(\.canGoForward, options: [.new]) { [weak self] webView, canGForward in
            self?.canGoForward = canGForward.newValue ?? false
        }
    }
    
    func loadUrl() {
        errorOcured = false
        if urlString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { return }
        if let secureUrlString = urlString.secureURLString,
           urlString.isValidURL,
           let url = URL(string: secureUrlString)
        {
            let request = URLRequest(url: url)
            completed = false
            browserWebView.webView.load(request)
            faviconURL = url.faviconUrlString
        } else {
            searchGoogle(with: urlString)
        }
    }
    
    func reloadPage() {
        browserWebView.webView.reload()
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

    func goBack() {
        browserWebView.webView.goBack()
    }
    
    func goForward() {
        browserWebView.webView.goForward()
    }
}

extension BrowserTabModel: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        urlString = webView.url?.absoluteString ?? ""
        completed = true
        canReload = true
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        errorOcured = true
    }

}
