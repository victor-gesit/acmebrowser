//
//  BrowserWebView.swift
//  acmebrowser
//
//  Created by Victor Idongesit on 11/04/2022.
//

import SwiftUI
import WebKit

struct BrowserWebView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    let webView: WKWebView
    func makeUIView(context: Context) -> WKWebView {
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
