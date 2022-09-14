//
//  ToDoTextFieldManager.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 11/09/22.
//

import SwiftUI

class ToDoTextFieldManager: NSObject, UITextViewDelegate, ObservableObject {
    @Published var userIsEditing = false
    @Published var height: CGFloat = 100
    @Published var text: String = ""
    var textView: UITextView?
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        userIsEditing = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        userIsEditing = false
    }
    
    func textViewDidChange(_ textView: UITextView) {
        height = textView.contentSize.height
        text = textView.text
    }
    
    func configure(textView: UITextView, isStrikethrough: Bool) {
        textView.backgroundColor = .clear
        textView.textContainerInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        textView.textContainer.lineFragmentPadding = 0
        textView.isScrollEnabled = true
        textView.delegate = self
        self.textView = textView
        strikethrough(isActive: isStrikethrough)
        
        height = textView.contentSize.height
    }
    
    func strikethrough(isActive: Bool) {
        guard let textView = textView else { return }
        if isActive {
            let attributedString = NSAttributedString(
                string: text,
                attributes: [
                    .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                    .font: UIFont.roundedFont(forTextStyle: .body)
                ]
            )

            textView.isUserInteractionEnabled = false
            textView.attributedText = attributedString
        }
        else {
            textView.text = text
            textView.isUserInteractionEnabled = true
        }
    }
    
    func updateHeight() {
        guard let textView = textView else { return }
        height = textView.contentSize.height
    }
}
