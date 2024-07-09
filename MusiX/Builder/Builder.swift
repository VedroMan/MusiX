//
//  Builder.swift
//  MusiX
//
//  Created by Timofey on 10.07.24.
//

import UIKit

protocol BuilderProtocol {
    static func createTabBarViewController() -> UIViewController
    
}

class Builder: BuilderProtocol {
    static func createTabBarViewController() -> UIViewController {
        let tabBarView = TabBarViewController()
        return tabBarView
    }
}
