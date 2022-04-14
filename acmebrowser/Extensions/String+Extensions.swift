//
//  String+Extensions.swift
//  acmebrowser
//
//  Created by Victor Idongesit on 13/04/2022.
//

import UIKit

extension String {
    static let enterUrl = "Enter url"
    static let newTab = "N"
    static let errorOccured = "Error Occured. Check the URL"
    static let newTabString = "New Tab"
    var secureURLString: String? {
        if var components = URLComponents(string: self){
            components.scheme = "https"
            return components.url?.absoluteString
        } else {
            return nil
        }
    }
    
    var googleQueryString: String? {
        return "https://www.google.com/search?q=\(self)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
}
