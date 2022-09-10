//
//  ColorSelectSection.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 04/08/22.
//

import SwiftUI

struct ColorSelectSection: View {
    
    @Binding var iconColor: ListIconColor
    private let columns = [
        GridItem(.flexible(), spacing: 17),
        GridItem(.flexible(), spacing: 17),
        GridItem(.flexible(), spacing: 17),
        GridItem(.flexible(), spacing: 17),
        GridItem(.flexible(), spacing: 17),
        GridItem(.flexible(), spacing: 17)
    ]
    
    var body: some View {
        Section {
            LazyVGrid(columns: columns, alignment: .center, spacing: 17) {
                ForEach(Color.projectColors.listIconColors, id: \.name) { listColor in
                    ZStack {
                        Button {
                            self.iconColor = listColor
                        } label: {
                            Circle()
                                .foregroundColor(listColor.color)
                                .aspectRatio(1/1, contentMode: .fill)
                                .overlay {
                                    if self.iconColor.name == listColor.name {
                                        Circle()
                                            .stroke(Color(uiColor: .systemGray2), lineWidth: 3)
                                            .padding(-5)
                                    }
                                }
                        }
                    }
                }
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.vertical, 17)
        }
    }
}

//struct ColorSelectSection_Previews: PreviewProvider {
//    static var previews: some View {
//        ColorSelectSection()
//    }
//}
