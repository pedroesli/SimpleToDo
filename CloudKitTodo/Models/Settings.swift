//
//  Settings.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 16/08/22.
//

import SwiftUI
import Combine

struct Settings: Codable {
    
    enum CodingKeys: String, CodingKey {
        case colorScheme
        case icloudSync
    }
    
    var colorScheme: ColorScheme?
    var isicloudSyncOn: Bool = true
    
    init() {
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let interfaceStyleRawValue = try values.decode(Int.self, forKey: .colorScheme)
        
        colorScheme = ColorScheme(UIUserInterfaceStyle(rawValue: interfaceStyleRawValue)!)
        isicloudSyncOn = try values.decode(Bool.self, forKey: .icloudSync)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let userInterfaceStyle = UIUserInterfaceStyle(colorScheme)
        
        try container.encode(userInterfaceStyle.rawValue, forKey: .colorScheme)
        try container.encode(isicloudSyncOn, forKey: .icloudSync)
    }
}
