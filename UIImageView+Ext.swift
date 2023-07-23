//
//  UIImageView+Ext.swift
//  Ern3st
//
//  Created by Muhammad Ali on 19/12/2022.
//

import UIKit
extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
               print("Error! Invalid URL!") //Do something else
               return
           }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (responseData, _, _) -> Void in
            if let loadedImage = UIImage(data: responseData!) {
                DispatchQueue.main.async {
                    self.image = loadedImage
                }
                
                   
            }
              
           }.resume()

                              
       /* DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }*/
    }
}
