//
//  Helpers.swift
//  Ern3st
//
//  Created by Muhammad Ali on 25/02/2023.
//

import UIKit
class Helper{
    static func displayGif(imageView: UIImageView){
        guard let gifUrl = Bundle.main.url(forResource: "example_gif", withExtension: "gif") else { return }
           guard let imageData = try? Data(contentsOf: gifUrl) else { return }
           let imageGif = UIImage.gifImageWithData(imageData)
           imageView.image = imageGif
        
    }
}
