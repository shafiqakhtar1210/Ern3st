//
//  Product.swift
//  Ern3st
//
//  Created by Muhammad Ali on 12/12/2022.
//

import Foundation
class Product{
    var productCategory: String
    var productName: String
    var productDescription: String
    var productImageUrl: String
    var productRegPrice: String
    var productDiscPrice: String
    var proudctId: String
    init(productCategory: String, productName: String, productDescription: String, productImageUrl: String, productRegPrice: String, productDiscPrice: String, proudctId: String) {
        self.productCategory = productCategory
        self.productName = productName
        self.productDescription = productDescription
        self.productImageUrl = productImageUrl
        self.productRegPrice = productRegPrice
        self.productDiscPrice = productDiscPrice
        self.proudctId = proudctId
    }
  
 
}
