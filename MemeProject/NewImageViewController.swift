//
//  NewImageViewController.swift
//  MemeProject
//
//  Created by shahad almugrin on 9/28/19.
//  Copyright © 2019 shahad almugrin. All rights reserved.
//

import UIKit

class NewImageViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    

   
    @IBOutlet weak var pickedImageView: UIImageView!
    @IBOutlet weak var click: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBOutlet weak var navigBar: UINavigationBar!
    

    @IBOutlet weak var shareButton: UIButton!
    var meme: Meme!
    
    
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField(topTextField,text: "Top")
        configureTextField(bottomTextField,text: "Bottom")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(dismissCurrentViewController))
       
        // for the share button
     if (pickedImageView.image == nil) {
        shareButton.isEnabled = false
     }
    }
    
    @objc func dismissCurrentViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
   override func viewWillAppear(_ animated: Bool) {
    
    super.viewWillAppear(animated)
    subscribeToKeyboardNotifications()
     cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)}
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    func configureTextField(_ textField: UITextField, text: String) {
            textField.delegate = self
        
        textField.defaultTextAttributes = [
            .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            .foregroundColor: UIColor.white,
            .strokeColor: UIColor.black,
            .strokeWidth: -3
            
        ]
        textField.textAlignment = .center
        textField.text = text
            
    }
    
   
    // IMAGE PICKER FUNCTIONS
    
    
    @IBAction func pickImageFromCamera(sender: UIBarButtonItem) {
        pickImage(sourceType: UIImagePickerController.SourceType.camera)
    }

    @IBAction func pickImageFromAlbum(sender: UIBarButtonItem) {
        pickImage(sourceType: UIImagePickerController.SourceType.photoLibrary)
    }
    
func pickImage(sourceType:UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            pickedImageView.image = image
            shareButton.isEnabled = true
        }
        else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
               pickedImageView.image = image
                shareButton.isEnabled = true
            }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }


    
    func subscribeToKeyboardNotifications() {

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
       
    }

    func unsubscribeFromKeyboardNotifications() {

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {

        if bottomTextField.isFirstResponder {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {

        view.frame.origin.y = 0
        
    }

    func getKeyboardHeight(_ notification:Notification) -> CGFloat {

        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    // TEXT FIELD DELEGATE FUNCTIONS
   
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var newText: NSString = textField.text! as NSString
        newText = newText.replacingCharacters(in: range, with: string.uppercased()) as NSString
        textField.text = String(newText)
        return false
    }
    
    
    
    
    
    
    
    // saving the meme
    
    
    @IBAction func shareMeme(sender: AnyObject) {
        let memedImage = generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        // setting up dismissal of the activity view once the meme is successfully shared:
        activityViewController.completionWithItemsHandler = {
            (activity, success, items, error) in
            if (success) {
                self.meme = self.save()
                self.dismiss(animated: true, completion: nil)
            }
        }
       
    
        self.present(activityViewController, animated: true, completion: nil)
    }

    
    func save() -> Meme {
        let meme = Meme(topText:topTextField.text!, bottomText:bottomTextField.text!, originalImage:pickedImageView.image!, memedImage: generateMemedImage())
        
       let object = UIApplication.shared.delegate
          let appDelegate = object as! AppDelegate
          appDelegate.memes.append(meme)
        return meme
    }
    
    
  
    
    func generateMemedImage() -> UIImage {

        // TODO: Hide toolbar and navbar
        
        toolBar.isHidden = true
        navigBar.isHidden = true
        

        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        // TODO: Show toolbar and navbar
        
        toolBar.isHidden = false
        navigBar.isHidden = false

        return memedImage
    }
    
}
    
    extension NewImageViewController: UITextFieldDelegate {
        
       
        
        func textFieldShouldClear(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    }

   

