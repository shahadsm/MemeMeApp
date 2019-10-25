//
//  TableViewController.swift
//  MemeProject
//
//  Created by shahad almugrin on 10/5/19.
//  Copyright © 2019 shahad almugrin. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    
    // This is an array of saved images.
    var memes: [Meme]{ return appDelegate.memes}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableCell
        
        
        let meme = memes[(indexPath).row]
        cell.MEMEImageView?.image = meme.memedImage
                  
        // Set the name and image
        cell.textLabel?.text = meme.topText + meme.bottomText
        cell.imageView?.image = meme.memedImage
        return cell
    }
   
    
    
    
    
    
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let detailController = storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = memes[(indexPath as NSIndexPath).row]
        navigationController!.pushViewController(detailController, animated: true)
    }
    
}
