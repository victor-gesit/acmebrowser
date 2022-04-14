//
//  UIKit+Extensions.swift
//  acmebrowser
//
//  Created by Victor Idongesit on 13/04/2022.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
