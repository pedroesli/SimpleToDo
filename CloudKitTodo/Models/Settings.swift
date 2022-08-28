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
        case icloudSync
    }
    
    var preferredColorScheme: ColorScheme?
    var isicloudSyncOn: Bool = true {
        didSet {
            isicloudSyncOnChanged?(isicloudSyncOn)
        }
    }
    
    var isicloudSyncOnChanged: ((Bool) -> Void)?
    
    init() {
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let interfaceStyleRawValue = try values.decode(Int.self, forKey: .preferredColorScheme)
        
        preferredColorScheme = ColorScheme(UIUserInterfaceStyle(rawValue: interfaceStyleRawValue)!)
        isicloudSyncOn = try values.decode(Bool.self, forKey: .icloudSync)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let userInterfaceStyle = UIUserInterfaceStyle(preferredColorScheme)
        
        try container.encode(userInterfaceStyle.rawValue, forKey: .preferredColorScheme)
        try container.encode(isicloudSyncOn, forKey: .icloudSync)
    }
}
