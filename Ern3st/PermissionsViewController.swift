//
//  PermissionsViewController.swift
//  Ern3st
//
//  Created by Muhammad Ali on 05/02/2023.
//

import UIKit
import SwiftUI

class PermissionsViewController: BaseViewController {
    @IBOutlet weak var proceedBtn: UIButton!
  
    
    @IBOutlet weak var permissionLabel: UILabel!
    @IBOutlet weak var declineBtn: UIButton!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var descriptionTV: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let font = UIFont(name: "PanamaMonospace-Regular", size: 16)!
    
        let font_btn = UIFont(name: "PanamaMonospace-Regular", size: 20)!
        declineBtn.underlineTextWithCustomFont(text: "DECLINE", font: font_btn, underlineStyle: .single)
        proceedBtn.underlineTextWithCustomFont(text: "PROCEED", font: font_btn, underlineStyle: .single)
        permissionLabel.font = UIFont(name:"GaramondLight-Italic",size:40)
        // Call the function to underline the text with a custom font
        descriptionTV.underlineWithCustomFont(text: "PLEASE NOTE THAT THIS APP REQUIRES \n ACCESS TO YOUR IOS TRUE DEPTH \n SETTINGS IN ORDER TO MAKE 3D \n SCAN OF YOUR MEASUREMENTS", font: font, underlineStyle: .single)
        descriptionTV.textAlignment = .center
        
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
                self.proceedBtn.alpha = 0.5
                self.declineBtn.alpha = 0.5
                
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
struct RepresentablePermissionView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> PermissionsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myViewController = storyboard.instantiateViewController(withIdentifier: "PermissionVC") as! PermissionsViewController
        return myViewController
    }
    
    func updateUIViewController(_ uiViewController: PermissionsViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = PermissionsViewController
    
  
    
    

    

}
struct GetPermissionsView: PreviewProvider{
    static var previews: some View{
        RepresentablePermissionView()
    }
    
    
    
}
