//
//  PhotoInfoViewController.swift
//  500pxQuery
//
//  Created by Chris Gray on 7/21/17.
//  Copyright © 2017 Chris Gray. All rights reserved.
//

import UIKit

class PhotoInfoViewController: UIViewController
{
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoNameLabel: UILabel!
    @IBOutlet weak var photoDescriptionLabel: UILabel!
    @IBOutlet weak var photoUsernameLabel: UILabel!
    @IBOutlet weak var photoNumberOfViewsLabel: UILabel!
    @IBOutlet weak var photoDateCreatedLabel: UILabel!
    
    var pxPhoto: PxPhoto?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    private func updateUI() {
        if let photo = pxPhoto {
            photoNameLabel.text = photo.name
            photoImageView.image = photo.image
            photoDescriptionLabel.text = photo.description
            photoUsernameLabel.text = photo.username
            photoNumberOfViewsLabel.text = photo.views
            photoDateCreatedLabel.text = photo.dateCreated
        }
    }
}
