//
//  CheckButton.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 11/09/22.
//

import SwiftUI

struct CheckButton: View {
    
    @Binding var isChecked: Bool
    let checkColor: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
            withAnimation {
                isChecked.toggle()
            }
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 9, style: .continuous)
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color(uiColor: .systemGroupedBackground))
                if isChecked {
                    Image(systemName: "checkmark")
                        .font(.body.weight(.heavy))
                        .foregroundColor(checkColor)
                }
            }
        }
    }
}


struct CheckButton_Previews: PreviewProvider {
    static var previews: some View {
        CheckButton(isChecked: .constant(true), checkColor: Color.green, action: {})
    }
}
