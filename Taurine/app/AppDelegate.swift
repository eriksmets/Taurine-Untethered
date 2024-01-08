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
        UIPasteboard.general.string = "Taurine"
        print("Taurine")
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
