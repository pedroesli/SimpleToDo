//
//  NewListTextField.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 10/08/22.
//

import SwiftUI

struct NewListTextField: UIViewRepresentable {
    @Binding var text: String
    @Binding var iconColor: ListIconColor
    let placeHolder: String
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.font = UIFont.roundedTitle2
        textField.text = text
        textField.placeholder = placeHolder
        textField.clearButtonMode = .whileEditing
        textField.textAlignment = .center
        textField.returnKeyType = .done
        textField.textColor = UIColor(named: iconColor.name)
        
        //Events
        textField.addTarget(context.coordinator, action: #selector(context.coordinator.textChanged(_:)), for: .editingChanged)
        textField.addTarget(context.coordinator, action: #selector(context.coordinator.primaryActionTriggered(_:)), for: .primaryActionTriggered)
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.textColor = UIColor(named: iconColor.name)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject {
        var parent: NewListTextField
        
        init(parent: NewListTextField) {
            self.parent = parent
        }
        
        @objc func textChanged(_ sender: UITextField) {
            DispatchQueue.main.async {
                self.parent.text = sender.text ?? ""
            }
        }
        
        @objc func primaryActionTriggered(_ sender: UITextField) {
            sender.resignFirstResponder()
        }
    }
}


struct NewListTextField_Previews: PreviewProvider {
    static var previews: some View {
        List {
            NewListTextField(
                text: .constant(""),
                iconColor: .constant(ListIconColor.colors.first!),
                placeHolder: "List Title"
            )
            .frame(height: 60)
            .background {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .foregroundColor(Color("NewListBackgroundColor"))
            }
        }
    }
}
