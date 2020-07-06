//
//  ImageDB.swift
//  Rapin001P4
//
//  Created by Rolans Apinis on 7/5/20.
//  Copyright © 2020 Rolans Apinis. All rights reserved.
//

import Foundation
import UIKit

class ImageDB{
    
    var allImages = NSCache<NSString, UIImage>()
    
    //function to add image
    func setImage(_ image: UIImage, forKey key: String) -> Void{
        allImages.setObject(image, forKey: key as NSString)
    }
    
    //function to set image
    func returnImage(forKey key: String) -> UIImage? {
        return allImages.object(forKey: key as NSString)
    }
    
    //function to delete image
    func deleteImage(forKey key: String) -> Void {
        allImages.removeObject(forKey: key as NSString)
    }
}
