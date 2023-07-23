//
//  ProductCollectionView.swift
//  Ern3st
//
//  Created by Muhammad Ali on 26/04/2023.
//

import UIKit

class ProductCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let animationDuration: TimeInterval = 0.8
    let animationDelay: TimeInterval = 0.25
    var cellHasBeenAnimated: [Bool] = []
   

    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath as IndexPath) as! ProductCollectionViewCell
        
       
        let product = GlobalUserData.products[indexPath.row]
        
       cell.configCell(product: product)
            
           
        
        return cell
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.dataSource = self
        self.delegate = self
        let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
        let flowLayout = UICollectionViewFlowLayout()
        let numberOfItemsPerRow = 1.0
        let itemSpacing = 0.0
        let lineSpacing = 0.0
        flowLayout.scrollDirection = .vertical
        
        let width = self.bounds.width
        let height = self.bounds.height
        flowLayout.itemSize = CGSize(width: width, height: height)
        flowLayout.minimumInteritemSpacing = itemSpacing
        flowLayout.sectionInset = UIEdgeInsets(top: lineSpacing, left: lineSpacing, bottom: lineSpacing, right: lineSpacing)
        self.collectionViewLayout = flowLayout
        cellHasBeenAnimated = Array(repeating: false, count: self.numberOfItems(inSection: 0))
    }
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        cellHasBeenAnimated = Array(repeating: false, count: GlobalUserData.products.count)
        return GlobalUserData.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        
        
       
    }
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
            if cellHasBeenAnimated[indexPath.row] == false {
                cell.alpha = 0
                cell.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                UIView.animate(withDuration: 1.2, delay: 0.2 * Double(indexPath.row), usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: .curveEaseInOut, animations: {
                    cell.alpha = 1
                    cell.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: nil)
                cellHasBeenAnimated[indexPath.row] = true
            }
        
        
    }
   
    
    
    
}
