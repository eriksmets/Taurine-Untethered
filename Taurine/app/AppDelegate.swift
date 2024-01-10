//
//  AppDelegate.swift
//  taurine
//
//  Created by 23 Aaron on 28/02/2021.
//

import SwiftUI

@main
struct Main {
    static func main() {
        let args = CommandLine.arguments
        if args.count > 1 {
            if args[1] == "jailbreak" {
                jailbreak()
            }
        } else {
            AppDelegate.main()
        }
    }
}

func jailbreak() {
    let enableTweaks = true
    let restoreRootFs = false
    let generator = NonceManager.shared.currentValue
    var hasKernelRw = false
    var any_proc = UInt64(0)
    sleep(5)
    print("Selecting kfd [smith] for iOS 14.0 - 14.8.1")
    LogStream.shared.pause()
    let ret = do_kopen(0x800, 0x1, 0x2, 0x2)
    LogStream.shared.resume()
    if ret != 0 {
        print("Successfully exploited kernel!");
        any_proc = our_proc_kAddr
        hasKernelRw = true
    }
    guard hasKernelRw else {
        print("No kernel r/w!")
        return
    }
    let electra = Electra(ui: ViewController(), any_proc: any_proc, enable_tweaks: enableTweaks, restore_rootfs: restoreRootFs, nonce: generator)
    let err = electra.jailbreak()
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        _ = LogStream.shared
        
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
