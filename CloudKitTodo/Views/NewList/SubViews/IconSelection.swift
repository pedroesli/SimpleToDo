//
//  IconSelection.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 04/08/22.
//

import SwiftUI

struct IconSelection: View {
    
    @Binding var iconName: String
    @Binding var isEmoji: Bool
    private let columns = [
        GridItem(.flexible(), spacing: 17),
        GridItem(.flexible(), spacing: 17),
        GridItem(.flexible(), spacing: 17),
        GridItem(.flexible(), spacing: 17),
        GridItem(.flexible(), spacing: 17),
        GridItem(.flexible(), spacing: 17)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, alignment: .center, spacing: 17) {
            ForEach(Icons.iconNames, id: \.self) { iconName in
                Button {
                    self.iconName = iconName
                    if isEmoji {
                        isEmoji = false
                    }
                } label: {
                    ZStack {
                        Circle()
                            .foregroundColor(.projectColors.newListColors.newListBackgroundColor)
                            .aspectRatio(1/1, contentMode: .fit)
                            .overlay {
                                if self.iconName == iconName {
                                    Circle()
                                        .stroke(Color(uiColor: .systemGray2), lineWidth: 3)
                                        .padding(-5)
                                }
                            }
                        Image(systemName: iconName)
                            .font(.system(.title3, design: .rounded))
                            .foregroundColor(.projectColors.newListColors.newListIconColor)
                    }
                }
            }
        }
        .padding(.bottom, 17)
    }
}

//struct IconSelection_Previews: PreviewProvider {
//    static var previews: some View {
//        IconSelection()
//    }
//}
