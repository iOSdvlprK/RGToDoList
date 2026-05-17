//
//  UIScreen+Ext.swift
//  RGToDoList
//
//  Created by joe on 5/17/26.
//

import UIKit

extension UIScreen {
    static var current: UIScreen? {
        UIApplication.shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first?.windowScene?.screen
    }
}

