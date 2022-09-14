//
//  ToDoTextField.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 11/09/22.
//

import SwiftUI

struct ToDoTextField: View {
    
    @Binding var text: String
    @Binding var isStrikethrough: Bool
    let onEditingChanged: (Bool) -> Void
    @StateObject private var manager = ToDoTextFieldManager()
    @State private var configured = false
    
    private var textColor: Color {
        isStrikethrough ? Color(uiColor: .systemGray) : Color.projectColors.textColors.textColor
    }
    
    var body: some View {
        TextEditor(text: $text)
            .introspectTextView { textView in
                if !configured {
                    manager.configure(textView: textView, isStrikethrough: isStrikethrough)
                    configured = true
                }
            }
            .foregroundColor(textColor)
            .frame(height: manager.height)
            .onChange(of: manager.userIsEditing, perform: onEditingChanged)
            .onAppear {
                manager.text = text
            }
            .onChange(of: manager.text) { newValue in
                text = newValue
            }
            .onChange(of: isStrikethrough) { newValue in
                manager.strikethrough(isActive: newValue)
                manager.updateHeight()
            }
    }
}

struct ToDoTextField_Previews: PreviewProvider {
    static var previews: some View {
        ToDoTextField(text: .constant("Hello"), isStrikethrough: .constant(true), onEditingChanged: { _ in
            
        })
    }
}
