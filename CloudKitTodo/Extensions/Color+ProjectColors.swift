//
//  Color+ProjectColors.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 28/07/22.
//

import SwiftUI


struct ProjectColors {
    let listIconColors = ListIconColor.colors
    let textColors = TextColors()
    let newListColors = NewListColors()
    let appBackgroundColor = Color("AppBackgroundColor")
}

struct ListIconColor {
    let name: String
    var color: Color {
        return Color(name)
    }
    
    static var colors: [ListIconColor] {
        return [
            ListIconColor(name: "ListIconColor1"),
            ListIconColor(name: "ListIconColor2"),
            ListIconColor(name: "ListIconColor3"),
            ListIconColor(name: "ListIconColor4"),
            ListIconColor(name: "ListIconColor5"),
            ListIconColor(name: "ListIconColor6"),
            ListIconColor(name: "ListIconColor7"),
            ListIconColor(name: "ListIconColor8"),
            ListIconColor(name: "ListIconColor9"),
            ListIconColor(name: "ListIconColor10"),
            ListIconColor(name: "ListIconColor11"),
            ListIconColor(name: "ListIconColor12"),
        ]
    }
}

struct TextColors {
    var textColor: Color {
        Color("TextColor")
    }
    var textHighlitedColor: Color {
        Color("TextHighlitedColor")
    }
    var taskCountColor: Color {
        Color("TaskCountColor")
    }
}

struct NewListColors {
    var newListBackgroundColor: Color {
        Color("NewListBackgroundColor")
    }
    
    var newListIconColor: Color {
        Color("NewListIconColor")
    }
}

extension Color {
    static let projectColors = ProjectColors()
}
