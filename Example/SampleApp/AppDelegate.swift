//
//  AppDelegate.swift
//  SampleApp
//
//  Created by Florian Schliep on 12.05.16.
//
//

import Cocoa

@NSApplicationMain class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    @IBAction func toggleLaunchAtLogin(sender: NSButton) {
        let enabled = sender.state == NSOnState
        do {
            try LaunchHelper(bundleIdentifier: "com.floschliep.SampleAppLaunchHelper").setEnabled(enabled)
        } catch let error as NSError {
            NSUserDefaults.standardUserDefaults().setBool(!enabled, forKey: "launchAtLogin")
            NSAlert(error: error).runModal()
        }
    }

}

