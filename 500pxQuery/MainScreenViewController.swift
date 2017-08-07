//
//  MainScreenViewController.swift
//  500pxQuery
//
//  Created by Chris Gray on 7/23/17.
//  Copyright © 2017 Chris Gray. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController
{
    @IBOutlet weak var mainScreenLabel: UILabel!
    @IBOutlet weak var pxLogoImageView: UIImageView!
    @IBOutlet weak var mainScreenStackView: UIStackView!
    
    override func viewDidLoad() {
        let pxLogoImage = #imageLiteral(resourceName: "500px_logo_dark")
        pxLogoImageView.image = pxLogoImage
    }
}
