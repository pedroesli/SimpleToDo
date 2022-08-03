//
//  NewListView.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 29/07/22.
//

import SwiftUI

struct NewListView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @State private var iconName = "square"
    @State private var iconColor: ListIconColor = Color.projectColors.listIconColors[4]
    
    
    var body: some View {
        NavigationView {
            List {
                TitleAndIconSection(
                    title: $title,
                    iconName: $iconName,
                    iconColor: $iconColor
                )
                ColorSelectSection(iconColor: $iconColor)
                //TODO: Create the icon selection view
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("New List")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: dismiss.callAsFunction) {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Text("OK")
                            .font(.body.bold())
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
        
    }
    
    private struct TitleAndIconSection: View {
        
        @Binding var title: String
        @Binding var iconName: String
        @Binding var iconColor: ListIconColor
        
        var body: some View {
            Section {
                VStack(spacing: 15) {
                    Image(systemName: iconName)
                        .resizable()
                        .aspectRatio(1/1, contentMode: .fit)
                        .font(.body.bold())
                        .frame(width: 75)
                        .foregroundColor(iconColor.color)
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
    }
    
    private struct ColorSelectSection: View {
        
        @Binding var iconColor: ListIconColor
        private let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        
        var body: some View {
            Section {
                LazyVGrid(columns: columns, alignment: .center) {
                    ForEach(Color.projectColors.listIconColors, id: \.name) { listColor in
                        ZStack {
                            Button {
                                self.iconColor = listColor
                            } label: {
                                RoundedRectangle(cornerRadius: 9, style: .continuous)
                                    .foregroundColor(listColor.color)
                                    .aspectRatio(1/1, contentMode: .fill)
                            }
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.vertical, 15)
            }
        }
    }
}

struct NewListView_Previews: PreviewProvider {
    static var previews: some View {
        NewListView()
            
    }
}

// For toolbar options
//    .toolbar {
//        ToolbarItem(placement: .navigationBarLeading) {
//            Text("New List")
//                .font(.system(size: 24))
//                .foregroundColor(.accentColor)
//        }
//        ToolbarItem(placement: .navigationBarTrailing) {
//            Button(action: dismiss.callAsFunction) {
//                Image(systemName: "xmark.square.fill")
//                    .symbolRenderingMode(.palette)
//                    .foregroundStyle(.gray, .quaternary)
//                    .font(.system(size: 24))
//            }
//        }
//    }
