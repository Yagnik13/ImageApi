//
//  ViewController.swift
//  ImageAPI
//
//  Created by Yagnik on 03/02/17.
//  Copyright © 2017 Yagnik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var photos: [Image] = [Image]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 10.0
        
        let url = "https://jsonplaceholder.typicode.com/photos"
        
        APImanager().callGetWebservice(urlString: url, completionHandler: { (photoArray) in
            
            self.photos = photoArray
            
            self.tableView.reloadData()
            
        })
        
        
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print(indexPath.row, "for cell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImgCell") as! ImgCell
        
        cell.imgtitle.text = photos[indexPath.row].title
        
        let thumbUrl = photos[indexPath.row].bigImgUrl
        APImanager().getImage(from: thumbUrl, for: indexPath) { (image) in
            cell.imgView.image = image
        }
        
        return cell
    }
    
}


