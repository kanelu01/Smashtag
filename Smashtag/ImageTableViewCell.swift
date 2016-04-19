//
//  ImageTableViewCell.swift
//  Smashtag
//
//  Created by Lucas Kane on 4/19/16.
//  Copyright © 2016 Lucas Kane. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    var imageUrl: NSURL? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var activityIndcator: UIActivityIndicatorView!
    
    func updateUI() {
        
        // Reset any pre-existing tweet information
        mediaImageView.image = nil
        
        if let imageUrl = imageUrl {
            
            activityIndcator.startAnimating()
            let qos = Int(QOS_CLASS_USER_INITIATED.rawValue)
            
            //fetch the data off the main queue
            dispatch_async(dispatch_get_global_queue(qos, 0)) {
                if let data = NSData(contentsOfURL: imageUrl) {
                    
                    //update the UI on the main queue
                    dispatch_async(dispatch_get_main_queue()) {
                        self.mediaImageView?.image = UIImage(data: data)
                        self.activityIndcator.stopAnimating()
                    }
                } else {
                    self.activityIndcator.stopAnimating()
                }
            }
        }
    }
}
