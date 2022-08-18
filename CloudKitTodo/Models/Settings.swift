//
//  Settings.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 16/08/22.
//

import SwiftUI

struct Settings: Codable {
    var colorScheme: ColorScheme?
    
    enum CodingKeys: String, CodingKey {
        case colorScheme
    }
    
    init() {
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let interfaceStyleRawValue = try values.decode(Int.self, forKey: .colorScheme)
        
        colorScheme = ColorScheme(UIUserInterfaceStyle(rawValue: interfaceStyleRawValue)!)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let userInterfaceStyle = UIUserInterfaceStyle(colorScheme)
        
        try container.encode(userInterfaceStyle.rawValue, forKey: .colorScheme)
    }
}
