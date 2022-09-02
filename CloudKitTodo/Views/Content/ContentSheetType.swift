//
//  ContentSheetType.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 01/09/22.
//

import SwiftUI

enum ContentSheetType: Identifiable, Equatable {
    case newListSheet(CDList?)
    case settingsSheet
    
    var id: Int {
        switch self {
        case .newListSheet(let list):
            return list != nil ? 0 : 1
        case .settingsSheet:
            return 2
        }
    }
}
