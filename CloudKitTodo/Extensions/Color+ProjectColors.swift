//
//  Color+ProjectColors.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 28/07/22.
//

import SwiftUI


struct ProjectColors {
    let listColors = ListColors()
    let textColors = TextColors()
}

struct ListColors {
    let colorNames = [
        "ListColor1",
        "ListColor2",
        "ListColor3",
        "ListColor4",
        "ListColor5",
        "ListColor6",
        "ListColor7",
        "ListColor8",
        "ListColor9",
        "ListColor10",
        "ListColor11",
        "ListColor12",
    ]
    var colors: [Color] {
        get {
            return colorNames.map{ Color($0) }
        }
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

extension Color {
    static let projectColors = ProjectColors()
}
