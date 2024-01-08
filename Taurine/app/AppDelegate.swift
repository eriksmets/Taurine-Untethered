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
        //Test stuff
        UIPasteboard.general.string = "Taurine 2"
        print("Taurine 2")
        let args = CommandLine.arguments
        print(args)
        if args.count => 2 {
            if args[1] == "jailbreak" {
                print("Jailbreaking...")
            }
        }
    }
    var body: some Scene {
        WindowGroup {
            ViewWrapper()
        }
    }
}

struct ViewWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return ViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}
