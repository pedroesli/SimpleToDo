//
//  ListCell.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 28/07/22.
//

import SwiftUI

struct ListCellView: View {
    
    let list: CDList
    @State private var isActive = false
    
    var body: some View {
        ZStack{
            NavigationLink(isActive: $isActive) {
                if isActive {
                    ToDoView(list: list)
                }
            } label: {
                EmptyView()
            }
            .hidden()
            Button {
                isActive = true
            } label: {
                HStack(spacing: 0) {
                    Label {
                        Text(list.title)
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
                .padding(.trailing, 5)
            }
            .padding(.vertical, 10)
        }
        .listRowSeparator(.hidden)
    }
    
    @ViewBuilder func labelIcon(list: CDList) -> some View {
        if let icon = list.icon {
            Group {
                if icon.isEmoji {
                    Text(icon.name)
                }
                else {
                    Image(systemName: icon.name)
                }
            }
            .font(.body.bold())
            .foregroundColor(Color(icon.colorName))
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
            ListCellView(list: PersistenceController.preview.fetchLists()[0])
            ListCellView(list: PersistenceController.preview.fetchLists()[1])
        }
    }
}
