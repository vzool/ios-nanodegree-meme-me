//
//  ImageViewMainViewController.swift
//  ImagePicker
//
//  Created by Abdelaziz Elrashed on 7/16/15.
//  Copyright (c) 2015 Abdelaziz Elrashed. All rights reserved.
//

import UIKit

class ImageViewMainViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    var memedImageData:Meme!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationItem.title = "Details"
        
        if let view = imageView{
            
            // set image
            view.image = memedImageData.memedImage
            
        }
    }
}
