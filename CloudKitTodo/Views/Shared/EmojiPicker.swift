//
//  EmojiPicker.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 03/08/22.
//

import SwiftUI

class UIEmojiTextField: UITextField {
    
    override var textInputContextIdentifier: String? {
           return ""
    }
    
    override var textInputMode: UITextInputMode? {
        for mode in UITextInputMode.activeInputModes {
            if mode.primaryLanguage == "emoji" {
                self.keyboardType = .default // do not remove this
                return mode
            }
        }
        return nil
    }
}

struct EmojiPicker: UIViewRepresentable {
    @Binding var emoji: String
    @Binding var showKeyboard: Bool
    @Binding var isEmoji: Bool
    var completionHandler: (String) -> Void
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        let emojiTextField = UIEmojiTextField()
        emojiTextField.keyboardType = .default
        emojiTextField.isHidden = true
        emojiTextField.delegate = context.coordinator
        context.coordinator.emojiTextField = emojiTextField
        
        view.addSubview(emojiTextField)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        if showKeyboard {
            DispatchQueue.main.async {
                context.coordinator.emojiTextField?.becomeFirstResponder()
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: EmojiPicker
        var emojiTextField: UIEmojiTextField?
        
        init(parent: EmojiPicker) {
            self.parent = parent
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            DispatchQueue.main.async { [weak self] in
                self?.parent.showKeyboard = false
                if let text = textField.text, text.containsOnlyEmoji {
                    self?.parent.emoji = text
                    self?.parent.isEmoji = true
                    textField.text = ""
                    self?.parent.completionHandler(text)
                }
                textField.resignFirstResponder()
            }
        }
    }
}
