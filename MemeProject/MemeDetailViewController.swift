//
//  MemeDetailViewController.swift
//  MemeProject
//
//  Created by shahad almugrin on 10/5/19.
//  Copyright © 2019 shahad almugrin. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController : UIViewController {
    @IBOutlet weak var imageView: UIImageView!
   var meme: Meme!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imageView.image = meme.memedImage
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
}

