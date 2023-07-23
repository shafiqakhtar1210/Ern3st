//
//  AppDelegate.swift
//  Ern3st
//
//  Created by Muhammad Ali on 13/09/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let apiKey: String = "jpbDi9zrB1zXXpWLnMCdUm2ay3EXxz0rfeIt"
    let scannerId: String = "​N3bxK2R"
    let sessionKey: String = "​WC5fWj4JSQw71GrgjkTgSI5T1CMFhgpGUGgt"
    var userProfile: UserProfile?
    var lastScanRecord: ScanRecord?
    var sdk: TG3DMobileScan?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if self.sdk == nil {
            self.sdk = TG3DMobileScan(apiKey: self.apiKey)
            
            self.sdk!.currentRegion() { (rc, baseUrl) in
                if rc == 0 {
                    self.sdk!.setup(baseUrl: baseUrl)
                }
            }
        }
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

