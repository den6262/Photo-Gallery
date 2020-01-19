//
//  PhotoCollectionViewController.swift
//  Photo Gallery
//
//  Created by Deniro21 on 1/15/20.
//  Copyright © 2020 Denys Hryshyn. All rights reserved.
//

import UIKit
import RealmSwift

class PhotoCollectionViewController: UICollectionViewController {
    
    // Variables/Constants
    
    var networkDataFetcher = NetworkDataFetcher()
        
    private var photos = [UnsplashPhoto]()
    
    private var selectedImages = [UIImage]()
    
    private let sectionInserts = UIEdgeInsets(top: 100, left: 20, bottom: 20, right: 20)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        setupCollectionView()
        setupNavigationBar()
        setupSearchBar()
        
    }
    
    func showAlert() {
        // Show alert
        let alert = UIAlertController(title: "Oops!", message: "It seems that no image was found for this request, enter something else.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Setup UI Elements
    
    private func setupCollectionView() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellId")
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseId)
        
        collectionView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.contentInsetAdjustmentBehavior = .automatic
        
        collectionView.allowsMultipleSelection = true
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "PHOTOS"
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        titleLabel.textColor = #colorLiteral(red: 0.5019607843, green: 0.4980392157, blue: 0.4980392157, alpha: 1)
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    // MARK: - UICollectionViewDataSource, UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseId, for: indexPath) as! PhotoCell
        let unsplashPhoto = photos[indexPath.item]
        cell.unsplashPhoto = unsplashPhoto
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let newPhoto = History()
            if let imgData = cell.photoImgView.image?.jpegData(compressionQuality: 0.5) {
                newPhoto.photoImg = imgData as NSData
                newPhoto.photoName = UserDefaults.standard.string(forKey: "name")!
            }
            let realm = try! Realm()
            
            do {
                try realm.write {
                    realm.add(newPhoto)
                    print("Added \(newPhoto)")
                }
            } catch {
                print(error)
            }
        }
        return cell
    }
    
}

// MARK: - UISearchBarDelegate

extension PhotoCollectionViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.networkDataFetcher.fetchImages(searchTerm: searchText) { [weak self] (searchResults) in
            guard let fetchedPhotos = searchResults else { return }
            self?.photos = fetchedPhotos.results
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.collectionView.reloadData()
        let ud = UserDefaults.standard
        ud.set(searchBar.text!, forKey: "name")
        
        if photos.count < 1 {
            showAlert()
        }
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotoCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width/2, height: view.frame.height/2)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
    
}


