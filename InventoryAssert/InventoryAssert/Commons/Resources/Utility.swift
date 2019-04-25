//
//  Utility.swift
//  InventoryAssert
//
//  Created by TruongThi on 12/14/18.
//  Copyright © 2018 Hospital. All rights reserved.
//
import Foundation
import UIKit
import Photos

class Utility {
    /// Show Alert
    ///
    /// - Parameters:
    ///   - title: String
    ///   - message: String
    ///   - buttons: [UIAlertAction]
    ///   - controller: UIViewController /*controller show alert*/
    class func showAlert(title: String,message: String,buttons: [UIAlertAction],context: UIViewController) {
        let tempMessage = message
        let alert = UIAlertController(title: title, message: tempMessage, preferredStyle: .alert)
        for button in buttons {
            alert.addAction(button)
        }
        context.present(alert, animated: true, completion: nil)
    }
    
    /// show alert validate data in form
    ///
    /// - Parameters:
    ///   - message: String
    ///   - controller: UIViewController /* View Controller show alert */
    class func showAlertInform(title: String, message: String, context:UIViewController) {
        let btnOK = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel, handler: nil)
        btnOK.setValue(UIColor.black, forKey: "titleTextColor")
        self.showAlert(title: title, message: message, buttons: [btnOK], context: context)
    }
    
    /// Get the date string from date.
    ///
    /// - Parameter dateTime: the date.
    /// - Returns: the date as String.
    class func formatDateString(dateTime: Date) -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy/MM/dd"
        format.timeZone = TimeZone(identifier: "UTC")
        return format.string(from: dateTime)
    }
    
    
    /// Validate format the email.
    ///
    /// - Parameter testStr: the email as String
    /// - Returns: bool value : true is valid and false is invalid.
    class func isValidEmail(testStr: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    /// Validate the email.
    ///
    /// - Parameter email: the email as String
    /// - Returns: bool value : true is valid and false is invalid.
    class func validateEmailInform(email: String, context: UIViewController) -> Bool {
        guard email != "" else {
            showAlertInform(title: "", message: NSLocalizedString("Alert.FieldIsRequired" , comment: ""), context: context)
            return false
        }
        
        guard Utility.isValidEmail(testStr: email) == true else {
            showAlertInform(title: NSLocalizedString("Alert.TitleIncorrectEmail", comment: ""), message: NSLocalizedString("Alert.MessageIncorrectEmail", comment: ""), context: context)
            return false
        }
        return true
    }
    
    /// Validate the password.
    ///
    /// - Parameter password: the password as String
    /// - Returns: bool value : true is valid and false is invalid.
    class func validatePasswordInform(password: String, context: UIViewController) -> Bool {
        guard password != "" else {
            showAlertInform(title: "", message: "", context: context)
            return false
        }
        return true
    }
    
    /// show loading
    ///
    /// - Parameter view: UIView
    class func showIndicator(view: UIView) {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.center = view.center
        indicator.tag = Constants.Login.tagIndicator
        view.isUserInteractionEnabled = false
        view.addSubview(indicator)
        indicator.startAnimating()
    }
    
    /// hide Loading
    ///
    /// - Parameter view: UIView
    class func hideIndicator(view: UIView) {
        for subView in view.subviews {
            if subView.tag == Constants.Login.tagIndicator {
                (subView as! UIActivityIndicatorView).stopAnimating()
                subView.removeFromSuperview()
                view.isUserInteractionEnabled = true
            }
        }
    }
    
    class func convertDateTimeFromServer(dtString: String) -> String{
        print("- " + dtString)
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.zz"
        
        guard let date = dateFormatter.date(from: dtString) else {
            return ""
        }
        dateFormatter.dateFormat = "dd-MM-yyyy (HH:mm)"
        dateFormatter.locale = tempLocale // reset the locale
        let dateString = dateFormatter.string(from: date)
        print("EXACT_DATE : \(dateString)")
        return dateString
    }
    
    /// Get the date string from date.
    ///
    /// - Parameter dateTime: the date.
    /// - Returns: the date as String.
    class func convertDateString(dateTime: String) -> String {
         //CONVERT FROM String to Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: dateTime)
        
        //CONVERT FROM Date to String
        dateFormatter.dateFormat =  Constants.AppCommon.formatDate
        let dateString = dateFormatter.string(from: date ?? Date())
        print("Ngay DATE......\(dateString)")
        return dateString
    }
    
    class func showDatePicker(datePicker: UIDatePicker, textField: UITextField, buttons: [UIBarButtonItem]){
        //Formate Date
        datePicker.datePickerMode = .date
        datePicker.locale = Locale.init(identifier: "vi")
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        toolbar.setItems(buttons, animated: false)
        textField.inputAccessoryView = toolbar
        textField.inputView = datePicker
    }
    
    class func showInputTextFieldPicker(pickerView: UIPickerView, textField: UITextField, buttons: [UIBarButtonItem]){
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        toolbar.setItems(buttons, animated: false)
        textField.inputAccessoryView = toolbar
        textField.inputView = pickerView
    }

    /// ConvertPHAAssertToImage
    ///
    /// - Parameter asset:
    /// - Returns:
    class func convertAssertToImage(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width:300.0, height: 300.0), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
            thumbnail = result!
        })
        return thumbnail
    }
    
}

