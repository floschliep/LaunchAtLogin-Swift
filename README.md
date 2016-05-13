#LaunchAtLogin-Swift

##What's this?
Adding a login helper to a cocoa app is a tedious task. This is a guide for me when adding a launch helper to a new app and I thought it might be helpful for others too.

I also wrote a small wrapper around the C function call required to enable/disable the login item so it's *swiftier* to use.

##Usage
1. Create new Cocoa app target `MyAppLaunchHelper`
2. Delete window from generated XIB/storyboard file
3. Set `LSBackgroundOnly` (Application is background only) to `true` in the `Info.plist` file
4. Set `Skip Install` to `YES` in the build settings for the **helper app**
5. Enable sandboxing for the helper app
6. Add a new `Copy Files` build phase to the **main app**
7. Select `Wrapper` as destination
8. Enter `Contents/Library/LoginItems` as subpath
9. Add the `MyAppLaunchHelper` build product to the build phase
10. Replace the boilerplate `AppDelegate` implementation of the **helper app**

```
func applicationDidFinishLaunching(aNotification: NSNotification) {
        guard NSWorkspace.sharedWorkspace().runningApplications.filter({ $0.bundleIdentifier == "bundleid.of.main.app" }).count == 0 else {  NSApp.terminate(nil); return } // ensure the main app isn't running
        
        let bundlePathComponents = (NSBundle.mainBundle().bundlePath as NSString).pathComponents
        var pathComponents = Array(bundlePathComponents[0...(bundlePathComponents.count-4)])
        pathComponents.appendContentsOf([ "MacOS", "MainExectuableName" ])
        let path = NSString.pathWithComponents(pathComponents)
        do {
            try NSWorkspace.sharedWorkspace().launchApplicationAtURL(NSURL(fileURLWithPath: path), options: .Default, configuration: [ NSWorkspaceLaunchConfigurationArguments: "helper" ])
        } catch let error as NSError {
            NSLog("%@", error)
        }
        
        NSApp.terminate(nil)
    }
``` 
Remember to replace `bundleid.of.main.app` and `MainExectuableName` with your own values. <br /><br />
11. Copy the `LaunchHelper.swift` file to your project<br />
12. Use the `LaunchHelper` struct to enable/disable the login item

```
let helper = LaunchHelper(bundleIdentifier: "bundleid.of.helper.app")
try helper.enable()
// ...or
try helper.disable()
// ...or
try helper.setEnabled(enabled)
```

Note that enabling/disabling the login item can fail. If so, the above methods will throw an `NSErrror` object. <br /><br />
13. Make sure the main app and helper app use the same code signing certificate

## Contribution
If anything is unclear or wrong, please open an issue or create a pull request.

## Author
I'm Florian Schliep, you can reach me here:

- [github.com/floschliep](https://github.com/floschliep)
- [twitter.com/floschliep](https://twitter.com/floschliep)
- [floschliep.com](http://floschliep.com)

## License
`LaunchHelper` is available under the MIT license. See the LICENSE file for more info.
