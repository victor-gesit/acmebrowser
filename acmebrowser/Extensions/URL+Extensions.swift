//
//  URL+Extensions.swift
//  acmebrowser
//
//  Created by Victor Idongesit on 12/04/2022.
//

import Foundation

extension URL {
    var faviconUrlString: URL? {
        if var components = URLComponents(url: self, resolvingAgainstBaseURL: false){
            components.scheme = "https"
            if let url = components.url {
                let faviconString = url.absoluteString + "/favicon.ico"
                return URL(string: faviconString)
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    var searchFaviconUrlString: URL? {
        return URL(string: "https://www.google.com/favicon.ico")
    }
    
    var secureURLString: String? {
        if var components = URLComponents(string: self.absoluteString){
            components.scheme = "https"
            return components.url?.absoluteString
        } else {
            return nil
        }
    }
}
