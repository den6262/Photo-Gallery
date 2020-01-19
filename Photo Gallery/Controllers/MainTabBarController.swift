//
//  MainTabBarController.swift
//  Photo Gallery
//
//  Created by Deniro21 on 1/15/20.
//  Copyright © 2020 Denys Hryshyn. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        
        let photoVC = PhotoCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
            
            viewControllers = [generateNavVC(rootViewController: photoVC, title: "Photos", image: #imageLiteral(resourceName: "photo")),
            generateNavVC(rootViewController: HistoryViewController(), title: "History", image: #imageLiteral(resourceName: "history"))]
            
        }
        
        private func generateNavVC(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
            let navigationVC = UINavigationController(rootViewController: rootViewController)
            navigationVC.tabBarItem.title = title
            navigationVC.tabBarItem.image = image
            return navigationVC
        }
    }
