//
//  UserDefault+Extensions.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 29/08/22.
//

import Foundation

extension UserDefaults {
    
    /// Returns true if item exists in storaged, otherwise will return false
    func itemExists(forKey key: String) -> Bool {
        return self.object(forKey: key) != nil
    }
}
