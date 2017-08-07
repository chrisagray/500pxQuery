//
//  Request.swift
//  500pxQuery
//
//  Created by Chris Gray on 7/19/17.
//  Copyright © 2017 Chris Gray. All rights reserved.
//

import Foundation

let consumerKey = "L1Yj9o68dZub8KbSSYEdCrQG5G4tapkehKgqYVKt"

class Request
{
    private var searchTerm = ""
    private var pageNumber = 1
    
    init(search: String, page: Int) {
        searchTerm = search
        pageNumber = page
    }
    
    func fetchPhotos(completion: @escaping ([PxPhoto]) -> Void) {
        var pxPhotos = [PxPhoto]()
        if let url = URL(string: "https://api.500px.com/v1/photos/search?term=\(searchTerm)&consumer_key=\(consumerKey)&page=\(pageNumber)") {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let imagesData = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [String: AnyObject] else {
                        print("Error. Unknown API Response")
                        return
                }
                guard let photoDictionary = imagesData["photos"] as? [[String: AnyObject]] else {
                    print("Cannot create photo Dictionary")
                    return
                }
                for photoObject in photoDictionary {
                    if let pxPhoto = PxPhoto(json: photoObject) {
                        pxPhotos.append(pxPhoto)
                    } else {
                        print("Could not create PxPhoto. Returned struct is nil")
                        return
                    }
                }
                completion(pxPhotos)
            }
            task.resume()
        } else {
            print("Cannot create url from string")
            return
        }
    }
}





























