//
//  AppDelegate.swift
//  SampleAppLaunchHelper
//
//  Created by Florian Schliep on 12.05.16.
//
//

import Cocoa

@NSApplicationMain class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        guard NSWorkspace.sharedWorkspace().runningApplications.filter({ $0.bundleIdentifier == "com.floschliep.SampleApp" }).count == 0 else {  NSApp.terminate(nil); return } // ensure the main app isn't running
        
        let bundlePathComponents = (NSBundle.mainBundle().bundlePath as NSString).pathComponents
        var pathComponents = Array(bundlePathComponents[0...(bundlePathComponents.count-4)])
        pathComponents.appendContentsOf([ "MacOS", "SampleApp" ])
        let path = NSString.pathWithComponents(pathComponents)
        do {
            try NSWorkspace.sharedWorkspace().launchApplicationAtURL(NSURL(fileURLWithPath: path), options: .Default, configuration: [ NSWorkspaceLaunchConfigurationArguments: "helper" ])
        } catch let error as NSError {
            NSLog("%@", error)
        }
        
        NSApp.terminate(nil)
    }

}

