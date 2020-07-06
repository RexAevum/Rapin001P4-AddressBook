//  PROGRAMMER: Rolans Apinis
//  PANTHERID: 6044121
//  CLASS: COP 465501 TR 5:00
//  INSTRUCTOR: Steve Luis ECS 282
//  ASSIGNMENT: Programming Assignment #4
//  DUE: Thursday 07/05/2020 //

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
