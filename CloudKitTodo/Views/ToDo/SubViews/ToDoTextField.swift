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
    
    @State private var height: CGFloat = 22
    
    var body: some View {
        ToDoTextFieldRepresentable(text: $text, isStrikethrough: $isStrikethrough, height: $height, onEditingChanged: onEditingChanged)
            .frame(height: height)
            .padding(.top, 5)
    }
    
    struct ToDoTextFieldRepresentable: UIViewRepresentable {

        @Binding var text: String
        @Binding var isStrikethrough: Bool
        @Binding var height: CGFloat
        let onEditingChanged: (Bool) -> Void
        
        @State private var textView: UITextView?
        
        func makeUIView(context: Context) -> UITextView {
            let textView = UITextView()
            textView.backgroundColor = .clear
            textView.font = UIFont.roundedFont(forTextStyle: .body)
            textView.textColor = UIColor.label
            textView.textContainerInset = .zero
            strikethrough(isActive: isStrikethrough, for: textView)
            textView.delegate = context.coordinator
            self.textView = textView
            return textView
        }
        
        func updateUIView(_ textView: UITextView, context: Context) {
            strikethrough(isActive: isStrikethrough, for: textView)
        }
        
        func makeCoordinator() -> Coordinator {
            Coordinator(parent: self)
        }
        
        func strikethrough(isActive: Bool, for textView: UITextView) {
            if isActive {
                let attributedString = NSAttributedString(
                    string: text,
                    attributes: [
                        .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                        .font: UIFont.roundedFont(forTextStyle: .body),
                        .foregroundColor: UIColor.systemGray
                    ]
                )

                textView.attributedText = attributedString
                textView.isUserInteractionEnabled = false
            }
            else {
                let attributedString = NSAttributedString(
                    string: text,
                    attributes: [
                        .font: UIFont.roundedFont(forTextStyle: .body),
                        .foregroundColor: UIColor.label
                    ]
                )
                
                textView.attributedText = attributedString
                textView.isUserInteractionEnabled = true
            }
        }
        
        
        class Coordinator: NSObject, UITextViewDelegate {
            var parent: ToDoTextFieldRepresentable
            
            init(parent: ToDoTextFieldRepresentable) {
                self.parent = parent
            }
            
            func textViewDidBeginEditing(_ textView: UITextView) {
                parent.onEditingChanged(true)
            }
            
            func textViewDidEndEditing(_ textView: UITextView) {
                parent.onEditingChanged(false)
            }
            
            func textViewDidChange(_ textView: UITextView) {
                parent.text = textView.text ?? ""
                parent.height = textView.contentSize.height
            }
        }
    }

}

struct ToDoTextField_Previews: PreviewProvider {
    static var previews: some View {
        ToDoTextField(text: .constant("Hello"), isStrikethrough: .constant(true), onEditingChanged: { _ in
            
        })
    }
}
