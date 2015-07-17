//
//  ViewController.swift
//  ImagePicker
//
//  Created by Abdelaziz Elrashed on 7/9/15.
//  Copyright (c) 2015 Abdelaziz Elrashed. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var tabBar: UIToolbar!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: "ShareMeme")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "CancelHandler")
        
        // disable share button
        navigationItem.leftBarButtonItem?.enabled = false
        
        // Load TextField Styles
        loadStyles()
    }
    
    func openAlbum(){
        
        // init
        let picker = UIImagePickerController()
        
        // set delegate
        picker.delegate = self
        
        // show view controller
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func openCamera(){
        
        // init
        let picker = UIImagePickerController()
        
        // set delegate
        picker.delegate = self
        
        // set source type
        picker.sourceType = .Camera
        
        // show view
        presentViewController(picker, animated: true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)

        // enable album button when it's exists
        albumButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)
        
        // enable camera button when it's exists
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
        
        // call to subscribe to keyboard notification
        subscribeToKeyboardNotifications()
    }
    
    func subscribeToKeyboardNotifications() {
        // subscribe to UIKeyboardWillShowNotification in NSNotificationCenter
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        // subscribe to UIKeyboardWillHideNotification in NSNotificationCenter
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications(){
        // unsubscribe to UIKeyboardWillShowNotification in NSNotificationCenter
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        // check if this action comes from bottomText
        if bottomText.isFirstResponder() {
            
            // read keyboard height in screen
            let keyboardHeight  = getKeyboardHeight(notification)
            
            // slide all view except keyboard to top by keyboard height value
            view.frame.origin.y -= keyboardHeight
            
            // refresh styles again
            loadStyles()
        }
    }
    
    func keyboardWillHide(notification: NSNotification){
        
        // check if this action comes from bottomText
        if bottomText.isFirstResponder(){
            
            // slide view down to the original state
            view.frame.origin.y = 0.0
            
            // refresh styles again
            loadStyles()
        }
    }
    
    // This function return keyboard height as CGFloat
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    // Unsubscribe
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        // Save image quality
        imageView.contentMode = UIViewContentMode.ScaleToFill
        
        // set image into imageView
        imageView.image = image
        
        // enable share button
        navigationItem.leftBarButtonItem?.enabled = true
        
        // Dissmiss ImagePickerController
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(false, completion: nil)
    }
    
    // Clear textField when click on it
    func textFieldDidBeginEditing(textField: UITextField) {
        // clear text field when click to edit
        textField.text = ""
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // hide keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func loadStyles(){
        
        // init
        let attributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name:"HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -5.0
        ]
        
        // set attributes
        topText.defaultTextAttributes = attributes
        bottomText.defaultTextAttributes = attributes
        
        // set delegate
        topText.delegate = self
        bottomText.delegate = self
        
        // set no borders at all
        topText.borderStyle = UITextBorderStyle.None
        bottomText.borderStyle = UITextBorderStyle.None
        
        // set text in center
        topText.textAlignment = NSTextAlignment.Center
        bottomText.textAlignment = NSTextAlignment.Center
        
        // set placeholder
        topText.placeholder = "TOP TEXT"
        bottomText.placeholder = "BOTTOM TEXT"
        
        // set all letters in capitalization
        topText.autocapitalizationType = UITextAutocapitalizationType.AllCharacters
        bottomText.autocapitalizationType = UITextAutocapitalizationType.AllCharacters
    }
    
    func generateMemedImage() -> Meme{

        // Hide toolBar
        tabBarController?.tabBar.hidden = true
        tabBar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        // Show toolBar
       tabBarController?.tabBar.hidden = false
        tabBar.hidden = false
        
        return Meme(topText: topText.text, bottomText: bottomText.text, originalImage: imageView.image!, memedImage: memedImage)
    }
    
    // Share image action
    func ShareMeme(){
        
        performSegueWithIdentifier("share", sender: self)

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "share"{
            let vc = segue.destinationViewController as! ShareViewController
            vc.memedImageData = generateMemedImage()
        }
    }
    
    @IBAction func cameraHandler(sender: AnyObject) {
        openCamera()
    }
    
    @IBAction func AlbumHandler(sender: AnyObject) {
        openAlbum()
    }
    
    func CancelHandler(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}

