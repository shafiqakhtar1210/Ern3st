//
//  UIView+Ext.swift
//  Ern3st
//
//  Created by Muhammad Ali on 25/07/2023.
//

import UIKit
extension UIView{
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
            layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    func addShadowWithUpperCorner(radius: CGFloat){
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            self.layer.shadowRadius = 5.0
            self.layer.shadowOpacity = 0.4
            self.layer.cornerRadius = radius
            self.layer.shadowColor = UIColor.gray.cgColor
           
          }
    func addShadowWithLowerCorner(radius: CGFloat){
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            self.layer.shadowRadius = 5.0
            self.layer.shadowOpacity = 0.4
            self.layer.cornerRadius = radius
            self.layer.shadowColor = UIColor.gray.cgColor
           
          }
    func addShadow(radius: CGFloat){
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner,.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 0.4
        self.layer.cornerRadius = radius
        self.layer.shadowColor = UIColor.gray.cgColor
           
          }
    func addBlurEffect(){
        let blurredView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blurredView.frame = self.bounds
        self.addSubview(blurredView)
        
    }
    func removeBlurView(){
        for subview in self.subviews {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
            }
        }    }
    func shake() {
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.05
            animation.repeatCount = 5
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 5.0, y: self.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 5.0, y: self.center.y))
            self.layer.add(animation, forKey: "position")
        }
    func shake(count : Float = 4,for duration : TimeInterval = 0.5,withTranslation translation : Float = 5) {

        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [translation, -translation]
        layer.add(animation, forKey: "shake")
    }
    func goRound(){
        self.layer.cornerRadius = self.frame.width/2
        self.clipsToBounds = true
        
    }
}
