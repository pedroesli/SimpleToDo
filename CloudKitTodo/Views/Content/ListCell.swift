//
//  ListCell.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 28/07/22.
//

import SwiftUI

struct ListCell: View {
    
    let list: CDList
    
    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: list.icon?.name ?? "")
                .font(.body.bold())
                .foregroundColor(Color(list.icon?.colorName ?? ""))
            Text(list.title ?? "")
                .font(.system(.title3, design: .rounded))
                .foregroundColor(.projectColors.textColors.textColor)
                .padding(.leading, 16)
            Spacer()
            Text(String(list.uncompletedTaskCount))
                .foregroundColor(.projectColors.textColors.taskCountColor)
                .background {
                    RoundedRectangle(cornerRadius: 9, style: .continuous)
                        .padding(EdgeInsets(top: -5, leading: -7, bottom: -5, trailing: -7))
                        .foregroundColor(Color("CountBackgroundColor"))
                }
        }
        .padding(.bottom, 30)
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
}

struct ListCell_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ListCell(list: PersistenceController.preview.fetchLists().first!)
        }
    }
}
