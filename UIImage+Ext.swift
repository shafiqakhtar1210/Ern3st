//
//  UIImage+Ext.swift
//  Ern3st
//
//  Created by Muhammad Ali on 09/12/2022.
//

import UIKit
extension UIImage {
    func imageWithColor(color1: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color1.setFill()

        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)

        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
 

 
    static func gifImageWithData(_ data: Data) -> UIImage? {
           guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
               print("Error: Source for the image does not exist")
               return nil
           }
           let count = CGImageSourceGetCount(source)
           var images = [UIImage]()
           var gifDuration = 0.0
           for i in 0..<count {
               guard let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) else { continue }
               let duration = getFrameDuration(from: source, at: i)
               gifDuration += duration
               let uiImage = UIImage(cgImage: cgImage)
               images.append(uiImage)
           }
           let animatedImage = UIImage.animatedImage(with: images, duration: gifDuration)
           return animatedImage
       }

       static func getFrameDuration(from source: CGImageSource, at index: Int) -> Double {
           guard let properties = CGImageSourceCopyPropertiesAtIndex(source, index, nil) as? [CFString: Any],
                 let gifProperties = properties[kCGImagePropertyGIFDictionary] as? [CFString: Any],
                 let delayTime = gifProperties[kCGImagePropertyGIFDelayTime] as? Double
           else { return 0.1 }
           return delayTime > 0 ? delayTime : 0.1
       }
   }

  
