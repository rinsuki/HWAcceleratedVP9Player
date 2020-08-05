//
//  AppDelegate.swift
//  HWAcceleratedVP9Player
//
//  Created by user on 2020/08/05.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    let window = NSWindow(contentViewController: ViewController())


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        window.makeKeyAndOrderFront(self)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

