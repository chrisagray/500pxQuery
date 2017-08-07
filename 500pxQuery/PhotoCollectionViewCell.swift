//
//  PhotoCollectionViewCell.swift
//  500pxQuery
//
//  Created by Chris Gray on 7/20/17.
//  Copyright © 2017 Chris Gray. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var pxPhotoImageView: UIImageView!
    @IBOutlet weak var pxPhotoTitleLabel: UILabel!
    
    var pxPhoto: PxPhoto? {
        didSet {
            if pxPhoto?.image == nil { //Don't update on-screen images
                updateUI()
            }
        }
    }
    
    private func updateUI() {
        pxPhotoTitleLabel?.text = pxPhoto?.name
        weak var weakSelf = self //needs to be able to leave the heap
        if let imageURL = URL(string: (pxPhoto?.url)!) {
            DispatchQueue.global().async {  //background thread
                if let imageData = NSData(contentsOf: imageURL) {
                    if let pxPhotoImage = UIImage(data: imageData as Data) {
                        weakSelf?.pxPhoto?.image = pxPhotoImage
                        DispatchQueue.main.async {  //update UI on the main thread
                            weakSelf?.pxPhotoImageView.image = pxPhotoImage
                        }
                    }
                }
            }
        }
    }
}
