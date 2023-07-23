//
//  CustomLabel.swift
//  Ern3st
//
//  Created by Muhammad Ali on 08/12/2022.
//

import UIKit

class CustomLabel: UILabel {
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBInspectable var fontName: String = "HelveticaNeue-Medium" {
        didSet {
            self.font = UIFont.init(name: fontName, size: fontSize)
        }
    }

    @IBInspectable var fontSize: CGFloat = 12 {
        didSet {
            self.font = UIFont.init(name: fontName, size: fontSize)
        }
    }
}
