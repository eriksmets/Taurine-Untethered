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
            UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(AppDelegate.self))
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
        _ = LogStream.shared
        return true
    }
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}
