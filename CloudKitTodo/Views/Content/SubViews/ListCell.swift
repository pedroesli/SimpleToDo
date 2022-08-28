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
            Label {
                Text(list.title ?? "")
                    .font(.system(.body, design: .rounded))
                    .foregroundColor(.projectColors.textColors.textColor)
            } icon: {
                labelIcon(list: list)
            }
            Spacer()
            Text(String(list.uncompletedTaskCount))
                .font(.system(.footnote, design: .rounded))
                .foregroundColor(.projectColors.textColors.taskCountColor)
                .background {
                    RoundedRectangle(cornerRadius: 9, style: .continuous)
                        .padding(EdgeInsets(top: -5, leading: -7, bottom: -5, trailing: -7))
                        .foregroundColor(Color("CountBackgroundColor"))
                }
        }
        .padding(.vertical, 10)
//        .listRowBackground(Color.clear)
//        .listRowSeparator(.hidden)
    }
    
    @ViewBuilder func labelIcon(list: CDList) -> some View {
        if let icon = list.icon {
            Group {
                if icon.isEmoji {
                    Text(icon.name ?? "")
                }
                else {
                    Image(systemName: icon.name ?? "")
                }
            }
            .font(.body.bold())
            .foregroundColor(Color(icon.colorName ?? ""))
        }
        else {
            Image(systemName: "square.fill")
                .font(.body.bold())
                .foregroundColor(.gray)
        }
    }
}

struct ListCell_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ListCell(list: PersistenceController.preview.fetchLists()[0])
            ListCell(list: PersistenceController.preview.fetchLists()[1])
        }
    }
}
