//
//  AppDelegate.swift
//  HeartbeatDemo
//
//  Created by Joshua Grant on 9/18/22.
//

import UIKit
import Heartbeat

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    static let app = App()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
}

