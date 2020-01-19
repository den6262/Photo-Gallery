//
//  HistoryViewController.swift
//  Photo Gallery
//
//  Created by Deniro21 on 1/15/20.
//  Copyright © 2020 Denys Hryshyn. All rights reserved.
//

import UIKit
import RealmSwift

class HistoryViewController: UITableViewController {
    
    // Variables/Constants
    private var photos = [UnsplashPhoto]()
    var historyArray: [History] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Search History"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        fetchData()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        fetchData()
    }
    
    func fetchData() {
        let realm = try! Realm()
        
        historyArray = Array(realm.objects(History.self))
        
        for photo in historyArray {
            print("\(photo.photoName)")
        }
    }

    // MARK: - Table view delegate and data source methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return historyArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let name = historyArray[indexPath.row]
        if let imgData = name.photoImg {
            cell.imageView?.clipsToBounds = true
            cell.imageView?.layer.cornerRadius = 10
            cell.imageView?.image = UIImage(data: imgData as Data)
        }
        cell.textLabel?.text = "name: \(name.photoName)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let history = historyArray[indexPath.row]
        let realm = try! Realm()
        
        do {
            try realm.write {
                realm.delete(history)
                historyArray.remove(at: indexPath.row)
            }
        } catch {
            print(error)
        }
        tableView.reloadData()
    }
    
}
