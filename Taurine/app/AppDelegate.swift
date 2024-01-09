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
                viewController.jailbreak()
            }
        }
    }
    var body: some Scene {
        WindowGroup {
            ViewWrapper()
        }
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
