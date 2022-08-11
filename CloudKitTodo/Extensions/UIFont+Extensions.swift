//
//  UIFont+Extensions.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 10/08/22.
//

import UIKit

extension UIFont {
    static func boldTitle2() -> UIFont {
        let size = UIFont.preferredFont(forTextStyle: .title2).pointSize
        if let descriptor = UIFont.systemFont(ofSize: size, weight: .bold).fontDescriptor.withDesign(.rounded) {
            return UIFont(descriptor: descriptor, size: size)
        }
        return UIFont.systemFont(ofSize: size, weight: .bold)
    }
}
