//
//  MainViewController.swift
//  InventoryAssert
//
//  Created by mac on 11/10/18.
//  Copyright © 2018 Hospital. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    let items = Constants.MainView.listFunction
    override func viewDidLoad() {
        super.viewDidLoad()

        darkMode = false
        setNeedsStatusBarAppearanceUpdate()

        //Delegate, Datasource
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: Constants.MainView.itemsCollectionViewCell, bundle: nil), forCellWithReuseIdentifier:Constants.MainView.itemsCollectionViewCell)
        
        //edit size fr items
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.collectionViewLayout = layout
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        self.title = Constants.MainView.title
        self.navigationItem.setHidesBackButton(true, animated:true);

        navigationController?.navigationBar.barTintColor = UIColor.navigationBarColor
        navigationController?.navigationBar.isTranslucent = false

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.navigationTextColor]
        navigationController?.navigationBar.tintColor = UIColor.navigationTextColor

        
        let logout = UIBarButtonItem(image: UIImage(named: "logout.png"), style: .plain, target: self, action: #selector(userLogout))
        self.navigationItem.rightBarButtonItem  = logout
    }
    
    @objc func userLogout() {
        let buttonOk = UIAlertAction(title: Constants.AppCommon.agree, style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        })
        
        let buttonCancel = UIAlertAction(title: Constants.AppCommon.cancel, style: .cancel, handler: { (action) in
            //self.dismiss(animated: true, completion: nil)
        })
        Utility.showAlert(title: Constants.AppCommon.note, message: Constants.AppCommon.messageLogout, buttons: [buttonOk, buttonCancel], context: self)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //device screen size
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        //calculation of cell size
        return CGSize(width: ((width / 2) - 15), height: (height / 3) - 55)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.MainView.itemsCollectionViewCell, for: indexPath) as! ItemsCollectionViewCell
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.lblItemTitle?.text = self.items[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            let vc = InventoryReviewViewController(nibName: Constants.InventoryReview.inventoryReviewViewController, bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
            print("Tap Items 1")
            break
        case 1:
            let vc = InformErrorBrokenViewController(nibName: Constants.InformErrorBroken.informErrorBrokenViewController, bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
            print("Tap Items 2")
            break
        case 2:
            print("Tap Items 3")
            break
        case 3:
            print("Tap Items 4")
        case 4:
            print("Tap Items 5")
            break
        case 5:
            print("Tap Items 6")
            break
        default:
            break
        }
    }
    
}
