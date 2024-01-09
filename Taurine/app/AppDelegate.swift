//
//  AppDelegate.swift
//  taurine
//
//  Created by AppInstaller iOS on 01/09/2024.
//

import SwiftUI

@main
struct Main {
    static func main() {
        let args = CommandLine.arguments
        if args.count >= 2 {
            if args[1] == "jailbreak" {
                print("Jailbreaking... kfd smith")
                UIApplication.shared.isIdleTimerDisabled = true
                jailbreak()
            } else {
                TaurineApp.main()
            }
        } else {
            TaurineApp.main()
        }
    }
}

struct TaurineApp: App {
    init() {
        _ = LogStream.shared
    }
    var body: some Scene {
        WindowGroup {
            ViewWrapper()
        }
    }
}

func jailbreak() {
    let enableTweaks = true
    let restoreRootFs = false
    let generator = NonceManager.shared.currentValue
    usleep(500 * 1000)
    var hasKernelRw = false
    var any_proc = UInt64(0)
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
        return
    }
    let electra = Electra(ui: viewController, any_proc: any_proc, enable_tweaks: enableTweaks, restore_rootfs: restoreRootFs, nonce: generator)
    let err = electra.jailbreak()
}


struct ViewWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return ViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}
