//
//  UILabel+Ext.swift
//  Ern3st
//
//  Created by Muhammad Ali on 17/06/2023.
//

import UIKit
extension UILabel {
    func underlineWithCustomFont(text: String, font: UIFont, underlineStyle: NSUnderlineStyle) {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: underlineStyle.rawValue, range: NSRange(location: 0, length: attributedString.length))
        self.attributedText = attributedString
    }
    @IBInspectable var underlinedText: String? {
           get {
               return text
           }
           set {
               if let text = newValue {
                   let attributedString = NSMutableAttributedString(string: text)
                   attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributedString.length))
                   attributedText = attributedString
               } else {
                   attributedText = nil
               }
           }
       }
       
       @IBInspectable var customFontName: String? {
           get {
               return font.fontName
           }
           set {
               if let fontName = newValue, let fontSize = font?.pointSize {
                   font = UIFont(name: fontName, size: fontSize)
               }
           }
       }
    @IBInspectable var customFontSize: CGFloat {
            get {
                return font.pointSize
            }
            set {
                if let fontName = font?.fontName {
                    font = UIFont(name: fontName, size: newValue)
                }
            }
        }
}
