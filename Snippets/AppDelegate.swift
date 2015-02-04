//
//  AppDelegate.swift
//  Snippets
//
//  Created by Joseph Smith on 2/3/15.
//  Copyright (c) 2015 bjoli. All rights reserved.
//

import Cocoa
import ParseOSX

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationWillFinishLaunching(aNotification: NSNotification) {
        Parse.enableLocalDatastore()

        //Parse.setApplicationId(

        PFUser.enableAutomaticUser()

        let defaultACL: PFACL = PFACL()
        PFACL.setDefaultACL(defaultACL, withAccessForCurrentUser: true)

        PFAnalytics.trackAppOpenedWithLaunchOptionsInBackground([:], block: nil)
        
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

}

