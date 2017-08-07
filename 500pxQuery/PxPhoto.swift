//
//  Photo.swift
//  500pxQuery
//
//  Created by Chris Gray on 7/19/17.
//  Copyright © 2017 Chris Gray. All rights reserved.
//

import Foundation
import UIKit

extension PxPhoto {
    init?(json: [String: Any]) {
        guard let imageName = json["name"] as? String,
        let imageURL = json["image_url"] as? String,
        let imageNumberOfViews = json["times_viewed"] as? Int,
        let imageDateCreated = json["created_at"] as? String,
        let imageDescription = json["description"],
        let imageUser = json["user"] as? [String: Any],
        let imageUsername = imageUser["username"] as? String
            else {
                print("Could not find keys in json dictionary")
                return nil
        }
        
        //Initialize properties
        self.name = imageName
        self.url = imageURL
        self.views = "Times viewed: \(imageNumberOfViews)"
        self.username = "User: \(imageUsername)"
        
        let shortenedDate = imageDateCreated[imageDateCreated.startIndex...imageDateCreated.index(imageDateCreated.endIndex, offsetBy: -16)]
        self.dateCreated = "Date created: \(shortenedDate)"
        
        if let imageDescriptionString = imageDescription as? String {
            self.description = imageDescriptionString
        } else {
            self.description = "No description"
        }
    }
}

struct PxPhoto
{
    let name: String
    let url: String
    let views: String
    let username: String?
    let dateCreated: String
    let description: String
    var image: UIImage?
}





