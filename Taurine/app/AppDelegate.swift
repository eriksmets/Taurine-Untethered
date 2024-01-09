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
        if args.count >= 2 {
            if args[1] == "jailbreak" {
                DispatchQueue.global(qos: .utility).async {
                    print("Jailbreaking... TEST: 7")
                    UIApplication.shared.isIdleTimerDisabled = true
                    jailbreak()
                    while true {
                    }
                }
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
    print("1")
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        print("2")
        usleep(500 * 1000)
        print("3")
        var hasKernelRw = false
        var any_proc = UInt64(0)
        print("Selecting kfd [smith] for iOS 14.0 - 14.8.1")
        LogStream.shared.pause()
        let ret = do_kopen(0x800, 0x1, 0x2, 0x2)
        LogStream.shared.resume()
        print("4")
        if ret != 0 {
            print("Successfully exploited kernel!");
            any_proc = our_proc_kAddr
            hasKernelRw = true
        }
        print("5")
        guard hasKernelRw else {
            print("No kernel r/w!")
            return
        }
        let electra = Electra(ui: viewController, any_proc: any_proc, enable_tweaks: enableTweaks, restore_rootfs: restoreRootFs, nonce: generator)
        let err = electra.jailbreak(
    }
}

var viewController: ViewController = ViewController()

struct ViewWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ViewController {
        return viewController
    }

    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        
    }
}
