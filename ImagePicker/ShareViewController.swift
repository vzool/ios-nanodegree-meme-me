//
//  ShareViewController.swift
//  ImagePicker
//
//  Created by Abdelaziz Elrashed on 7/17/15.
//  Copyright (c) 2015 Abdelaziz Elrashed. All rights reserved.
//

import UIKit
import Social

class ShareViewController: UIViewController {
    
    var memedImageData:Meme!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Share with Friends!"
    }
    
    func rememberShare(){
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(memedImageData)
    }
 
    @IBAction func shareOnFacebook(sender: AnyObject) {
        
        // init
        var fb = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        
        // add memed image
        fb.addImage(memedImageData.memedImage)
        
        // add some default text
        fb.setInitialText("Hello! check my Memed Image, I hope you like it. ;)")
        
        // show facebook post view controller
        presentViewController(fb, animated: true, completion: nil)
        
        rememberShare()
    }

    @IBAction func shareOnTwitter(sender: AnyObject) {
        
        // init
        var tw = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        
        // add memd image
        tw.addImage(memedImageData.memedImage)
        
        // add some default text
        tw.setInitialText("Hello! check my Memed Image, I hope you like it. ;)")
        
        // show twitter post view controller
        presentViewController(tw, animated: true, completion: nil)
        
        rememberShare()
    }
}
