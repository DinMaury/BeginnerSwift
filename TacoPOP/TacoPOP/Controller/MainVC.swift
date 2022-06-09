//
//  MainVC.swift
//  TacoPOP
//
//  Created by Maury on 31/05/22.
//

import UIKit

class MainVC: UIViewController, DataServiceDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var ds: DataService = DataService.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ds.delegate = self
        ds.loadDeliciousTacoData()
        ds.tacoArray.shuffle1()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        configureBar()
        /*
        let nib = UINib(nibName: "TacoCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "TacoCell")
        */
        collectionView.register(TacoCell.self)
    }
    

    // MARK: - Navigation
    
    private func configureBar() {
        
        let titleImageView: UIImageView = UIImageView(image: UIImage.init(named: "TacoPOP"))
        navigationItem.titleView = titleImageView
        navigationController?.navigationBar.backgroundColor = .init(red: 0, green: 1, blue: 0, alpha: 0.7)
    }
    
    //MARK: --------
     
    
    
    //MARK: Protocol: DataServiceDelegate
    func deliciousTacoDataLoaded() {
        print("Delicious Taco Data Loaded!")
        collectionView.reloadData()
    }
    //MARK: ----------
}

//MARK: CollectionView
extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ds.tacoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TacoCell", for: indexPath) as? TacoCell {
//            cell.configureCell(taco: ds.tacoArray[indexPath.row])
//            return cell
//        }
//        return UICollectionViewCell()
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as TacoCell
        cell.configureCell(taco: ds.tacoArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? TacoCell {
            cell.shake()
        }
            
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 95, height: 95)
        //return CGSize(width: 95, height: 95)
    }
}
//MARK: --------
