//
//  CommentListTableViewController.swift
//  Mobile-2-product-hunt
//
//  Created by Chris Mauldin on 11/2/17.
//  Copyright © 2017 Chris Mauldin. All rights reserved.
//

import UIKit

class CommentListTableViewController: UITableViewController {
    
    var comments = [Comment]()
    var id: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let id = id {
            let productHunt = ProductHuntNetwork()
            productHunt.fetch(resource: .comments(postId: id)) { (comments) in
                DispatchQueue.main.async {
                    self.comments = comments as! [Comment]
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.comments.count
    }

    

}
