//
//  ListCell.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 28/07/22.
//

import SwiftUI

struct ListCell: View {
    
    let iconName: String
    let title: String
    let taskCountText: String
    
    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: "square")
                .font(.body.bold())
            Text("All")
                .font(.system(.title3, design: .rounded))
                .foregroundColor(.projectColors.textColors.textColor)
                .padding(.leading, 16)
            Spacer()
            Text("12")
                .foregroundColor(.projectColors.textColors.taskCountColor)
                .background {
                    RoundedRectangle(cornerRadius: 9, style: .continuous)
                        .padding(EdgeInsets(top: -5, leading: -7, bottom: -5, trailing: -7))
                        .foregroundColor(Color("CountBackgroundColor"))
                }
        }
        .listRowBackground(Color.clear)
    }
}

struct ListCell_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ListCell(iconName: "square", title: "square", taskCountText: "12")
        }
    }
}
