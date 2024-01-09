//
//  AppDelegate.swift
//  taurine
//
//  Created by 23 Aaron on 28/02/2021.
//

import SwiftUI

@main
struct TaurineApp: App {
    init() {
        _ = LogStream.shared
        //CLI Stuff
        let args = CommandLine.arguments
        if args.count >= 2 {
            if args[1] == "jailbreak" {
                print("Jailbreaking...")
                UIApplication.shared.isIdleTimerDisabled = true
                jailbreak()
                while true {
                }
            } else if args[1] == "jailbreak2" {
                print("Jailbreaking...")
                jailbreak()
                while true {
                }
            } else if args[1] == "jailbreak3" {
                print("Jailbreaking...")
                while true {
                }
            }
        }
    }
    var body: some Scene {
        WindowGroup {
            ViewWrapper()
        }
    }
}

func jailbreak() {
    print("test 1")
    let enableTweaks = true
    let restoreRootFs = false
    let generator = NonceManager.shared.currentValue
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        print("test 2")
        usleep(500 * 1000)
        print("test 3")
        var hasKernelRw = false
        var any_proc = UInt64(0)
        switch ExploitManager.shared.chosenExploit {
        case .cicutaVirosa:
            print("Selecting cicuta_virosa for iOS 14.0 - 14.3")
            if cicuta_virosa() == 0 {
                any_proc = our_proc_kAddr
                hasKernelRw = true
            }
        case .kfdPhysPuppet:
            print("Selecting kfd [physpuppet] for iOS 14.0 - 14.8.1")
            LogStream.shared.pause()
            let ret = do_kopen(0x800, 0x0, 0x2, 0x2)
            LogStream.shared.resume()
            if ret != 0 {
                print("Successfully exploited kernel!");
                any_proc = our_proc_kAddr
                hasKernelRw = true
            }
        case .kfdSmith:
            print("Selecting kfd [smith] for iOS 14.0 - 14.8.1")
            LogStream.shared.pause()
            let ret = do_kopen(0x800, 0x1, 0x2, 0x2)
            LogStream.shared.resume()
            if ret != 0 {
                print("Successfully exploited kernel!");
                any_proc = our_proc_kAddr
                hasKernelRw = true
            }
        default:
            print("Unable to get kernel r/w")
            return
        }
        guard hasKernelRw else {
            return
        }
        let electra = Electra(ui: viewController, any_proc: any_proc, enable_tweaks: enableTweaks, restore_rootfs: restoreRootFs, nonce: generator)
        let err = electra.jailbreak()
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
