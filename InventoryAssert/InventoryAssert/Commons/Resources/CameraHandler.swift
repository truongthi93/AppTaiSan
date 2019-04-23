//
//  CameraHandler.swift
//  InventoryAssert
//
//  Created by Bui Van Hieu on 4/23/19.
//  Copyright © 2019 Hospital. All rights reserved.
//

import Foundation
import UIKit
import AssetsPickerViewController


class CameraHandler: NSObject{
    static let shared = CameraHandler()
    
    fileprivate var currentVC: UIViewController!
    
    //MARK: Internal Properties
    var imagePickedBlock: ((UIImage) -> Void)?
    
    func camera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .camera
            currentVC.present(myPickerController, animated: true, completion: nil)
        }
    }
    
//    func photoLibrary(){
//        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
//            let myPickerController = UIImagePickerController()
//            myPickerController.delegate = self;
//            myPickerController.sourceType = .photoLibrary
//            currentVC.present(myPickerController, animated: true, completion: nil)
//        }
//    }
    
    func photoGallery() {
        let picker = AssetsPickerViewController()
        picker.pickerDelegate = self.currentVC as? AssetsPickerViewControllerDelegate
        self.currentVC.present(picker, animated: true, completion: nil)
    }
    
    func showActionSheet(vc: UIViewController) {
        currentVC = vc
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.camera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.photoGallery()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        vc.present(actionSheet, animated: true, completion: nil)
    }
    
}


extension CameraHandler: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        currentVC.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.imagePickedBlock?(image)
        }else{
            print("Something went wrong")
        }
        currentVC.dismiss(animated: true, completion: nil)
    }
    
}
