//
//  Meme.swift
//  ImagePicker
//
//  Created by Abdelaziz Elrashed on 7/15/15.
//  Copyright (c) 2015 Abdelaziz Elrashed. All rights reserved.
//

import UIKit

struct Meme{
    
    var topText:String!
    var bottomText:String!
    var originalImage:UIImage!
    var memedImage:UIImage!
    
    init(topText:String, bottomText:String, originalImage:UIImage, memedImage:UIImage){
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memedImage = memedImage
    }
}
