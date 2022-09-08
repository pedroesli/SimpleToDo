//
//  NavigationControllerDelegate.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 06/09/22.
//

import SwiftUI

class NavigationControllerDelegate: NSObject, UINavigationControllerDelegate, ObservableObject {
    
    var list: CDList?
    var currentViewController: UIViewController?
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        currentViewController = viewController
        //configureView()
    }
    
    private func configureView() {
        guard let navBar = currentViewController?.navigationController?.navigationBar else { return }
        
        if let list = list {
            let colorName = list.icon?.colorName ?? "AccentColor"
            navBar.largeTitleTextAttributes?[.foregroundColor] = UIColor(named: colorName)
            navBar.titleTextAttributes?[.foregroundColor] = UIColor(named: colorName)
            navBar.tintColor = UIColor(named: colorName)
            
            self.list = nil
        }
        else {
            navBar.largeTitleTextAttributes?[.foregroundColor] = UIColor.tintColor
            navBar.titleTextAttributes?[.foregroundColor] = UIColor.tintColor
            navBar.tintColor = UIColor.tintColor
        }
    }
}
