//
//  TitleAndIconSection.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 04/08/22.
//

import SwiftUI

struct TitleAndIconSection: View {
    
    @Binding var title: String
    @Binding var iconName: String
    @Binding var iconColor: ListIconColor
    @Binding var isEmoji: Bool
    
    var body: some View {
        Section {
            VStack(spacing: 20) {
                makeIconPreview(iconName, isEmoji)
                //MARK: Replace with UIKit textfield in a future update
                TextField("", text: $title,prompt: Text("List Title"))
                    .foregroundColor(iconColor.color)
                    .font(.system(.title2, design: .rounded).bold())
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .foregroundColor(Color(uiColor: .systemGray6))
                    }
            }
            .padding(.vertical, 15)
        }
    }
    
    @ViewBuilder func makeIconPreview(_ iconName: String,_ isEmoji: Bool) -> some View {
        Group {
            if isEmoji {
                Text(iconName)
            }
            else {
                Text("\(Image(systemName: iconName))")
            }
        }
        .font(.system(size: 96, weight: .bold, design: .rounded))
        .foregroundColor(iconColor.color)
        .frame(height: 120)
    }
}

//struct TitleAndIconSection_Previews: PreviewProvider {
//    static var previews: some View {
//        TitleAndIconSection()
//    }
//}
