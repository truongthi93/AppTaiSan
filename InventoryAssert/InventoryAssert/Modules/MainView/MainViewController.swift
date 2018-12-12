//
//  MainViewController.swift
//  InventoryAssert
//
//  Created by mac on 11/10/18.
//  Copyright © 2018 Hospital. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    let items = Constants.MainView.listFunction
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.title = Constants.MainView.title
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        //Delegate, Datasource
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ItemsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemsCollectionViewCell")
        
        //edit size fr items
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.collectionViewLayout = layout
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //device screen size
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        //calculation of cell size
        return CGSize(width: ((width / 2) - 15), height: (height / 3) - 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemsCollectionViewCell", for: indexPath) as! ItemsCollectionViewCell
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
            print("Tap Items 1")
            break
        case 1:
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
