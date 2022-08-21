//
//  AllCell.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 29/07/22.
//

import SwiftUI

struct AllCell: View {
    
    @Binding var uncompletedTaskCount: Int
    
    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: "square.fill")
                .font(.body.bold())
                .foregroundColor(Color("ListIconColorAll"))
            Text("All")
                .font(.system(.title3, design: .rounded))
                .foregroundColor(.projectColors.textColors.textColor)
                .padding(.leading, 16)
            Spacer()
            Text(String(uncompletedTaskCount))
                .foregroundColor(.projectColors.textColors.taskCountColor)
                .background {
                    RoundedRectangle(cornerRadius: 9, style: .continuous)
                        .padding(EdgeInsets(top: -5, leading: -7, bottom: -5, trailing: -7))
                        .foregroundColor(Color("CountBackgroundColor"))
                }
        }
        .padding(.vertical, 15)
        .listRowBackground(Color.clear)
    }
}

struct AllCell_Previews: PreviewProvider {
    static var previews: some View {
        List {
            AllCell(uncompletedTaskCount: .constant(13))
        }
    }
}
