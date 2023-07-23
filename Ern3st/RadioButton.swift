//
//  RadioButton.swift
//  Ern3st
//
//  Created by Muhammad Ali on 01/06/2023.
//
import UIKit

class RadioButton: UIButton {
    var alternateButton:Array<RadioButton>?
    let checkedImage = UIImage(named: "checked")! as UIImage
    let uncheckedImage = UIImage(named: "unchecked")! as UIImage
    override func awakeFromNib() {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2.0
        self.layer.masksToBounds = true
    }
    
    func unselectAlternateButtons() {
        if alternateButton != nil {
            self.isSelected = true
            
            for aButton:RadioButton in alternateButton! {
                aButton.isSelected = false
            }
        } else {
            toggleButton()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        unselectAlternateButtons()
        super.touchesBegan(touches, with: event)
    }
    
    func toggleButton() {
        self.isSelected = !isSelected
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.setImage(checkedImage, for: .normal)
                if let alternateButtons = alternateButton{
                    self.unselectAlternateButtons()
                }
               
                
            } else {
                self.setImage(uncheckedImage, for: .normal)            }
        }
    }
}
