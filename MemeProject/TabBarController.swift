//
//  TabBarController.swift
//  MemeProject
//
//  Created by shahad almugrin on 10/5/19.
//  Copyright © 2019 shahad almugrin. All rights reserved.
//

import Foundation
import UIKit

class TabBarController : UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New Meme", style: .plain, target: self, action: #selector(newImage))
    }
    
    @objc func newImage(){
        let storyboard = UIStoryboard (name: "Main", bundle: nil)
        let newImageVC = storyboard.instantiateViewController(withIdentifier: "NewImage")as! NewImageViewController
        
        let navigationController = UINavigationController()
        navigationController.viewControllers = [newImageVC]
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
}
