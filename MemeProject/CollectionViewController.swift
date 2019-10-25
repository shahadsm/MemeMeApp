//
//  CollectionViewController.swift
//  MemeProject
//
//  Created by shahad almugrin on 10/5/19.
//  Copyright © 2019 shahad almugrin. All rights reserved.
//

import UIKit

class CollectionViewController:
UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //This is an array of saved images.
        var memes: [Meme]{ return appDelegate.memes }
        
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            collectionView?.reloadData();
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
        }
        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return memes.count
        }
        
        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for:indexPath) as! MemeCollectionViewCell
            
            let meme = memes[(indexPath as NSIndexPath).row]
            
            // Set the image
            cell.MemeImageView?.image = meme.memedImage
            
        
            
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let space:CGFloat = 3.0
        let dimension = (collectionView.frame.size.width / 3.0) - (2 * space)
        
        return CGSize(width: 80, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return  3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return  3
    }
        
        override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {

            let detailController = storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
            detailController.meme = memes[(indexPath).row]
            navigationController!.pushViewController(detailController, animated: true)
        }
    }


