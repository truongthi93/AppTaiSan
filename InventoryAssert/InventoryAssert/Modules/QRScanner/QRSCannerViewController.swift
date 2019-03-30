//
//  QRSCannerViewController.swift
//  InventoryAssert
//
//  Created by TruongThi on 12/22/18.
//  Copyright © 2018 Hospital. All rights reserved.
//

import UIKit
import AVFoundation

protocol AddQRCodeDelegate: class {
    func addData(dataId : String)
}

class QRSCannerViewController: BaseViewController , AVCaptureMetadataOutputObjectsDelegate{
    @IBOutlet weak var qrCodeView: UIView!
    
    var captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    weak var delegate: AddQRCodeDelegate?
    
    private let supportedCodeTypes = [AVMetadataObject.ObjectType.upce,
                                      AVMetadataObject.ObjectType.code39,
                                      AVMetadataObject.ObjectType.code39Mod43,
                                      AVMetadataObject.ObjectType.code93,
                                      AVMetadataObject.ObjectType.code128,
                                      AVMetadataObject.ObjectType.ean8,
                                      AVMetadataObject.ObjectType.ean13,
                                      AVMetadataObject.ObjectType.aztec,
                                      AVMetadataObject.ObjectType.pdf417,
                                      AVMetadataObject.ObjectType.itf14,
                                      AVMetadataObject.ObjectType.dataMatrix,
                                      AVMetadataObject.ObjectType.interleaved2of5,
                                      AVMetadataObject.ObjectType.qr]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        darkMode = false
        setNeedsStatusBarAppearanceUpdate()
        
        // Get the back-facing camera for capturing videos
        let deviceDiscoverySession = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .back)
        
        guard let captureDevice = deviceDiscoverySession else {
            print("Failed to get the camera device")
            return
        }
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Set the input device on the capture session.
            captureSession.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
            //            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
        
        // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        
        guard let layer = videoPreviewLayer else {
            return
        }
        view.layer.addSublayer(layer)
        
        // Start video capture.
        captureSession.startRunning()
    }
    
    @objc func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = UIColor.navigationBarColor
        navigationController?.navigationBar.isTranslucent = false
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.navigationTextColor]
        navigationController?.navigationBar.tintColor = UIColor.navigationTextColor
        
        
        self.title = Constants.QASCanner.title
        let backButton = UIBarButtonItem(image: UIImage(named: "back.png"), style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem  = backButton
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Helper methods
    
//    func launchApp(decodedURL: String) {
//
//        if presentedViewController != nil {
//            return
//        }
//
//        let alertPrompt = UIAlertController(title: "Open App", message: "You're going to open \(decodedURL)", preferredStyle: .actionSheet)
//        let confirmAction = UIAlertAction(title: "Confirm", style: UIAlertAction.Style.default, handler: { (action) -> Void in
//
//            if let url = URL(string: decodedURL) {
//                if UIApplication.shared.canOpenURL(url) {
//                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
//                }
//            }
//        })
//
//        let cancelAction = UIAlertAction(title: "Hủy Bỏ", style: UIAlertAction.Style.cancel, handler: nil)
//
//        alertPrompt.addAction(confirmAction)
//        alertPrompt.addAction(cancelAction)
//
//        present(alertPrompt, animated: true, completion: nil)
//    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            qrCodeView?.frame = CGRect.zero
            Utility.showAlertInform(title:Constants.AppCommon.note, message:Constants.AppCommon.messgaeScanNotFound, context: self)
            print("Khong tim thay ket qua scan")
            captureSession.stopRunning()
            return
        }
        
        // Get the metadata object.
        guard let metadataObj = metadataObjects[0] as? AVMetadataMachineReadableCodeObject else {
            captureSession.stopRunning()
            return
        }
        
        if supportedCodeTypes.contains(metadataObj.type) {
            // If the found metadata is equal to the QR code metadata (or barcode) then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeView?.frame = barCodeObject?.bounds ?? CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 0, height: 0))
            
            if metadataObj.stringValue != nil {
//                launchApp(decodedURL: metadataObj.stringValue ?? "")
                print("Ket qua scan: \(metadataObj.stringValue ?? "")")
                
                let cancelAction = UIAlertAction(title: Constants.AppCommon.done, style: UIAlertAction.Style.cancel){ (aa) in
                    self.captureSession.stopRunning()
                    let vc = ConfirmAssetInfoViewController(nibName: Constants.ConfirmAssetInfo.confirmAssetInfoViewController, bundle: nil)
                    vc.assetId = metadataObj.stringValue ?? ""
                    vc.delegate  = self
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
                Utility.showAlert(title: Constants.AppCommon.inform, message: "\(Constants.QASCanner.resultScan) \(metadataObj.stringValue ?? "")", buttons: [cancelAction], context: self)
                captureSession.stopRunning()
                return
            }
        }
    }
}

extension QRSCannerViewController: ConfirmAddAssetDelegate {
    func confirmAddAsset(isConfirmed : Bool, dataId: String){
        if isConfirmed{
            self.dismiss(animated: true, completion: nil)
            self.delegate?.addData(dataId: dataId)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
