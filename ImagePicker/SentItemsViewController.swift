//
//  SentItemsViewController.swift
//  ImagePicker
//
//  Created by Abdelaziz Elrashed on 7/15/15.
//  Copyright (c) 2015 Abdelaziz Elrashed. All rights reserved.
//

import UIKit

class SentItemsViewController: UICollectionViewController, UICollectionViewDataSource {
    
    var memes: [Meme]!
    var selected_item:Int!
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "openImageEdior")
        
        // read all current memed sent
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        
        // reload when switch back to sent items tab
        collectionView!.reloadData()
        
        // set white to background color
        collectionView!.backgroundColor = UIColor.whiteColor()
        
        // set title
        navigationItem.title = "Sent Memes"
    }
    
    func openImageEdior(){
        performSegueWithIdentifier("SHOW_IMAGE_EDITOR_FROM_COLLECTION_VIEW", sender: self)
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ImageCell", forIndexPath: indexPath) as! ImageCollectionViewCell
        
        cell.imageView?.image = memes[indexPath.row].memedImage
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        // set selected row
        selected_item = indexPath.item
        
        // fire segue
        performSegueWithIdentifier("showImageDetails", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // check segue identifier
        if segue.identifier == "showImageDetails"{
            
            // pass data
            let vc = segue.destinationViewController as! ImageViewMainViewController
            vc.memedImageData = memes[selected_item]
            
        }
    }
}
