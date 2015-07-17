//
//  TableViewController.swift
//  ImagePicker
//
//  Created by Abdelaziz Elrashed on 7/17/15.
//  Copyright (c) 2015 Abdelaziz Elrashed. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

    var memes: [Meme]!
    var selected_row:Int!
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        // read all current memed sent
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        
        // reload when switch back to sent items tab
        tableView!.reloadData()
        
        // set navigation title
        navigationItem.title = "Meme Me - TableView"
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("imageCell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = memes[indexPath.row].topText
        cell.detailTextLabel?.text = memes[indexPath.row].bottomText
        cell.imageView?.image = memes[indexPath.row].memedImage

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        selected_row = indexPath.row
        performSegueWithIdentifier("showImageDetails2", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showImageDetails2"{
            let vc = segue.destinationViewController as! ImageViewMainViewController
            vc.memedImageData = memes[selected_row]
        }
    }
}
