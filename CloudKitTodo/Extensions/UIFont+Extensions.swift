//
//  UIFont+Extensions.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 10/08/22.
//

import UIKit

extension UIFont {
    
    static var roundedTitle2: UIFont {
        var titleFont = UIFont.preferredFont(forTextStyle: .title2)
        titleFont = UIFont(
            descriptor:
                titleFont.fontDescriptor
                .withDesign(.rounded)?
                .withSymbolicTraits(.traitBold)
                ??
                titleFont.fontDescriptor,
            size: 0
        )
        return titleFont
    }
    
    static var roundedLargeTitle: UIFont {
        var titleFont = UIFont.preferredFont(forTextStyle: .largeTitle)
        titleFont = UIFont(
            descriptor:
                titleFont.fontDescriptor
                .withDesign(.rounded)?
                .withSymbolicTraits(.traitBold)
                ??
                titleFont.fontDescriptor,
            size: 0
        )
        return titleFont
    }
    
    static var roundedTitle: UIFont {
        var titleFont = UIFont.preferredFont(forTextStyle: .headline)
        titleFont = UIFont(
            descriptor:
                titleFont.fontDescriptor
                .withDesign(.rounded)
                ??
                titleFont.fontDescriptor,
            size: 0
        )
        return titleFont
    }
    
    static func roundedFont(forTextStyle style: UIFont.TextStyle) -> UIFont {
        var titleFont = UIFont.preferredFont(forTextStyle: style)
        titleFont = UIFont(
            descriptor:
                titleFont.fontDescriptor
                .withDesign(.rounded)
                ??
                titleFont.fontDescriptor,
            size: 0
        )
        return titleFont
    }
}
