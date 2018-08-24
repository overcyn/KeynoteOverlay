//
//  AppDelegate.swift
//  KeynoteOverlay
//
//  Created by Kevin Dang on 8/23/18.
//  Copyright © 2018 Matcha. All rights reserved.
//

import Cocoa
import WebKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, WKUIDelegate, WKNavigationDelegate, NSWindowDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet var webView: WKWebView!
    @IBOutlet var openItem: NSMenuItem!
    var styleMask: NSWindow.StyleMask!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        window.level = .screenSaver + 1
        window.delegate = self
        styleMask = window.styleMask
        
        openItem.target = self
        openItem.action = #selector(open)
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.load(URLRequest(url: URL(string:"https://www.google.com")!))
    }

    @objc func open() {
        let textField = NSTextField(frame: NSRect(x: 0, y: 0, width: 300, height: 24))
        textField.placeholderString = "URL"

        let a = NSAlert()
        a.messageText = "Open URL:"
        a.addButton(withTitle: "Open")
        a.addButton(withTitle: "Cancel")
        a.accessoryView = textField
        a.beginSheetModal(for: self.window){ (response) -> Void in
            if response == .alertFirstButtonReturn, var url = URL(string: textField.stringValue) {
                if url.scheme == nil, let url2 = URL(string: "http://" + textField.stringValue) {
                    url = url2
                }
                self.webView.load(URLRequest(url: url))
            }
        }
    }

    func windowDidBecomeKey(_ notification: Notification) {
        window.styleMask = styleMask
    }
    
    func windowDidResignKey(_ notification: Notification) {
        window.styleMask = .borderless
    }
    
}

class Window: NSWindow {
    override var canBecomeKey: Bool {
        return true
    }
    
    override var canBecomeMain: Bool {
        return true
    }
}
