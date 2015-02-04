//
//  ViewController.swift
//  Snippets
//
//  Created by Joseph Smith on 2/3/15.
//  Copyright (c) 2015 bjoli. All rights reserved.
//

import Cocoa
import ParseOSX

class ViewController: NSViewController {
    
    @IBOutlet var snippetsTextView: NSTextView!
    @IBOutlet weak var datepicker: NSDatePicker!
    let dateKey = "date"
    let snippetNameKey = "Snippet"
    let statusTextKey = "statusText"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let today = NSDate()
        datepicker.dateValue = today
        // Consider how to auth before this view loads so we get data
        // Seems like there is a race condition where we have not set application ID
        // and client ID, so cannot load data.
        updateDate(today)
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func saved(succeeded: Bool, error : NSError!) {
    
    }
    
    func updateDate(newDate : NSDate) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        let requestedDate = dateFormatter.stringFromDate(newDate)
        
        var query = PFQuery(className: snippetNameKey)
        query.whereKey(dateKey, equalTo:requestedDate)
        query.findObjectsInBackgroundWithBlock(retrieved)
    }
    
    func retrieved(objects : [AnyObject]!, error : NSError!) -> Void {
        if error == nil {
            // The find succeeded.
            NSLog("Successfully retrieved \(objects.count) textStatus.")
            // Do something with the found objects
            for object in objects as [PFObject] {
                NSLog("%@", object.objectId)
                let statusText = object[statusTextKey] as String
                snippetsTextView.string = statusText
            }
        } else {
            // Log details of the failure
            NSLog("Error: %@ %@", error, error.userInfo!)
        }
        
    }

    @IBAction func dateChanged(sender: NSDatePicker) {
        let newDate = sender.dateValue
        updateDate(newDate)
    }
    
    @IBAction func save(sender: NSButton) {
        let date = datepicker.dateValue
        let snippet = snippetsTextView.string!
        saveText(snippet, date: date)
    }
    
    func saveText(snippet : String, date: NSDate) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        
        let testObject = PFObject(className: snippetNameKey)
        testObject[dateKey] = dateFormatter.stringFromDate(date)
        testObject[statusTextKey] = snippet
        
        testObject.saveInBackgroundWithBlock(saved)
    }

}

