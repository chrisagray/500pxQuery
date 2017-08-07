//
//  PhotoCollectionViewController.swift
//  500pxQuery
//
//  Created by Chris Gray on 7/19/17.
//  Copyright © 2017 Chris Gray. All rights reserved.
//

import UIKit

class PhotoCollectionViewController: UICollectionViewController, UISearchBarDelegate, UICollectionViewDelegateFlowLayout
{
    @IBOutlet weak var mainScreenView: UIView!
    private let searchBar = UISearchBar()
    private var pageNumber = 1
    private var pxPhotos = [PxPhoto]() {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.placeholder = "Search 500px"
        searchBar.sizeToFit()
        searchBar.searchBarStyle = .minimal
        navigationItem.titleView = searchBar
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        mainScreenView.isHidden = true
        mainScreenView.removeFromSuperview()
        searchBar.resignFirstResponder()
        var searchBarText = searchBar.text!
        title = searchBarText
        searchBarText = searchBarText.replacingOccurrences(of: " ", with: "+")
        searchText = searchBarText
    }
    
    private var searchText: String? {
        didSet {
            pxPhotos.removeAll()
            pageNumber = 1
            searchForPxPhotos()
        }
    }
    
    private var pxRequest: Request? {
        if let query = searchText, !query.isEmpty {
            return Request(search: query, page: pageNumber)
        }
        return nil
    }
    
    private func searchForPxPhotos() {
        if let request = pxRequest {
            request.fetchPhotos { [weak weakSelf = self] newPxPhotos in //need to be able to leave the heap if user navigates away
                DispatchQueue.main.async { //update the UI on the main thread
                    if !newPxPhotos.isEmpty {
                        weakSelf?.pxPhotos.append(contentsOf: newPxPhotos)
                    }
                }
            }
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pxPhotos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PxPhoto", for: indexPath) as! PhotoCollectionViewCell
        let currentPhoto = pxPhotos[indexPath.row]
        cell.pxPhoto = currentPhoto
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == pxPhotos.count - 1 {
            pageNumber += 1
            searchForPxPhotos()
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? PhotoInfoViewController {
            if let currentCell = sender as? PhotoCollectionViewCell {
                destinationVC.pxPhoto = currentCell.pxPhoto
            }
        }
    }
}
