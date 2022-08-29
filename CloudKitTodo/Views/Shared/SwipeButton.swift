//
//  CellDeleteButton.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 29/08/22.
//

import SwiftUI

struct SwipeButton: View {
    
    enum ButtonType {
        case Delete
        case Edit
    }
    
    let buttonType: ButtonType
    let action: () -> Void
    
    var body: some View {
        if buttonType == .Delete {
            DeleteButton(action: action)
        }
        else {
            EditButton(action: action)
        }
    }
    
    private struct DeleteButton: View {
        let action: () -> Void
        
        var body: some View {
            Button(role: .destructive, action: action) {
                Label("Delete", systemImage: "trash.fill")
            }
        }
    }
    
    private struct EditButton: View {
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                Label("Edit", systemImage: "pencil")
            }
            .tint(.cyan)
        }
    }
}

struct CellDeleteButton_Previews: PreviewProvider {
    static var previews: some View {
        SwipeButton(buttonType: .Delete, action: {})
    }
}
