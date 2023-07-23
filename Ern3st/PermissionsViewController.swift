//
//  PermissionsViewController.swift
//  Ern3st
//
//  Created by Muhammad Ali on 05/02/2023.
//

import UIKit

class PermissionsViewController: BaseViewController {
    @IBOutlet weak var proceedBtn: UIButton!
  
    
    @IBOutlet weak var permissionLabel: UILabel!
    @IBOutlet weak var declineBtn: UIButton!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var descriptionTV: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let font = UIFont(name: "PanamaMonospace-Regular", size: 20)!
        let font_btn = UIFont(name: "PanamaMonospace-Regular", size: 25)!
        declineBtn.underlineTextWithCustomFont(text: "DECLINE", font: font_btn, underlineStyle: .single)
        proceedBtn.underlineTextWithCustomFont(text: "PROCEED", font: font_btn, underlineStyle: .single)

        // Call the function to underline the text with a custom font
        descriptionTV.underlineWithCustomFont(text: "PLEASE NOTE THAT THIS APP REQUIRES ACCESS TO TRUE DEPTH CAMERA IN ORDER TO TAKE 3D SCAN OF YOUR BODY MEASUREMENT", font: font, underlineStyle: .single)
        // Call the function to underline the text with a custom font
      
        
       
     
        UIView.animate(withDuration: 0.6,
                       animations: { [self] in
                self.icon.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
            self.permissionLabel.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
            self.descriptionTV.alpha = 0.0
            self.proceedBtn.alpha = 0.0
            self.declineBtn.alpha = 0.0        },
            completion: { _ in
            UIView.animate(withDuration: 1.0) { [self] in
                    self.icon.transform = CGAffineTransform.identity
                self.permissionLabel.transform = CGAffineTransform.identity
                self.descriptionTV.alpha = 1.0
                self.proceedBtn.alpha = 1.0
                self.declineBtn.alpha = 1.0
                
                }
            })
      
    
        descriptionTV.textColor = .white
        
        
        // Do any additional setup after loading the view.
    }
    @IBAction func dismissApp(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
             DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
              exit(0)
             }
        }    }
    

    /*
     Please note that this app requires access to TrueDepth Cameras of your iOS Device in order to take 3d scan of your body to take your measurements.
    */
    //Permissions Required

}
