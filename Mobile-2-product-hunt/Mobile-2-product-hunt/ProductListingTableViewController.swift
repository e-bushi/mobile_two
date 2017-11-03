//
//  ProductListingTableViewController.swift
//  Mobile-2-product-hunt
//
//  Created by Chris Mauldin on 11/1/17.
//  Copyright © 2017 Chris Mauldin. All rights reserved.
//

import UIKit

class ProductListingTableViewController: UITableViewController {
    var list = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let productHunt = ProductHuntNetwork()
        productHunt.fetch(resource: .posts) { (posts) in
            DispatchQueue.main.async {
                self.list = posts as! [Post]
                self.tableView.reloadData()
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
        return self.list.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = list[indexPath.row].name

        return cell
    }

}

extension ProductListingTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = list[indexPath.row].id
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let CommentListTableView = storyboard.instantiateViewController(withIdentifier: "commentList") as! CommentListTableViewController
        
        CommentListTableView.id = row
        self.navigationController?.pushViewController(CommentListTableView, animated: true)
    }
}
