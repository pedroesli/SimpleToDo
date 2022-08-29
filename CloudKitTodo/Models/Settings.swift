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
        case preferredColorScheme
        case iCloudSync
    }
    
    var preferredColorScheme: ColorScheme?
    var iCloudSyncOn: Bool = true
    
    init() {
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let interfaceStyleRawValue = try values.decode(Int.self, forKey: .preferredColorScheme)
        
        preferredColorScheme = ColorScheme(UIUserInterfaceStyle(rawValue: interfaceStyleRawValue)!)
        iCloudSyncOn = try values.decode(Bool.self, forKey: .iCloudSync)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let userInterfaceStyle = UIUserInterfaceStyle(preferredColorScheme)
        
        try container.encode(userInterfaceStyle.rawValue, forKey: .preferredColorScheme)
        try container.encode(iCloudSyncOn, forKey: .iCloudSync)
    }
}
