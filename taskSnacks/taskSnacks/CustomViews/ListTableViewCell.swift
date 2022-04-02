//
//  ListTableViewCell.swift
//  taskSnacks
//
//  Created by Kishore on 16/10/20.
//  Copyright © 2020 Kishore. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    //MARK:- IBOutlets
    @IBOutlet weak var itemsCollectionView: UICollectionView!
    
    //MARK:- Constants and Variables
    var imagesArr = [#imageLiteral(resourceName: "Pizza"),#imageLiteral(resourceName: "Burgers"),#imageLiteral(resourceName: "beverages")]
    var timer : Timer?
    var currentIndex = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        itemsCollectionView.delegate = self
        itemsCollectionView.dataSource = self
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
    }
    
    //MARK:- Additional Functions
    @objc func slideToNext() {
        if currentIndex < imagesArr.count-1{
            currentIndex = currentIndex + 1
            
        }else{
            currentIndex = 0
        }
        itemsCollectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .right, animated: true)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//MARK:- UICollectionViewDelegate And UICollectionViewDataSource

extension ListTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = itemsCollectionView.dequeueReusableCell(withReuseIdentifier: "ItemsCollectionViewCell", for: indexPath) as! ItemsCollectionViewCell
        cell.itemImage.image = imagesArr[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: itemsCollectionView.frame.width, height: itemsCollectionView.frame.height)
    }
  
    
}
