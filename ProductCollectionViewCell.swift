//
//  ProductCollectionViewCell.swift
//  Ern3st
//
//  Created by Muhammad Ali on 19/12/2022.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productInfoLabel: CustomLabel!
    @IBOutlet weak var productInfoView: UIView!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    func configCell(product: Product){
        productImageView.loadFrom(URLAddress: product.productImageUrl)
        productInfoLabel.text = "\(product.productName) /$\(product.productRegPrice)"
        
    }
   
   
}
