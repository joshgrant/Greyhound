//
//  AppDelegate.swift
//  HeartbeatDemo
//
//  Created by Joshua Grant on 9/18/22.
//

import UIKit
import Heartbeat

@main
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    
    static let world = World(systems: [])

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        return true
    }
}

