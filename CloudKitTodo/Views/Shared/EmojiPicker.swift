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
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        let emojiTextField = UIEmojiTextField()
        emojiTextField.keyboardType = .default
        emojiTextField.isHidden = true
        emojiTextField.delegate = context.coordinator
        context.coordinator.textfield = emojiTextField
        
        view.addSubview(emojiTextField)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        if showKeyboard {
            context.coordinator.textfield?.becomeFirstResponder()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: EmojiPicker
        var textfield: UIEmojiTextField?
        
        init(parent: EmojiPicker) {
            self.parent = parent
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            DispatchQueue.main.async { [weak self] in
                self?.parent.emoji = textField.text ?? ""
                textField.resignFirstResponder()
                self?.parent.showKeyboard = false
            }
        }
    }
}
