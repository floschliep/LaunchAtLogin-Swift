//
//  LaunchHelper.swift
//
//  The MIT License (MIT)
//
//  Copyright (c) 2016 Florian Schliep
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation
import ServiceManagement

struct LaunchHelper {
    let bundleIdentifier: String
    
    func enable() throws {
        try self.setEnabled(true)
    }
    
    func disable() throws {
        try self.setEnabled(false)
    }
    
    func setEnabled(enabled: Bool) throws {
        guard !SMLoginItemSetEnabled(self.bundleIdentifier, enabled) else { return }
        let appName = NSBundle.mainBundle().infoDictionary!["CFBundleName"]!
        let message = enabled ? "Failed to add \(appName) to your login items." : "Failed to remove \(appName) from your login items."
        throw NSError(domain: self.bundleIdentifier, code: 1, userInfo: [NSLocalizedDescriptionKey: message])
    }
}

