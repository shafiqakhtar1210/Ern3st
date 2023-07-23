//
//  ToggleLabel.swift
//  Ern3st
//
//  Created by Muhammad Ali on 27/06/2023.
//

import UIKit
class ToggleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGestureRecognizers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGestureRecognizers()
    }
    
    private func setupGestureRecognizers() {
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelTapped)))
    }
    
    @objc private func labelTapped() {
        text = (text == "MALE") ? "FEMALE" : "MALE"
    }
}
