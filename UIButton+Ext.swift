//
//  UIButton+Ext.swift
//  Ern3st
//
//  Created by Muhammad Ali on 28/04/2023.
//

import UIKit
extension UIButton {
    func underlineTextWithCustomFont(text: String, font: UIFont, underlineStyle: NSUnderlineStyle) {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: underlineStyle.rawValue, range: NSRange(location: 0, length: attributedString.length))
        self.setAttributedTitle(attributedString, for: .normal)
    }

    


}
